#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long qw(:config no_ignore_case); #bundling
use Pod::Usage;

use Cisco::SNMP::Config;

my %opt;
my ($opt_help, $opt_man);

GetOptions(
  'community=s'  => \$opt{community},
  'dest=s'       => \$opt{dest},
  'P|protocol=s' => \$opt{protocol},
  'password=s'   => \$opt{password},
  'source=s'     => \$opt{source},
  'tftp=s'       => \$opt{server}, # legacy
  'S|server=s'   => \$opt{server},
  'username=s'   => \$opt{username},
  'help!'        => \$opt_help,
  'man!'         => \$opt_man
) or pod2usage(-verbose => 0);

pod2usage(-verbose => 1) if defined $opt_help;
pod2usage(-verbose => 2) if defined $opt_man;

# Make sure at least one host was provided
if (!@ARGV) {
    pod2usage(-verbose => 0, -message => "$0: host required\n")
}

$opt{community} = $opt{community} || 'private';
$opt{protocol}  = $opt{protocol}  || 'tftp';
$opt{username}  = $opt{useranme}  || 'cisco';
$opt{password}  = $opt{password}  || 'cisco';
$opt{dest}      = $opt{dest}      || 'start';
$opt{source}    = $opt{source}    || 'run';

if (($opt{dest}   !~ /^run(?:ning)?(?:-config)?$/i) &&
    ($opt{dest}   !~ /^start(?:up)?(?:-config)?$/i) &&
    ($opt{source} !~ /^run(?:ning)?(?:-config)?$/i) &&
    ($opt{source} !~ /^start(?:up)?(?:-config)?$/i)) {
    print "$0: source or dest must be run or start\n";
    exit 1
}

if (((($opt{dest}   !~ /^run(?:ning)?(?:-config)?$/i) &&
      ($opt{dest}   !~ /^start(?:up)?(?:-config)?$/i)) ||
     (($opt{source} !~ /^run(?:ning)?(?:-config)?$/i) &&
      ($opt{source} !~ /^start(?:up)?(?:-config)?$/i))) && (!defined $opt{server})) {
    print "$0: server required for source or dest not run or start\n";
    exit 1
}

if ((defined $opt{server}) && 
   (($opt{dest}   =~ /^run(?:ning)?(?:-config)?$/i) &&
    ($opt{source} =~ /^start(?:up)?(?:-config)?$/i)) ||
   (($opt{source} =~ /^run(?:ning)?(?:-config)?$/i) &&
    ($opt{dest}   =~ /^start(?:up)?(?:-config)?$/i))) {
    print "$0: server requires source or dest\n";
    exit 1
}

# No output buffering
#$|=1;

for (@ARGV) {
    print "\n-- $_ --\n";

    my $cm;
    if (!defined($cm = Cisco::SNMP::Config->new(
            hostname  => $_,
            community => $opt{community}
        ))) {
        printf "Error: %s\n", Cisco::SNMP::Config->error;
        next
    }

    # copy local (run / start)
    if (!defined $opt{server}) {
        print "$_: copy $opt{source} $opt{dest} - ";
        if (defined(my $conf = $cm->config_copy(
                source => $opt{source},
                dest   => $opt{dest}
            ))) {
            printf "START: %s / END: %s\n", $conf->ccStartTime, $conf->ccEndTime
        } else {
            printf "Error: %s\n", Cisco::SNMP::Config->error
        }
        next
    }

    # get
    my $src  = $opt{source};
    my $dest = $opt{dest};
    if (($opt{source} =~ /^run(?:ning)?(?:-config)?$/i) &&
        ($opt{dest} =~ /^start(?:up)?(?:-config)?$/i)) {
        $dest = $opt{server} . ":/" . $opt{dest}
    # put
    } else {
        $src = $opt{server} . ":/" . $opt{source}
    }
    printf "$_: copy $src $dest - ";
    if (defined(my $conf = $cm->config_copy(
            server   => $opt{server},
            protocol => $opt{protocol},
            username => $opt{username},
            password => $opt{password},
            source   => $opt{source},
            dest     => $opt{dest}
        ))) {
        printf "START: %s / END: %s\n", $conf->ccStartTime, $conf->ccEndTime;
    } else {
        printf "Error: %s\n", Cisco::SNMP::Config->error
    }

    $cm->close()
}

__END__

########################################################
# Start POD
########################################################

=head1 NAME

CISCO-CONF - Cisco Configuration File Manager

=head1 SYNOPSIS

 cisco-conf [options] host [...]

=head1 DESCRIPTION

Perform configuration file management tasks on provided hosts.
Configuration file upload and download through TFTP (via SMMP) and 
C<copy run start> on host are options.

=head1 ARGUMENTS

 host             The Cisco device to manage.

=head1 OPTIONS

 -c <snmp_rw>     SNMP read/write community.
 --community      DEFAULT:  (or not specified) 'private'.

 -d <file>        File name for destination.  Can be 'start' or 'run' 
 --dest           for local device files.  Can be any filename for 
                  network destination.
                  DEFAULT:  (or not specified) 'start'.

 -P <proto>       Protocol.  See Cisco::SNMP::Config.
 --protocol       DEFAULT:  (or not specified) 'tftp'.

 -p <passwd>      Password for required protocols.
 --password       See Cisco::SNMP::Config.

 -S <IP>          Server address or hostname.
 --server         DEFAULT:  (or not specified) [none].

 -s <file>        File name for source.  Can be 'start' or 'run' 
 --source         for local device files.  Can be any filename for 
                  network source.
                  DEFAULT:  (or not specified) 'run'.

 -u <username>    Username for required protocols.
 --username       See Cisco::SNMP::Config.

=head1 LICENSE

This software is released under the same terms as Perl itself.
If you don't know what that means visit L<http://perl.com/>.

=head1 AUTHOR

Copyright (C) Michael Vincent 2010

L<http://www.VinsWorld.com>

All rights reserved

=cut
