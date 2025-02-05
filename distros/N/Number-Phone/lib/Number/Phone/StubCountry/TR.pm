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
package Number::Phone::StubCountry::TR;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20221202211028;

my $formatters = [
                {
                  'format' => '$1 $2 $3',
                  'intl_format' => 'NA',
                  'leading_digits' => '444',
                  'pattern' => '(\\d{3})(\\d)(\\d{3})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '
            512|
            8[01589]|
            90
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{4})'
                },
                {
                  'format' => '$1 $2 $3 $4',
                  'leading_digits' => '
            5(?:
              [0-59]|
              6161
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{2})(\\d{2})'
                },
                {
                  'format' => '$1 $2 $3 $4',
                  'leading_digits' => '
            [24][1-8]|
            3[1-9]
          ',
                  'national_rule' => '(0$1)',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{2})(\\d{2})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '80',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{6,7})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            2(?:
              [13][26]|
              [28][2468]|
              [45][268]|
              [67][246]
            )|
            3(?:
              [13][28]|
              [24-6][2468]|
              [78][02468]|
              92
            )|
            4(?:
              [16][246]|
              [23578][2468]|
              4[26]
            )
          )\\d{7}
        ',
                'geographic' => '
          (?:
            2(?:
              [13][26]|
              [28][2468]|
              [45][268]|
              [67][246]
            )|
            3(?:
              [13][28]|
              [24-6][2468]|
              [78][02468]|
              92
            )|
            4(?:
              [16][246]|
              [23578][2468]|
              4[26]
            )
          )\\d{7}
        ',
                'mobile' => '
          56161\\d{5}|
          5(?:
            0[15-7]|
            1[06]|
            24|
            [34]\\d|
            5[1-59]|
            9[46]
          )\\d{7}
        ',
                'pager' => '512\\d{7}',
                'personal_number' => '
          592(?:
            21[12]|
            461
          )\\d{4}
        ',
                'specialrate' => '(
          (?:
            8[89]8|
            900
          )\\d{7}
        )|(444\\d{4})',
                'toll_free' => '
          8(?:
            00\\d{7}(?:
              \\d{2,3}
            )?|
            11\\d{7}
          )
        ',
                'voip' => '850\\d{7}'
              };
my %areanames = ();
$areanames{en} = {"90216", "Istanbul\ \(Anatolia\)",
"90424", "Elazig",
"90456", "Gumushane",
"90322", "Adana",
"90478", "Ardahan",
"90486", "Sirnak",
"90222", "Esksehir",
"90338", "Karaman",
"90352", "Kayseri",
"90426", "Bingol",
"90282", "Tekirdag",
"90454", "Giresun",
"90484", "Stirt",
"90252", "Mugla",
"90382", "Aksaray",
"90380", "Duzce",
"90412", "Diyarbakir",
"90432", "Van",
"90458", "Bayburt",
"90476", "Igdir",
"90488", "Batman",
"90446", "Erzincan",
"90466", "Artvin",
"90318", "Kirikkale",
"90262", "Kocaeli",
"90372", "Zongdulak",
"90474", "Kars",
"90428", "Tuniceli",
"90242", "Antalya",
"90370", "Karabuk",
"90342", "Gaziantep",
"90272", "Afyon",
"90362", "Samsun",
"90464", "Rize",
"90236", "Manisa",
"90374", "Bolu",
"90472", "Agri",
"90328", "Osmaniye",
"90264", "Sakarya",
"90436", "Mus",
"90364", "Corum",
"90462", "Trabzon",
"90442", "Erzurum",
"9039", "Northern\ Cyprus",
"90344", "K\.\ Maras",
"90228", "Bilecik",
"90274", "Kutahya",
"90358", "Amasya",
"90246", "Isparta",
"90288", "Kirklareli",
"90376", "Cankiri",
"90434", "Bitlis",
"90266", "Balikesir",
"90332", "Konya",
"90366", "Kastamonu",
"90232", "Izmir",
"90276", "Usak",
"90258", "Denizli",
"90388", "Nigde",
"90346", "Sivas",
"90354", "Yozgat",
"90452", "Ordu",
"90284", "Edirne",
"90326", "Hatay",
"90438", "Hakkari",
"90212", "Istanbul\ \(Europe\)",
"90414", "Sanliurfa",
"90312", "Ankara",
"90482", "Mardin",
"90226", "Yalova",
"90384", "Nevsehir",
"90356", "Tokat",
"90422", "Malatya",
"90248", "Burdur",
"90324", "Icel",
"90286", "Canakkale",
"90378", "Bartin",
"90416", "Adiyaman",
"90368", "Sinop",
"90256", "Aydin",
"90386", "Kirsehir",
"90348", "Kilis",
"90224", "Bursa",};
$areanames{tr} = {"90324", "Mersin",
"90286", "Çanakkale",
"90378", "Bartın",
"90416", "Adıyaman",
"90256", "Aydın",
"90386", "Kırşehir",
"90212", "Istanbul\ \(Avrupa\)",
"90414", "Şanlıurfa",
"90384", "Nevşehir",
"90288", "Kırklareli",
"90376", "Çankırı",
"90266", "Balıkesir",
"90232", "İzmir",
"90276", "Uşak",
"90388", "Niğde",
"90472", "Ağrı",
"90264", "Sakarya\ \(Adapazarı\)",
"90436", "Muş",
"90364", "Çorum",
"9039", "Kuzey\ Kıbrıs",
"90344", "Kahramanmaraş",
"90274", "Kütahya",
"90262", "Kocaeli\ \(İzmit\)",
"90372", "Zonguldak",
"90428", "Tunceli",
"90370", "Karabük",
"90476", "Iğdır",
"90318", "Kırıkkale",
"90426", "Bingöl",
"90282", "Tekirdağ",
"90484", "Siirt",
"90252", "Muğla",
"90380", "Düzce",
"90412", "Diyarbakır",
"90424", "Elazığ",
"90456", "Gümüşhane",
"90486", "Şırnak",
"90222", "Eskisehir",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+90|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;