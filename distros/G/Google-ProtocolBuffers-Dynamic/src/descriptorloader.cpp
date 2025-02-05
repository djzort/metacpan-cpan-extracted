#include "descriptorloader.h"
#include "unordered_map.h"

#include <google/protobuf/duration.pb.h>
#include <google/protobuf/timestamp.pb.h>
#include <google/protobuf/wrappers.pb.h>

#include "EXTERN.h"
#include "perl.h"

using namespace google::protobuf::compiler;
using namespace google::protobuf;
using namespace gpd;
using namespace std;

namespace {
    const string wkt_prefix = "google.protobuf";
    STD_TR1::unordered_map<string, string> wkt_types_to_file;
    STD_TR1::unordered_set<string> wkt_files;

    // it seems the only way to add a Descriptor to a pool is to go through the Proto object
    void add_descriptor_to_pool(DescriptorPool *pool, const Descriptor *descriptor) {
        const FileDescriptor *file_descriptor = descriptor->file();
        FileDescriptorProto file_proto;

        file_descriptor->CopyTo(&file_proto);
        pool->BuildFile(file_proto);

        for (int j = 0, max = file_proto.message_type_size(); j < max; ++j) {
            const DescriptorProto &message = file_proto.message_type(j);
            const string full_name = file_proto.package() + "." + message.name();

            wkt_types_to_file.insert(make_pair(full_name, file_proto.name()));
        }

        wkt_files.insert(file_proto.name());
    }

    STD_TR1::unordered_set<string> find_wkt_files(const FileDescriptorProto &file) {
        const string &package = file.package();
        STD_TR1::unordered_set<string> wkt_files;

        if (package != wkt_prefix)
            return wkt_files;

        // for well-known-types, use the compiled-in version. This
        // version of the code handles also in-tree copies of WKT
        // .proto files
        for (int j = 0, max = file.message_type_size(); j < max; ++j) {
            const DescriptorProto &message = file.message_type(j);
            const string full_name = package + "." + message.name();

            STD_TR1::unordered_map<string, string>::iterator entry = wkt_types_to_file.find(full_name);
            if (entry != wkt_types_to_file.end())
                wkt_files.insert(entry->second);
        }

        return wkt_files;
    }
}

void DescriptorLoader::ErrorCollector::AddError(const string &filename, const string &element_name, const Message *descriptor, DescriptorPool::ErrorCollector::ErrorLocation location, const string &message) {
    if (!errors.empty())
        errors += "\n";

    errors +=
        "Error processing serialized protobuf descriptor: " +
        filename +
        ": " +
        message;
}

void DescriptorLoader::ErrorCollector::AddWarning(const string &filename, const string &element_name, const Message *descriptor, DescriptorPool::ErrorCollector::ErrorLocation location, const string &message) {
    warn("Processing serialized protobuf descriptor: %s: %s", filename.c_str(), message.c_str());
}

DescriptorLoader::DescriptorLoader(SourceTree *source_tree,
                                   MultiFileErrorCollector *error_collector) :
        source_database(source_tree),
        binary_database(binary_pool),
        merged_database(&binary_database, &source_database),
        merged_pool(&merged_database, source_database.GetValidationErrorCollector()) {
    merged_pool.EnforceWeakDependencies(true);
    source_database.RecordErrorsTo(error_collector);

    #define ADD_WKT_FILE(name) add_descriptor_to_pool(&binary_pool, google::protobuf:: name ::descriptor())

    // only one WKT per .proto file is needed
    ADD_WKT_FILE(Duration);
    ADD_WKT_FILE(Timestamp);
    ADD_WKT_FILE(DoubleValue); // all types in wrappers.proto

    #undef ADD_WKT
}

DescriptorLoader::~DescriptorLoader() { }

const FileDescriptor *DescriptorLoader::load_proto(const string &filename) {
    return merged_pool.FindFileByName(filename);
}

const vector<const FileDescriptor *> DescriptorLoader::load_serialized(const char *buffer, size_t length) {
    FileDescriptorSet fds;
    DescriptorLoader::ErrorCollector collector;

    if (!fds.ParseFromArray(buffer, length))
        croak("Error deserializing message descriptors");
    vector<const FileDescriptor *> result;

    STD_TR1::unordered_set<string> removed_wkt, needed_wkt;
    for (int i = 0, max = fds.file_size(); i < max; ++i) {
        FileDescriptorProto file = fds.file(i);

        // this somewhat dodgy code tries to address cases where
        // WKT .proto files have been copied and imported using a
        // non-standard path.
        //
        // For binary descriptors, this requires the binary descriptor to
        // be skipped, and dependency information to be upated to use the
        // compiled-in WKT descritpros.
        STD_TR1::unordered_set<string> standard_wkt_files = find_wkt_files(file);
        if (!standard_wkt_files.empty()) {
            removed_wkt.insert(file.name());
            needed_wkt.insert(standard_wkt_files.begin(), standard_wkt_files.end());
            continue;
        }

        // See comment above. If this file dependes on WKT descriptors that
        // have been removed, the corresponding dependency need to be adjusted
        // to point to the compiled-in descriptor.
        //
        // The crude and hopefully robust way of doing this is to add a
        // dependency to all compled-in descritprs, that provide types that
        // are used, regardless of whether they are used by a given serialized
        // descriptor
        if (!removed_wkt.empty()) {
            vector<string> dependency(file.dependency().begin(), file.dependency().end());
            bool add_builtin_wkt = false;

            file.clear_dependency();
            for (int j = 0, max = dependency.size(); j < max; ++j) {
                if (removed_wkt.find(dependency[j]) != removed_wkt.end()) {
                    add_builtin_wkt = true;
                } else {
                    file.add_dependency(dependency[j]);
                }
            }

            if (add_builtin_wkt) {
                for (STD_TR1::unordered_set<string>::const_iterator it = needed_wkt.begin(), en = needed_wkt.end(); it != en; ++it)
                    file.add_dependency(*it);
            }
        }

        result.push_back(binary_pool.BuildFileCollectingErrors(file, &collector));
    }

    if (!collector.errors.empty())
        croak("%s", collector.errors.c_str());

    return result;
}
