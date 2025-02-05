package PDK::Firewall::Element::Service::Srx;

#------------------------------------------------------------------------------
# 加载扩展模块
#------------------------------------------------------------------------------
use Moose;
use namespace::autoclean;

#------------------------------------------------------------------------------
# 引入 PDK::Firewall::Element::Service::Role 角色
#------------------------------------------------------------------------------
with 'PDK::Firewall::Element::Service::Role';

__PACKAGE__->meta->make_immutable;
1;
