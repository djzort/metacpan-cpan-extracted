package PDK::Firewall::Element::Route::Topsec;

#------------------------------------------------------------------------------
# 加载扩展模块
#------------------------------------------------------------------------------
use Moose;
use namespace::autoclean;

#------------------------------------------------------------------------------
# 引用 PDK::Firewall::Element::Route::Role 角色
#------------------------------------------------------------------------------
with 'PDK::Firewall::Element::Route::Role';

#------------------------------------------------------------------------------
# Topsec 防火墙路由对象方法和属性
#------------------------------------------------------------------------------
has routeId => (is => 'ro', isa => 'Str', required => 0,);

__PACKAGE__->meta->make_immutable;
1;
