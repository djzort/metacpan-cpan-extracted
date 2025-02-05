package Yancy::Plugin::Editor;
our $VERSION = '1.088';
# ABSTRACT: Yancy content editor, admin, and management application

#pod =head1 SYNOPSIS
#pod
#pod     use Mojolicious::Lite;
#pod     # The default editor at /yancy
#pod     plugin Yancy => {
#pod         backend => 'sqlite://myapp.db',
#pod         read_schema => 1,
#pod         editor => {
#pod             require_user => { can_edit => 1 },
#pod         },
#pod     };
#pod
#pod     # Enable another editor for blog users
#pod     app->plugin->yancy( Editor => {
#pod         moniker => 'blog_editor',
#pod         backend => app->yancy->backend,
#pod         schema => { blog_posts => app->yancy->schema( 'blog_posts' ) },
#pod         route => app->routes->any( '/blog/editor' ),
#pod         require_user => { can_blog => 1 },
#pod     } );
#pod
#pod =head1 DESCRIPTION
#pod
#pod This plugin contains the Yancy editor application which allows editing
#pod the data in a L<Yancy::Backend>.
#pod
#pod =head1 CONFIGURATION
#pod
#pod This plugin has the following configuration options.
#pod
#pod =head2 backend
#pod
#pod The backend to use for this editor. Defaults to the default backend
#pod configured in the L<main Yancy plugin|Mojolicious::Plugin::Yancy>.
#pod
#pod =head2 schema
#pod
#pod The schema to use to build the editor application. This may not
#pod necessarily be the full and exact schema supported by the backend: You
#pod can remove certain fields from this editor instance to protect them, for
#pod example.
#pod
#pod If not given, will use L<Yancy::Backend/read_schema> to read the schema
#pod from the backend.
#pod
#pod =head2 openapi
#pod
#pod Instead of L</schema>, you can pass a full OpenAPI spec to this editor.
#pod This is deprecated; see L<Yancy::Guides::Upgrading>.
#pod
#pod =head2 default_controller
#pod
#pod The default controller for API routes. Defaults to
#pod L<Yancy::Controller::Yancy>. Building a custom controller can allow for
#pod customizing how the editor works and what content it displays to which
#pod users.
#pod
#pod =head2 moniker
#pod
#pod The name of this editor instance. Used to build helper names and route
#pod names.  Defaults to C<editor>. Other plugins may rely on there being
#pod a default editor named C<editor>. Additional instances should have
#pod different monikers.
#pod
#pod =head2 route
#pod
#pod A base route to add the editor to. This allows you to customize the URL
#pod and add authentication or authorization. Defaults to allowing access to
#pod the Yancy web application under C</yancy>, and the REST API under
#pod C</yancy/api>.
#pod
#pod This can be a string or a L<Mojolicious::Routes::Route> object.
#pod
#pod =head2 return_to
#pod
#pod The URL to use for the "Back to Application" link. Defaults to C</>.
#pod
#pod =head2 title
#pod
#pod The title of the page, shown in the title bar and the page header. Defaults to C<Yancy>.
#pod
#pod =head2 host
#pod
#pod The host to use for the generated OpenAPI spec. Defaults to the current system's hostname
#pod (via L<Sys::Hostname>).
#pod
#pod =head2 info
#pod
#pod An OpenAPI info object, as a Perl hashref. See L<the OpenAPI 2.0
#pod spec|https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#infoObject>
#pod for what keys are allowed in this hashref.
#pod
#pod =head1 HELPERS
#pod
#pod =head2 yancy.editor.include
#pod
#pod     $app->yancy->editor->include( $template_name );
#pod
#pod Include a template in the editor, before the rest of the editor. Use this
#pod to add your own L<Vue.JS|http://vuejs.org> components to the editor.
#pod
#pod =head2 yancy.editor.menu
#pod
#pod     $app->yancy->editor->menu( $category, $title, $config );
#pod
#pod Add a menu item to the editor. The C<$category> is the title of the category
#pod in the sidebar. C<$title> is the title of the menu item. C<$config> is a
#pod hash reference with the following keys:
#pod
#pod =over
#pod
#pod =item component
#pod
#pod The name of a Vue.JS component to display for this menu item. The
#pod component will take up the entire main area of the application, and will
#pod be kept active even after another menu item is selected.
#pod
#pod =back
#pod
#pod Yancy plugins should use the category C<Plugins>. Other categories are
#pod available for custom applications.
#pod
#pod     app->yancy->editor->include( 'plugin/editor/custom_element' );
#pod     app->yancy->editor->menu(
#pod         'Plugins', 'Custom Item',
#pod         {
#pod             component => 'custom-element',
#pod         },
#pod     );
#pod     __END__
#pod     @@ plugin/editor/custom_element.html.ep
#pod     <template id="custom-element-template">
#pod         <div :id="'custom-element'">
#pod             Hello, world!
#pod         </div>
#pod     </template>
#pod     %= javascript begin
#pod         Vue.component( 'custom-element', {
#pod             template: '#custom-element-template',
#pod         } );
#pod     % end
#pod
#pod =for html
#pod <img alt="screenshot of yancy editor showing custom element"
#pod     src="https://raw.github.com/preaction/Yancy/master/eg/doc-site/public/screenshot-custom-element.png?raw=true"
#pod     style="width: 600px; max-width: 100%;" width="600" />
#pod
#pod =head2 yancy.editor.route
#pod
#pod Get the route where the editor will appear.
#pod
#pod =head2 yancy.editor.openapi
#pod
#pod     my $openapi = $c->yancy->openapi;
#pod
#pod Get the L<Mojolicious::Plugin::OpenAPI> object containing the OpenAPI
#pod interface for this Yancy API.
#pod
#pod =head1 TEMPLATES
#pod
#pod To override these templates, add your own at the designated path inside
#pod your app's C<templates/> directory.
#pod
#pod =head2 yancy/editor.html.ep
#pod
#pod This is the main Yancy web application. You should not override this.
#pod Instead, use the L</yancy.editor.include> helper to add new components.
#pod If there is something you can't do using the include helper, consider
#pod L<asking how on the Github issues board|https://github.com/preaction/Yancy/issues>
#pod or L<filing a bug report or feature request|https://github.com/preaction/Yancy/issues>.
#pod
#pod =head1 SEE ALSO
#pod
#pod L<Yancy::Guides::Schema>, L<Mojolicious::Plugin::Yancy>, L<Yancy>
#pod
#pod =cut

