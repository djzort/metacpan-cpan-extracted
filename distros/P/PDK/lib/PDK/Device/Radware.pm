package PDK::Device::Radware;

#------------------------------------------------------------------------------
# 加载扩展模块
#------------------------------------------------------------------------------
use Moose;
use namespace::autoclean;

#------------------------------------------------------------------------------
# 继承 PDK::Device::Role 方法属性,同时具体实现其指定方法
#------------------------------------------------------------------------------
with 'PDK::Device::Role';

#------------------------------------------------------------------------------
# 具体实现 _prompt,设置设备脚本执行成功回显
#------------------------------------------------------------------------------
sub _prompt {
  my $self   = shift;
  my $prompt = '(?:>> Standalone ADC) - (.*?)# ';
  return $prompt;
}

#------------------------------------------------------------------------------
# 具体实现 _startupCommands,设置抓取设备启动配置的脚本
#------------------------------------------------------------------------------
sub _startupCommands {
  my $self     = shift;
  my $commands = ["cfg/dump", "cd"];
  return $commands;
}

#------------------------------------------------------------------------------
# 具体实现 _runningCommands,设置抓取设备运行配置的脚本
#------------------------------------------------------------------------------
sub _runningCommands {
  my $self     = shift;
  my $commands = ["cfg/dump", "cd"];
  return $commands;
}

#------------------------------------------------------------------------------
# 具体实现 _healthCheckCommands,设置抓取设备健康检查配置的脚本
#------------------------------------------------------------------------------
sub _healthCheckCommands {
  my $self     = shift;
  my $commands = ["cfg/dump", "cd"];
  return $commands;
}

#------------------------------------------------------------------------------
# 具体实现 truncateCommand，修正脚本下发后回显乱码
#------------------------------------------------------------------------------
sub truncateCommand {
  my ($self, $buff) = @_;

  # 字符串修正处理
  $buff =~ s/\x1b\[\d+D\s+\x1b\[\d+D//g;
  $buff =~ s/\r\n|\n+\n/\n/g;
  $buff =~ s/^%.+$//mg;
  $buff =~ s/^\s*$//mg;

  # 返回修正数据
  return $buff;
}

#------------------------------------------------------------------------------
# 具体实现 _errorCodes,设置命令下发错误码 -> 用于拦截配置下发
#------------------------------------------------------------------------------
sub _errorCodes {
  my $self  = shift;
  my $codes = [
    'for a list of subcommands',
    '% Incomplete command',
    '% Ambiguous command',
    '% Permission denied',
    '% Permission denied',
    'command authorization failed',
    'Invalid input detected|Type help or ',
    'Line has invalid autocommand',
    'Invalid input detected|Incomplete command'
  ];
  return $codes;
}

#------------------------------------------------------------------------------
# 具体实现 _bufferCodes,设置交互式执行脚本 -> 用于交互式下发配置
#------------------------------------------------------------------------------
sub _bufferCodes {
  my $self    = shift;
  my %mapping = (more => '--more--', interact => {'Display private keys' => "n", 'Confirm Sync to Peer' => "y",});

  # 返回数据字典
  return \%mapping;
}

#------------------------------------------------------------------------------
# 具体实现 runCommands，编写进入特权模式、退出保存配置的逻辑
#------------------------------------------------------------------------------
sub runCommands {
  my ($self, @commands) = @_;

  # 配置下发前 | 切入配置模式
  unshift(@commands, "cfg");

  # 完成配置后 | 报错具体配置
  push(@commands, "save");

  # 执行调度，配置批量下发
  $self->execCommands(@commands);
}

__PACKAGE__->meta->make_immutable;
1;
