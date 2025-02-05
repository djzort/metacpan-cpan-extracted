#include "std.h"

DLLEXPORT void ReturnVoid(int in) {
    return;
}
DLLEXPORT bool ReturnBool(int in) {
    if (in == 5) return true;
    return false;
}

DLLEXPORT int ReturnInt() {
    return 101;
}

DLLEXPORT int ReturnNegInt() {
    return -101;
}

DLLEXPORT short ReturnShort() {
    return 102;
}

DLLEXPORT short ReturnNegShort() {
    return -102;
}

DLLEXPORT signed char ReturnByte() {
    return -103;
}

DLLEXPORT double ReturnDouble() {
    return 99.9;
}

DLLEXPORT float ReturnFloat() {
    return (float)-4.5;
}

DLLEXPORT char *ReturnString() {
    return "epic cuteness";
}

DLLEXPORT char *ReturnNullString() {
    return NULL;
}

DLLEXPORT int64_t ReturnInt64() {
    return 0xFFFFFFFFFF;
}

DLLEXPORT int64_t ReturnNegInt64() {
    return -0xFFFFFFFFFF;
}

DLLEXPORT unsigned char ReturnUint8() {
    return 0xFE;
}

DLLEXPORT unsigned short ReturnUint16() {
    return 0xFFFE;
}

DLLEXPORT unsigned int ReturnUint32() {
    return 0xFFFFFFFE;
}
