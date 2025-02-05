package PDK::Firewall::Element::StaticNat::Netscreen;

#------------------------------------------------------------------------------
# 加载扩展模块
#------------------------------------------------------------------------------
use Moose;
use namespace::autoclean;
use PDK::Utils::Set;

#------------------------------------------------------------------------------
# 引入 PDK::Firewall::Element::StaticNat::Role 角色
#------------------------------------------------------------------------------
with 'PDK::Firewall::Element::StaticNat::Role';

#------------------------------------------------------------------------------
# PDK::Firewall::Element::StaticNat::Netscreen 通用属性
#------------------------------------------------------------------------------
has mask => (is => 'ro', isa => 'Str', required => 1,);

has '+natZone' => (required => 1,);

has '+realZone' => (required => 1,);

has dstIpRange => (is => 'ro', isa => 'PDK::Utils::Set', default => sub { PDK::Utils::Set->new(0, 4294967295) },);

has natInterface => (is => 'ro', isa => 'Str|Undef', required => 0,);

#------------------------------------------------------------------------------
# 重写 PDK::Firewall::Element::Role => _buildRange 方法
#------------------------------------------------------------------------------
sub _buildSign {
  my $self = shift;
  return $self->createSign($self->natIp);
}

__PACKAGE__->meta->make_immutable;
1;
