package Chart::Plotly::Trace::Sankey::Link;
use Moose;
use MooseX::ExtraArgs;
use Moose::Util::TypeConstraints qw(enum union);
if ( !defined Moose::Util::TypeConstraints::find_type_constraint('PDL') ) {
    Moose::Util::TypeConstraints::type('PDL');
}

use Chart::Plotly::Trace::Sankey::Link::Concentrationscales;
use Chart::Plotly::Trace::Sankey::Link::Hoverlabel;
use Chart::Plotly::Trace::Sankey::Link::Line;

our $VERSION = '0.042';    # VERSION

# ABSTRACT: This attribute is one of the possible options for the trace sankey.

sub TO_JSON {
    my $self       = shift;
    my $extra_args = $self->extra_args // {};
    my $meta       = $self->meta;
    my %hash       = %$self;
    for my $name ( sort keys %hash ) {
        my $attr = $meta->get_attribute($name);
        if ( defined $attr ) {
            my $value = $hash{$name};
            my $type  = $attr->type_constraint;
            if ( $type && $type->equals('Bool') ) {
                $hash{$name} = $value ? \1 : \0;
            }
        }
    }
    %hash = ( %hash, %$extra_args );
    delete $hash{'extra_args'};
    if ( $self->can('type') && ( !defined $hash{'type'} ) ) {
        $hash{type} = $self->type();
    }
    return \%hash;
}

has arrowlen => ( is            => "rw",
                  isa           => "Num",
                  documentation => "Sets the length (in px) of the links arrow, if 0 no arrow will be drawn.",
);

has color => (
    is            => "rw",
    isa           => "Str|ArrayRef[Str]",
    documentation =>
      "Sets the `link` color. It can be a single value, or an array for specifying color for each `link`. If `link.color` is omitted, then by default, a translucent grey link will be used.",
);

has colorscales => ( is  => "rw",
                     isa => "ArrayRef|ArrayRef[Chart::Plotly::Trace::Sankey::Link::Concentrationscales]", );

has colorsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on Chart Studio Cloud for `color`.",
);

has customdata => ( is            => "rw",
                    isa           => "ArrayRef|PDL",
                    documentation => "Assigns extra data to each link.",
);

has customdatasrc => ( is            => "rw",
                       isa           => "Str",
                       documentation => "Sets the source reference on Chart Studio Cloud for `customdata`.",
);

has description => ( is      => "ro",
                     default => "The links of the Sankey plot.", );

has hoverinfo => (
    is            => "rw",
    isa           => enum( [ "all", "none", "skip" ] ),
    documentation =>
      "Determines which trace information appear when hovering links. If `none` or `skip` are set, no information is displayed upon hovering. But, if `none` is set, click and hover events are still fired.",
);

has hoverlabel => ( is  => "rw",
                    isa => "Maybe[HashRef]|Chart::Plotly::Trace::Sankey::Link::Hoverlabel", );

has hovertemplate => (
    is            => "rw",
    isa           => "Str|ArrayRef[Str]",
    documentation =>
      "Template string used for rendering the information that appear on hover box. Note that this will override `hoverinfo`. Variables are inserted using %{variable}, for example \"y: %{y}\" as well as %{xother}, {%_xother}, {%_xother_}, {%xother_}. When showing info for several points, *xother* will be added to those with different x positions from the first point. An underscore before or after *(x|y)other* will add a space on that side, only when this field is shown. Numbers are formatted using d3-format's syntax %{variable:d3-format}, for example \"Price: %{y:\$.2f}\". https://github.com/d3/d3-format/tree/v1.4.5#d3-format for details on the formatting syntax. Dates are formatted using d3-time-format's syntax %{variable|d3-time-format}, for example \"Day: %{2019-01-01|%A}\". https://github.com/d3/d3-time-format/tree/v2.2.3#locale_format for details on the date formatting syntax. The variables available in `hovertemplate` are the ones emitted as event data described at this link https://plotly.com/javascript/plotlyjs-events/#event-data. Additionally, every attributes that can be specified per-point (the ones that are `arrayOk: true`) are available. variables `value` and `label`. Anything contained in tag `<extra>` is displayed in the secondary box, for example \"<extra>{fullData.name}</extra>\". To hide the secondary box completely, use an empty tag `<extra></extra>`.",
);

has hovertemplatesrc => ( is            => "rw",
                          isa           => "Str",
                          documentation => "Sets the source reference on Chart Studio Cloud for `hovertemplate`.",
);

has label => ( is            => "rw",
               isa           => "ArrayRef|PDL",
               documentation => "The shown name of the link.",
);

has labelsrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on Chart Studio Cloud for `label`.",
);

has line => ( is  => "rw",
              isa => "Maybe[HashRef]|Chart::Plotly::Trace::Sankey::Link::Line", );

has source => ( is            => "rw",
                isa           => "ArrayRef|PDL",
                documentation => "An integer number `[0..nodes.length - 1]` that represents the source node.",
);

has sourcesrc => ( is            => "rw",
                   isa           => "Str",
                   documentation => "Sets the source reference on Chart Studio Cloud for `source`.",
);

