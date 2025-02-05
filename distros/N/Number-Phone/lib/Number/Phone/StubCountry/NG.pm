# automatically generated file, don't edit



# Copyright 2011 David Cantrell, derived from data from libphonenumber
# http://code.google.com/p/libphonenumber/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
package Number::Phone::StubCountry::NG;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20221202211027;

my $formatters = [
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '78',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{2})(\\d{3})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '
            [12]|
            9(?:
              0[3-9]|
              [1-9]
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d)(\\d{3})(\\d{3,4})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '
            [3-7]|
            8[2-9]
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{3})(\\d{2,3})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '[7-9]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{3,4})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '[78]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{4})(\\d{4,5})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '[78]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{5})(\\d{5,6})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            (?:
              [1-356]\\d|
              4[02-8]|
              8[2-9]
            )\\d|
            9(?:
              0[3-9]|
              [1-9]\\d
            )
          )\\d{5}|
          7(?:
            0(?:
              [013-689]\\d|
              2[0-24-9]
            )\\d{3,4}|
            [1-79]\\d{6}
          )|
          (?:
            [12]\\d|
            4[147]|
            5[14579]|
            6[1578]|
            7[1-3578]
          )\\d{5}
        ',
                'geographic' => '
          (?:
            (?:
              [1-356]\\d|
              4[02-8]|
              8[2-9]
            )\\d|
            9(?:
              0[3-9]|
              [1-9]\\d
            )
          )\\d{5}|
          7(?:
            0(?:
              [013-689]\\d|
              2[0-24-9]
            )\\d{3,4}|
            [1-79]\\d{6}
          )|
          (?:
            [12]\\d|
            4[147]|
            5[14579]|
            6[1578]|
            7[1-3578]
          )\\d{5}
        ',
                'mobile' => '
          (?:
            702[0-24-9]|
            8(?:
              01|
              19
            )[01]
          )\\d{6}|
          (?:
            70[13-689]|
            8(?:
              0[2-9]|
              1[0-8]
            )|
            9(?:
              0[1-9]|
              1[2356]
            )
          )\\d{7}
        ',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '(700\\d{7,11})',
                'toll_free' => '800\\d{7,11}',
                'voip' => ''
              };
my %areanames = ();
$areanames{en} = {"23483", "Owerri",
"23482", "Aba",
"234908", "Abuja",
"23450", "Ikare",
"23452", "Benin",
"23438", "Oyo",
"23497", "Abuja",
"23453", "Warri",
"23487", "Calabar",
"23469", "Zaria",
"23493", "Abuja",
"23457", "Auchi",
"234907", "Abuja",
"23435", "Oshogbo",
"234904", "Abuja",
"23479", "Jalingo",
"23492", "Abuja",
"23460", "Sokobo",
"23443", "Abakaliki",
"23462", "Kaduna",
"23442", "Enugu",
"23463", "Gusau",
"23472", "Gombe",
"23499", "Abuja",
"23436", "Ile\ Ife",
"23473", "Jos",
"23489", "Yenegoa",
"23467", "Kontagora",
"23447", "Lafia",
"23431", "Ilorin",
"23477", "Bauchi",
"2341", "Lagos",
"23434", "Akura",
"23459", "Okitipupa",
"23446", "Onitsha",
"23488", "Umuahia",
"23466", "Minna",
"23430", "Ado\ Ekiti",
"23458", "Lokoja",
"23433", "New\ Bussa",
"234906", "Abuja",
"23495", "Abuja",
"23476", "Maiduguri",
"23444", "Makurdi",
"23471", "Azare",
"23485", "Uyo",
"234905", "Abuja",
"2342", "Ibadan",
"23464", "Kano",
"23498", "Abuja",
"23441", "Wukari",
"23455", "Agbor",
"23437", "Ijebu\ Ode",
"23474", "Damaturu",
"23461", "Kafanchau",
"234909", "Abuja",
"23486", "Ahoada",
"23448", "Awka",
"23491", "Abuja",
"23468", "Birnin\-Kebbi",
"23494", "Abuja",
"23456", "Asaba",
"23478", "Hadejia",
"23484", "Port\ Harcourt",
"2347020", "Pank\ Shin",
"23465", "Katsina",
"23445", "Ogoja",
"23451", "Owo",
"234903", "Abuja",
"23496", "Abuja",
"23475", "Yola",
"23439", "Abeokuta",
"23454", "Sapele",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+234|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;