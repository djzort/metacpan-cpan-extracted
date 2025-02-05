package PDK::Firewall::Element::Address::Netscreen;

#------------------------------------------------------------------------------
# 加载扩展模块
#------------------------------------------------------------------------------
use Moose;
use namespace::autoclean;

#------------------------------------------------------------------------------
# 引用 PDK::Firewall::Element::Address::Role 角色
#------------------------------------------------------------------------------
with 'PDK::Firewall::Element::Address::Role';

#------------------------------------------------------------------------------
# PDK::Firewall::Element::Address::Netscreen 通用属性
#------------------------------------------------------------------------------
has '+zone' => (required => 1,);

#------------------------------------------------------------------------------
# 设定防火墙地址对象签名方法
#------------------------------------------------------------------------------
sub _buildSign {
  my $self = shift;
  return $self->createSign($self->zone, $self->addrName);
}

__PACKAGE__->meta->make_immutable;
1;
