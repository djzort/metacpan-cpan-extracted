require 'src/com/zoho/crm/api/util/Constants.pm';
require 'src/com/zoho/api/exception/SDKException.pm';
package sharerecords::ActionWrapper;
use Moose;
sub new
{
	my ($class) = shift;
	my $self = 
	{
		share => undef,
		key_modified => (),
	};
	bless $self,$class;
	return $self;
}
sub get_share
{
	my ($self) = shift;
	return $self->{share}; 
}

sub set_share
{
	my ($self,$share) = @_;
	if(!(ref($share) eq "ARRAY"))
	{
		die SDKException->new($Constants::DATA_TYPE_ERROR, "KEY: share EXPECTED TYPE: ARRAY", undef, undef); 
	}
	$self->{share} = $share; 
	$self->{key_modified}{"share"} = 1; 
}

sub is_key_modified
{
	my ($self,$key) = @_;
	if((exists($self->{key_modified}{$key})))
	{
		return $self->{key_modified}{$key}; 
	}
	return undef; 
}

sub set_key_modified
{
	my ($self,$key,$modification) = @_;
	$self->{key_modified}{$key} = $modification; 
}
1;