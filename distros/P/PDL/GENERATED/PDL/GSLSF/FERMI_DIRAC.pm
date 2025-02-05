#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::GSLSF::FERMI_DIRAC;

our @EXPORT_OK = qw(gsl_sf_fermi_dirac_int gsl_sf_fermi_dirac_mhalf gsl_sf_fermi_dirac_half gsl_sf_fermi_dirac_3half gsl_sf_fermi_dirac_inc_0 );
our %EXPORT_TAGS = (Func=>\@EXPORT_OK);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;


   
   our @ISA = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::GSLSF::FERMI_DIRAC ;






#line 4 "gsl_sf_fermi_dirac.pd"

use strict;
use warnings;

=head1 NAME

PDL::GSLSF::FERMI_DIRAC - PDL interface to GSL Special Functions

=head1 DESCRIPTION

This is an interface to the Special Function package present in the GNU Scientific Library. 
Please note that:

Complete Fermi-Dirac Integrals:

 F_j(x)   := 1/Gamma[j+1] Integral[ t^j /(Exp[t-x] + 1), {t,0,Infinity}]


Incomplete Fermi-Dirac Integrals:

 F_j(x,b) := 1/Gamma[j+1] Integral[ t^j /(Exp[t-x] + 1), {t,b,Infinity}]

=cut
#line 49 "FERMI_DIRAC.pm"






=head1 FUNCTIONS

=cut




#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_fermi_dirac_int

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int j)

=for ref

Complete integral F_j(x) for integer j

=for bad

gsl_sf_fermi_dirac_int does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 84 "FERMI_DIRAC.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_fermi_dirac_int = \&PDL::gsl_sf_fermi_dirac_int;
#line 91 "FERMI_DIRAC.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_fermi_dirac_mhalf

=for sig

  Signature: (double x(); double [o]y(); double [o]e())

=for ref

Complete integral F_{-1/2}(x)

=for bad

gsl_sf_fermi_dirac_mhalf does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 116 "FERMI_DIRAC.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_fermi_dirac_mhalf = \&PDL::gsl_sf_fermi_dirac_mhalf;
#line 123 "FERMI_DIRAC.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_fermi_dirac_half

=for sig

  Signature: (double x(); double [o]y(); double [o]e())

=for ref

Complete integral F_{1/2}(x)

=for bad

gsl_sf_fermi_dirac_half does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 148 "FERMI_DIRAC.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_fermi_dirac_half = \&PDL::gsl_sf_fermi_dirac_half;
#line 155 "FERMI_DIRAC.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_fermi_dirac_3half

=for sig

  Signature: (double x(); double [o]y(); double [o]e())

=for ref

Complete integral F_{3/2}(x)

=for bad

gsl_sf_fermi_dirac_3half does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 180 "FERMI_DIRAC.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_fermi_dirac_3half = \&PDL::gsl_sf_fermi_dirac_3half;
#line 187 "FERMI_DIRAC.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_fermi_dirac_inc_0

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double b)

=for ref

Incomplete integral F_0(x,b) = ln(1 + e^(b-x)) - (b-x)

=for bad

gsl_sf_fermi_dirac_inc_0 does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 212 "FERMI_DIRAC.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_fermi_dirac_inc_0 = \&PDL::gsl_sf_fermi_dirac_inc_0;
#line 219 "FERMI_DIRAC.pm"





#line 100 "gsl_sf_fermi_dirac.pd"

=head1 AUTHOR

This file copyright (C) 1999 Christian Pellegrin <chri@infis.univ.trieste.it>
All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDL distribution. If this file is separated from the
PDL distribution, the copyright notice should be included in the file.

The GSL SF modules were written by G. Jungman.

=cut
#line 239 "FERMI_DIRAC.pm"




# Exit with OK status

1;