use Mojo::Base 'Mojolicious::Plugin';
use Scalar::Util qw( blessed );
use Mojo::JSON qw( true false );
use Mojo::Util qw( url_escape );
use Sys::Hostname qw( hostname );
use Yancy::Util qw( derp currym json_validator load_backend );

has moniker => 'editor';
has route =>;
has includes => sub { [] };
has menu_items => sub { +{} };
has model =>;
has schema =>;
has app => undef, weak => 1;

sub _helper_name {
    my ( $self, $name ) = @_;
    return join '.', 'yancy', $self->moniker, $name;
}

sub register {
    my ( $self, $app, $config ) = @_;

    $config->{title} //= $app->l( 'Yancy' );
    $config->{return_label} //= $app->l( 'Back to Application' );

    if ( $config->{backend} || $config->{schema} ) {
        my $backend = $config->{backend} ? (
          blessed $config->{backend} 
            ? $config->{backend}
            : load_backend( $config->{backend} )
          ) : $app->yancy->backend;
        my $model = Yancy::Model->new(
          backend => $backend,
          ( schema => $config->{schema} )x!!$config->{schema},
          ( read_schema => $config->{read_schema} )x!!exists $config->{read_schema},
        );
        $self->model( $model );
    }
    else {
        $self->model( $app->yancy->model );
    }
    $self->schema( my $schema = $config->{schema} );
    $self->app( $app );

    for my $key ( grep exists $config->{ $_ }, qw( moniker ) ) {
        $self->$key( $config->{ $key } );
    }
    $config->{default_controller} //= $config->{api_controller} // 'Yancy';
    if ( $config->{api_controller} ) {
        derp 'api_controller configuration is deprecated. Use editor.default_controller instead';
    }

    # XXX: Throw an error if there is already a route here
    my $route = $app->yancy->routify( $config->{route}, '/yancy' );
    $route->to( return_to => $config->{return_to} // '/' );

    # Create authentication for editor. We need to delay fetching this
    # callback until after startup is complete so that any auth plugin
    # can be added.
    my $auth_under = sub {
        my ( $c ) = @_;
        state $auth_cb = $c->yancy->can( 'auth' )
                    && $c->yancy->auth->can( 'require_user' )
                    && $c->yancy->auth->require_user( $config->{require_user} || () );
        if ( !$auth_cb && !exists $config->{require_user} && !defined $config->{route} ) {
            $app->log->warn(
                qq{*** Cannot verify that admin editor is behind authentication.\n}
                . qq{Add a Yancy Auth plugin, add a `route` to the Yancy plugin config,\n}
                . qq{or set `editor.require_user => undef` to silence this warning\n}
            );
        }
        return $auth_cb ? $auth_cb->( $c ) : 1;
    };
    $route = $route->under( $auth_under );

    # First create the OpenAPI schema and API URL
    my $spec;
    if ( $config->{openapi} && keys %{ $config->{openapi} } ) {
        $spec = $config->{openapi};
    }
    else {
        # Add OpenAPI spec
        $spec = $self->_openapi_spec_from_schema( $config );
    }
    $self->_openapi_spec_add_mojo( $spec, $config );

    my $openapi = $app->plugin( OpenAPI => {
        route => $route->any( '/api' )->to( model => $self->model )->name( 'yancy.api' ),
        spec => $spec,
        default_response_name => '_Error',
        validator => json_validator(),
    } );
    $_->to(format => 'json') for (@{$openapi->route->children});
    $app->helper( 'yancy.openapi' => sub {
        derp 'yancy.openapi helper is deprecated. Use yancy.editor.openapi instead';
        return $openapi;
    } );
    $app->helper( $self->_helper_name( 'openapi' ) => sub { $openapi } );

    # Do some sanity checks on the config to make sure nothing bad
    # happens
    for my $schema_name ( keys %$schema ) {
        if ( my $view = $schema->{ $schema_name }{ 'x-view' } ) {
            $schema_name = $view->{schema};
        }
        next if $schema->{ $schema_name }{ 'x-view' };
        if ( my $list_cols = $schema->{ $schema_name }{ 'x-list-columns' } ) {
            for my $col ( @$list_cols ) {
                if ( ref $col eq 'HASH' ) {
                    # Check template for columns
                    my @cols = $col->{template} =~ m'\{([^{]+)\}'g;
                    if ( my ( $col ) = grep { !exists $schema->{ $schema_name }{ properties }{ $_ } } @cols ) {
                        die sprintf q{Column "%s" in x-list-columns template does not exist in schema "%s"},
                            $col, $schema_name;
                    }
                }
                else {
                    if ( !exists $schema->{ $schema_name }{ properties }{ $col } ) {
                        die sprintf q{Column "%s" in x-list-columns does not exist in schema "%s"},
                            $col, $schema_name;
                    }
                }
            }
        }
    }

    # Now create the routes and helpers the editor needs
    $route->get( '/' )->name( 'yancy.index' )
        ->to(
            template => 'yancy/index',
            controller => $config->{default_controller},
            action => 'index',
            api_url => $openapi->route->render,
            title => $config->{title},
            return_label => $config->{return_label},
        );
    $route->post( '/upload' )->name( 'yancy.editor.upload' )
        ->to( cb => sub {
            my ( $c ) = @_;
            my $upload = $c->param( 'upload' );
            my $path = $c->yancy->file->write( $upload );
            $c->res->headers->location( $path );
            $c->render( status => 201, text => $path );
        } );

    $app->helper( $self->_helper_name( 'menu' ), currym( $self, '_helper_menu' ) );
    $app->helper( $self->_helper_name( 'include' ), currym( $self, '_helper_include' ) );
    $app->helper( $self->_helper_name( 'route' ), sub { $route } );
    $app->helper( 'yancy.route', sub {
        derp 'yancy.route helper is deprecated. Use yancy.editor.route instead';
        return $self->route;
    } );
    $self->route( $route );


}

sub _helper_include {
    my ( $self, $c, @includes ) = @_;
    if ( @includes ) {
        push @{ $self->includes }, @includes;
    }
    return $self->includes;
}

sub _helper_menu {
    my ( $self, $c, $category, $title, $config ) = @_;
    if ( $config ) {
        push @{ $self->menu_items->{ $category } }, {
            %$config,
            title => $title,
        };
    }
    return $self->menu_items;
}

sub _openapi_find_schema_name {
    my ( $self, $path, $pathspec ) = @_;
    return $pathspec->{'x-schema'} if $pathspec->{'x-schema'};
    my $schema_name;
    for my $method ( grep !/^(parameters$|x-)/, keys %{ $pathspec } ) {
        my $op_spec = $pathspec->{ $method };
        my $schema;
        if ( $method eq 'get' ) {
            # d is in case only has "default" response
            my ($response) = grep /^[2d]/, sort keys %{ $op_spec->{responses} };
            my $response_spec = $op_spec->{responses}{$response};
            next unless $schema = $response_spec->{schema};
        } elsif ( $method =~ /^(put|post)$/ ) {
            my @body_params = grep 'body' eq ($_->{in} // ''),
                @{ $op_spec->{parameters} || [] },
                @{ $pathspec->{parameters} || [] },
                ;
            die "No more than 1 'body' parameter allowed" if @body_params > 1;
            next unless $schema = $body_params[0]->{schema};
        }
        next unless my $this_ref =
            $schema->{'$ref'} ||
            ( $schema->{items} && $schema->{items}{'$ref'} ) ||
            ( $schema->{properties} && $schema->{properties}{items} && $schema->{properties}{items}{'$ref'} );
        next unless $this_ref =~ s:^#/definitions/::;
        die "$method '$path' = $this_ref but also '$schema_name'"
            if $this_ref and $schema_name and $this_ref ne $schema_name;
        $schema_name = $this_ref;
    }
    if ( !$schema_name ) {
        ($schema_name) = $path =~ m#^/([^/]+)#;
        die "No schema found in '$path'" if !$schema_name;
    }
    $schema_name;
}

# mutates $spec
sub _openapi_spec_add_mojo {
    my ( $self, $spec, $config ) = @_;
    for my $path ( keys %{ $spec->{paths} } ) {
        my $pathspec = $spec->{paths}{ $path };
        my $schema = $self->_openapi_find_schema_name( $path, $pathspec );
        die "Path '$path' had non-existent schema '$schema'"
            if !$spec->{definitions}{$schema};
        for my $method ( grep !/^(parameters$|x-)/, keys %{ $pathspec } ) {
            my $op_spec = $pathspec->{ $method };
            my $mojo = $self->_openapi_spec_infer_mojo( $path, $pathspec, $method, $op_spec );
            # XXX Allow overriding controller on a per-schema basis
            # This gives more control over how a certain schema's items
            # are written/read from the database
            $mojo->{controller} = $config->{default_controller};
            $mojo->{schema} = $schema;
            my @filters = (
                @{ $pathspec->{ 'x-filter' } || [] },
                @{ $op_spec->{ 'x-filter' } || [] },
            );
            $mojo->{filters} = \@filters if @filters;
            my @filters_out = (
                @{ $pathspec->{ 'x-filter-output' } || [] },
                @{ $op_spec->{ 'x-filter-output' } || [] },
            );
            $mojo->{filters_out} = \@filters_out if @filters_out;
            $op_spec->{ 'x-mojo-to' } = $mojo;
        }
    }
}

# for a given OpenAPI operation, figures out right values for 'x-mojo-to'
# to hook it up to the correct CRUD operation
sub _openapi_spec_infer_mojo {
    my ( $self, $path, $pathspec, $method, $op_spec ) = @_;
    my @path_params = grep 'path' eq ($_->{in} // ''),
        @{ $pathspec->{parameters} || [] },
        @{ $op_spec->{parameters} || [] },
        ;
    my ($id_field) = grep defined,
        (map $_->{'x-id-field'}, $op_spec, $pathspec),
        (@path_params && $path_params[-1]{name});
    if ( $method eq 'get' ) {
        # heuristic: is per-item if have a param in path
        if ( $id_field ) {
            # per-item - GET = "read"
            return {
                action => 'get',
                format => 'json',
            };
        }
        else {
            # per-schema - GET = "list"
            return {
                action => 'list',
                format => 'json',
            };
        }
    } elsif ( $method eq 'post' ) {
        return {
            action => 'set',
            format => 'json',
        };
    } elsif ( $method eq 'put' ) {
        die "'$method' $path needs id_field" if !$id_field;
        return {
            action => 'set',
            format => 'json',
        };
    } elsif ( $method eq 'delete' ) {
        die "'$method' $path needs id_field" if !$id_field;
        return {
            action => 'delete',
            format => 'json',
        };
    }
    else {
        die "Unknown method '$method'";
    }
}

sub _openapi_spec_from_schema {
    my ( $self, $config ) = @_;
    my ( %definitions, %paths );
    my $app = $self->app;
    my %parameters = (
        '$limit' => {
            name => '$limit',
            type => 'integer',
            in => 'query',
            description => $app->l( 'OpenAPI $limit description' ),
        },
        '$offset' => {
            name => '$offset',
            type => 'integer',
            in => 'query',
            description => $app->l( 'OpenAPI $offset description' ),
        },
        '$order_by' => {
            name => '$order_by',
            type => 'string',
            in => 'query',
            pattern => '^(?:asc|desc):[^:,]+$',
            description => $app->l( 'OpenAPI $order_by description' ),
        },
        '$match' => {
            name => '$match',
            type => 'string',
            enum => [qw( any all )],
            default => 'all',
            in => 'query',
            description => $app->l( 'OpenAPI $match description' ),
        },
    );
    my $model = $self->model;
    for my $schema_name ( $model->schema_names ) {
        # Set some defaults so users don't have to type as much
        my $schema = $model->schema( $schema_name );
        my $json_schema = $schema->json_schema;
        next if $json_schema->{ 'x-ignore' };
        my $id_field = $schema->id_field;
        my @id_fields = ref $id_field eq 'ARRAY' ? @$id_field : ( $id_field );
        my $props = $json_schema->{properties};
        if ( !$props && $json_schema->{'x-view'} ) {
          my $real_schema_name = $json_schema->{'x-view'}{schema};
          $props = $model->schema( $real_schema_name )->json_schema->{properties};
        }
        my %props = %$props;

        $definitions{ $schema_name } = $json_schema;

        for my $prop ( keys %props ) {
            $props{ $prop }{ type } ||= 'string';
        }

        $paths{ '/' . $schema_name } = {
            get => {
                description => $app->l( 'OpenAPI list description' ),
                parameters => [
                    { '$ref' => '#/parameters/%24limit' },
                    { '$ref' => '#/parameters/%24offset' },
                    { '$ref' => '#/parameters/%24order_by' },
                    { '$ref' => '#/parameters/%24match' },
                    map {
                        my $name = $_;
                        my $type = ref $props{ $_ }{type} eq 'ARRAY' ? $props{ $_ }{type}[0] : $props{ $_ }{type};
                        my $description = $app->l(
                           $type eq 'number' || $type eq 'integer' ? 'OpenAPI filter number description'
                           : $type eq 'boolean' ? 'OpenAPI filter boolean description'
                           : $type eq 'array' ? 'OpenAPI filter array description'
                           : 'OpenAPI filter string description'
                        );
                        {
                        name => $name,
                        in => 'query',
                        type => $type,
                        description => $app->l( 'OpenAPI filter description', $name ) . $description,
                    } } grep !exists( $props{ $_ }{'$ref'} ), sort keys %props,
                ],
                responses => {
                    200 => {
                        description => $app->l( 'OpenAPI list response' ),
                        schema => {
                            type => 'object',
                            required => [qw( items total )],
                            properties => {
                                total => {
                                    type => 'integer',
                                    description => $app->l( 'OpenAPI list total description' ),
                                },
                                items => {
                                    type => 'array',
                                    description => $app->l( 'OpenAPI list items description' ),
                                    items => { '$ref' => "#/definitions/" . url_escape $schema_name },
                                },
                                offset => {
                                    type => 'integer',
                                    description => $app->l( 'OpenAPI list offset description' ),
                                },
                            },
                        },
                    },
                    default => {
                        description => $app->l( 'Unexpected error' ),
                        schema => { '$ref' => '#/definitions/_Error' },
                    },
                },
            },
            $json_schema->{'x-view'} ? () : (post => {
                parameters => [
                    {
                        name => "newItem",
                        in => "body",
                        required => true,
                        schema => { '$ref' => "#/definitions/" . url_escape $schema_name },
                    },
                ],
                responses => {
                    201 => {
                        description => $app->l( 'OpenAPI create response' ),
                        schema => {
                            @id_fields > 1
                            ? (
                                type => 'array',
                                items => [
                                    map +{
                                        '$ref' => '#/' . join '/', map { url_escape $_ }
                                            'definitions', $schema_name, 'properties', $_,
                                    }, @id_fields,
                                ],
                            )
                            : (
                                '$ref' => '#/' . join '/', map { url_escape $_ }
                                    'definitions', $schema_name, 'properties', $id_fields[0],
                            ),
                        },
                    },
                    default => {
                        description => $app->l( "Unexpected error" ),
                        schema => { '$ref' => "#/definitions/_Error" },
                    },
                },
            }),
        };

        $paths{ sprintf '/%s/{%s}', $schema_name, $id_field } = {
            parameters => [
                map +{
                    name => $_,
                    in => 'path',
                    required => true,
                    type => 'string',
                    'x-mojo-placeholder' => '*',
                }, @id_fields
            ],

            get => {
                description => $app->l( 'OpenAPI get description' ),
                responses => {
                    200 => {
                        description => $app->l( 'OpenAPI get response' ),
                        schema => { '$ref' => "#/definitions/" . url_escape $schema_name },
                    },
                    default => {
                        description => $app->l( "Unexpected error" ),
                        schema => { '$ref' => '#/definitions/_Error' },
                    }
                }
            },

            $json_schema->{'x-view'} ? () : (put => {
                description => $app->l( 'OpenAPI update description' ),
                parameters => [
                    {
                        name => "newItem",
                        in => "body",
                        required => true,
                        schema => { '$ref' => "#/definitions/" . url_escape $schema_name },
                    }
                ],
                responses => {
                    200 => {
                        description => $app->l( 'OpenAPI update response' ),
                        schema => { '$ref' => "#/definitions/" . url_escape $schema_name },
                    },
                    default => {
                        description => $app->l( "Unexpected error" ),
                        schema => { '$ref' => "#/definitions/_Error" },
                    }
                }
            },

            delete => {
                description => $app->l( 'OpenAPI delete description' ),
                responses => {
                    204 => {
                        description => $app->l( 'OpenAPI delete response' ),
                    },
                    default => {
                        description => $app->l( "Unexpected error" ),
                        schema => { '$ref' => '#/definitions/_Error' },
                    },
                },
            }),
        };
    }

    return {
        info => $config->{info} || { title => $config->{title}, version => "1" },
        swagger => '2.0',
        host => $config->{host} // hostname(),
        basePath => '/api',
        schemes => [qw( http )],
        consumes => [qw( application/json )],
        produces => [qw( application/json )],
        definitions => {
            _Error => {
                'x-ignore' => 1, # In case we get round-tripped into a Yancy::Model
                title => $app->l( 'OpenAPI error object' ),
                type => 'object',
                properties => {
                    errors => {
                        type => "array",
                        items => {
                            required => [qw( message )],
                            properties => {
                                message => {
                                    type => "string",
                                    description => $app->l( 'OpenAPI error message' ),
                                },
                                path => {
                                    type => "string",
                                    description => $app->l( 'OpenAPI error path' ),
                                }
                            }
                        }
                    }
                }
            },
            %definitions,
        },
        paths => \%paths,
        parameters => \%parameters,
    };
}


1;

__END__

=pod

=head1 NAME

Yancy::Plugin::Editor - Yancy content editor, admin, and management application

=head1 VERSION

version 1.088

=head1 SYNOPSIS

    use Mojolicious::Lite;
    # The default editor at /yancy
    plugin Yancy => {
        backend => 'sqlite://myapp.db',
        read_schema => 1,
        editor => {
            require_user => { can_edit => 1 },
        },
    };

    # Enable another editor for blog users
    app->plugin->yancy( Editor => {
        moniker => 'blog_editor',
        backend => app->yancy->backend,
        schema => { blog_posts => app->yancy->schema( 'blog_posts' ) },
        route => app->routes->any( '/blog/editor' ),
        require_user => { can_blog => 1 },
    } );

=head1 DESCRIPTION

This plugin contains the Yancy editor application which allows editing
the data in a L<Yancy::Backend>.

=head1 CONFIGURATION

This plugin has the following configuration options.

=head2 backend

The backend to use for this editor. Defaults to the default backend
configured in the L<main Yancy plugin|Mojolicious::Plugin::Yancy>.

=head2 schema

The schema to use to build the editor application. This may not
necessarily be the full and exact schema supported by the backend: You
can remove certain fields from this editor instance to protect them, for
example.

If not given, will use L<Yancy::Backend/read_schema> to read the schema
from the backend.

=head2 openapi

Instead of L</schema>, you can pass a full OpenAPI spec to this editor.
This is deprecated; see L<Yancy::Guides::Upgrading>.

=head2 default_controller

The default controller for API routes. Defaults to
L<Yancy::Controller::Yancy>. Building a custom controller can allow for
customizing how the editor works and what content it displays to which
users.

=head2 moniker

The name of this editor instance. Used to build helper names and route
names.  Defaults to C<editor>. Other plugins may rely on there being
a default editor named C<editor>. Additional instances should have
different monikers.

=head2 route

A base route to add the editor to. This allows you to customize the URL
and add authentication or authorization. Defaults to allowing access to
the Yancy web application under C</yancy>, and the REST API under
C</yancy/api>.

This can be a string or a L<Mojolicious::Routes::Route> object.

=head2 return_to

The URL to use for the "Back to Application" link. Defaults to C</>.

=head2 title

The title of the page, shown in the title bar and the page header. Defaults to C<Yancy>.

=head2 host

The host to use for the generated OpenAPI spec. Defaults to the current system's hostname
(via L<Sys::Hostname>).

=head2 info

An OpenAPI info object, as a Perl hashref. See L<the OpenAPI 2.0
spec|https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#infoObject>
for what keys are allowed in this hashref.

=head1 HELPERS

=head2 yancy.editor.include

    $app->yancy->editor->include( $template_name );

Include a template in the editor, before the rest of the editor. Use this
to add your own L<Vue.JS|http://vuejs.org> components to the editor.

=head2 yancy.editor.menu

    $app->yancy->editor->menu( $category, $title, $config );

Add a menu item to the editor. The C<$category> is the title of the category
in the sidebar. C<$title> is the title of the menu item. C<$config> is a
hash reference with the following keys:

=over

=item component

The name of a Vue.JS component to display for this menu item. The
component will take up the entire main area of the application, and will
be kept active even after another menu item is selected.

=back

Yancy plugins should use the category C<Plugins>. Other categories are
available for custom applications.

    app->yancy->editor->include( 'plugin/editor/custom_element' );
    app->yancy->editor->menu(
        'Plugins', 'Custom Item',
        {
            component => 'custom-element',
        },
    );
    __END__
    @@ plugin/editor/custom_element.html.ep
    <template id="custom-element-template">
        <div :id="'custom-element'">
            Hello, world!
        </div>
    </template>
    %= javascript begin
        Vue.component( 'custom-element', {
            template: '#custom-element-template',
        } );
    % end

=for html <img alt="screenshot of yancy editor showing custom element"
    src="https://raw.github.com/preaction/Yancy/master/eg/doc-site/public/screenshot-custom-element.png?raw=true"
    style="width: 600px; max-width: 100%;" width="600" />

=head2 yancy.editor.route

Get the route where the editor will appear.

=head2 yancy.editor.openapi

    my $openapi = $c->yancy->openapi;

Get the L<Mojolicious::Plugin::OpenAPI> object containing the OpenAPI
interface for this Yancy API.

=head1 TEMPLATES

To override these templates, add your own at the designated path inside
your app's C<templates/> directory.

=head2 yancy/editor.html.ep

This is the main Yancy web application. You should not override this.
Instead, use the L</yancy.editor.include> helper to add new components.
If there is something you can't do using the include helper, consider
L<asking how on the Github issues board|https://github.com/preaction/Yancy/issues>
or L<filing a bug report or feature request|https://github.com/preaction/Yancy/issues>.

=head1 SEE ALSO

L<Yancy::Guides::Schema>, L<Mojolicious::Plugin::Yancy>, L<Yancy>

=head1 AUTHOR

Doug Bell <preaction@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Doug Bell.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
