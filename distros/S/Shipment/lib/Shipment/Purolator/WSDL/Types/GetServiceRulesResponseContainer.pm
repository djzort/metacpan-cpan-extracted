package Shipment::Purolator::WSDL::Types::GetServiceRulesResponseContainer;
$Shipment::Purolator::WSDL::Types::GetServiceRulesResponseContainer::VERSION = '3.10';
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}


use base qw(Shipment::Purolator::WSDL::Types::ResponseContainer);
# Variety: sequence
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %ResponseInformation_of :ATTR(:get<ResponseInformation>);
my %ServiceRules_of :ATTR(:get<ServiceRules>);
my %ServiceOptionRules_of :ATTR(:get<ServiceOptionRules>);
my %OptionRules_of :ATTR(:get<OptionRules>);

__PACKAGE__->_factory(
    [ qw(        ResponseInformation
        ServiceRules
        ServiceOptionRules
        OptionRules

    ) ],
    {
        'ResponseInformation' => \%ResponseInformation_of,
        'ServiceRules' => \%ServiceRules_of,
        'ServiceOptionRules' => \%ServiceOptionRules_of,
        'OptionRules' => \%OptionRules_of,
    },
    {
        'ResponseInformation' => 'Shipment::Purolator::WSDL::Types::ResponseInformation',
        'ServiceRules' => 'Shipment::Purolator::WSDL::Types::ArrayOfServiceRule',
        'ServiceOptionRules' => 'Shipment::Purolator::WSDL::Types::ArrayOfServiceOptionRules',
        'OptionRules' => 'Shipment::Purolator::WSDL::Types::ArrayOfOptionRule',
    },
    {

        'ResponseInformation' => 'ResponseInformation',
        'ServiceRules' => 'ServiceRules',
        'ServiceOptionRules' => 'ServiceOptionRules',
        'OptionRules' => 'OptionRules',
    }
);

} # end BLOCK







1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::Purolator::WSDL::Types::GetServiceRulesResponseContainer

=head1 VERSION

version 3.10

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
GetServiceRulesResponseContainer from the namespace http://purolator.com/pws/datatypes/v1.

GetServiceRulesResponse

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ServiceRules (min/maxOccurs: 0/1)

=item * ServiceOptionRules (min/maxOccurs: 0/1)

=item * OptionRules (min/maxOccurs: 0/1)

=back

=head1 NAME

Shipment::Purolator::WSDL::Types::GetServiceRulesResponseContainer

=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::GetServiceRulesResponseContainer
   ServiceRules =>  { # Shipment::Purolator::WSDL::Types::ArrayOfServiceRule
     ServiceRule =>  { # Shipment::Purolator::WSDL::Types::ServiceRule
       ServiceID =>  $some_value, # string
       MinimumTotalPieces =>  $some_value, # int
       MaximumTotalPieces =>  $some_value, # int
       MinimumTotalWeight =>  { # Shipment::Purolator::WSDL::Types::Weight
         Value =>  $some_value, # decimal
         WeightUnit => $some_value, # WeightUnit
       },
       MaximumTotalWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
       MinimumPieceWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
       MaximumPieceWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
       MinimumPieceLength =>  { # Shipment::Purolator::WSDL::Types::Dimension
         Value =>  $some_value, # decimal
         DimensionUnit => $some_value, # DimensionUnit
       },
       MaximumPieceLength => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MinimumPieceWidth => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MaximumPieceWidth => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MinimumPieceHeight => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MaximumPieceHeight => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MaximumSize => {}, # Shipment::Purolator::WSDL::Types::Dimension
       MaximumDeclaredValue =>  $some_value, # decimal
     },
   },
   ServiceOptionRules =>  { # Shipment::Purolator::WSDL::Types::ArrayOfServiceOptionRules
     ServiceOptionRules =>  { # Shipment::Purolator::WSDL::Types::ServiceOptionRules
       ServiceID =>  $some_value, # string
       Exclusions =>  { # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
         OptionIDValuePair =>  { # Shipment::Purolator::WSDL::Types::OptionIDValuePair
           ID =>  $some_value, # string
           Value =>  $some_value, # string
         },
       },
       Inclusions => {}, # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
     },
   },
   OptionRules =>  { # Shipment::Purolator::WSDL::Types::ArrayOfOptionRule
     OptionRule =>  { # Shipment::Purolator::WSDL::Types::OptionRule
       OptionIDValuePair => {}, # Shipment::Purolator::WSDL::Types::OptionIDValuePair
       Exclusions => {}, # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
       Inclusions => {}, # Shipment::Purolator::WSDL::Types::ArrayOfOptionIDValuePair
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