has target => ( is            => "rw",
                isa           => "ArrayRef|PDL",
                documentation => "An integer number `[0..nodes.length - 1]` that represents the target node.",
);

has targetsrc => ( is            => "rw",
                   isa           => "Str",
                   documentation => "Sets the source reference on Chart Studio Cloud for `target`.",
);

has value => ( is            => "rw",
               isa           => "ArrayRef|PDL",
               documentation => "A numeric value representing the flow volume value.",
);

has valuesrc => ( is            => "rw",
                  isa           => "Str",
                  documentation => "Sets the source reference on Chart Studio Cloud for `value`.",
);

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=encoding utf-8

=head1 NAME

Chart::Plotly::Trace::Sankey::Link - This attribute is one of the possible options for the trace sankey.

=head1 VERSION

version 0.042

=head1 SYNOPSIS

 use Chart::Plotly qw(show_plot);
 use Chart::Plotly::Trace::Sankey;
 # Example data from: https://plot.ly/javascript/sankey-diagram/#basic-sankey-diagram
 my $sankey = Chart::Plotly::Trace::Sankey->new(
     orientation => "h",
     node        => {
         pad       => 15,
         thickness => 30,
         line      => {
             color => "black",
             width => 0.5
         },
         label     => [ "A1", "A2", "B1", "B2", "C1", "C2" ],
         color     => [ "blue", "blue", "blue", "blue", "blue", "blue" ]
     },
 
     link        => {
         source => [ 0, 1, 0, 2, 3, 3 ],
         target => [ 2, 3, 3, 4, 4, 5 ],
         value  => [ 8, 4, 2, 8, 4, 2 ]
     }
 );
 
 show_plot([ $sankey ]);

=head1 DESCRIPTION

This attribute is part of the possible options for the trace sankey.

This file has been autogenerated from the official plotly.js source.

If you like Plotly, please support them: L<https://plot.ly/> 
Open source announcement: L<https://plot.ly/javascript/open-source-announcement/>

Full reference: L<https://plot.ly/javascript/reference/#sankey>

=head1 DISCLAIMER

This is an unofficial Plotly Perl module. Currently I'm not affiliated in any way with Plotly. 
But I think plotly.js is a great library and I want to use it with perl.

=head1 METHODS

=head2 TO_JSON

Serialize the trace to JSON. This method should be called only by L<JSON> serializer.

=head1 ATTRIBUTES

=over

=item * arrowlen

Sets the length (in px) of the links arrow, if 0 no arrow will be drawn.

=item * color

Sets the `link` color. It can be a single value, or an array for specifying color for each `link`. If `link.color` is omitted, then by default, a translucent grey link will be used.

=item * colorscales

=item * colorsrc

Sets the source reference on Chart Studio Cloud for `color`.

=item * customdata

Assigns extra data to each link.

=item * customdatasrc

Sets the source reference on Chart Studio Cloud for `customdata`.

=item * description

=item * hoverinfo

Determines which trace information appear when hovering links. If `none` or `skip` are set, no information is displayed upon hovering. But, if `none` is set, click and hover events are still fired.

=item * hoverlabel

=item * hovertemplate

Template string used for rendering the information that appear on hover box. Note that this will override `hoverinfo`. Variables are inserted using %{variable}, for example "y: %{y}" as well as %{xother}, {%_xother}, {%_xother_}, {%xother_}. When showing info for several points, *xother* will be added to those with different x positions from the first point. An underscore before or after *(x|y)other* will add a space on that side, only when this field is shown. Numbers are formatted using d3-format's syntax %{variable:d3-format}, for example "Price: %{y:$.2f}". https://github.com/d3/d3-format/tree/v1.4.5#d3-format for details on the formatting syntax. Dates are formatted using d3-time-format's syntax %{variable|d3-time-format}, for example "Day: %{2019-01-01|%A}". https://github.com/d3/d3-time-format/tree/v2.2.3#locale_format for details on the date formatting syntax. The variables available in `hovertemplate` are the ones emitted as event data described at this link https://plotly.com/javascript/plotlyjs-events/#event-data. Additionally, every attributes that can be specified per-point (the ones that are `arrayOk: true`) are available. variables `value` and `label`. Anything contained in tag `<extra>` is displayed in the secondary box, for example "<extra>{fullData.name}</extra>". To hide the secondary box completely, use an empty tag `<extra></extra>`.

=item * hovertemplatesrc

Sets the source reference on Chart Studio Cloud for `hovertemplate`.

=item * label

The shown name of the link.

=item * labelsrc

Sets the source reference on Chart Studio Cloud for `label`.

=item * line

=item * source

An integer number `[0..nodes.length - 1]` that represents the source node.

=item * sourcesrc

Sets the source reference on Chart Studio Cloud for `source`.

=item * target

An integer number `[0..nodes.length - 1]` that represents the target node.

=item * targetsrc

Sets the source reference on Chart Studio Cloud for `target`.

=item * value

A numeric value representing the flow volume value.

=item * valuesrc

Sets the source reference on Chart Studio Cloud for `value`.

=back

=head1 AUTHOR

Pablo Rodríguez González <pablo.rodriguez.gonzalez@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Pablo Rodríguez González.

This is free software, licensed under:

  The MIT (X11) License

=cut
