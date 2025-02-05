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
package Number::Phone::StubCountry::GB;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20221202211026;

my $formatters = [
                {
                  'format' => '$1 $2',
                  'leading_digits' => '8001111',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{4})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '845464',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{2})(\\d{2})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '800',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{6})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            1(?:
              3873|
              5(?:
                242|
                39[4-6]
              )|
              (?:
                697|
                768
              )[347]|
              9467
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{5})(\\d{4,5})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            1(?:
              [2-69][02-9]|
              [78]
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{4})(\\d{5,6})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '
            [25]|
            7(?:
              0|
              6(?:
                [03-9]|
                2[356]
              )
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{4})(\\d{4})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '7',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{4})(\\d{6})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '[1389]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3})(\\d{4})'
                }
              ];

my $validators = {
                'fixed_line' => '
          (?:
            1(?:
              1(?:
                3(?:
                  [0-58]\\d\\d|
                  73[0235]
                )|
                4(?:
                  [0-5]\\d\\d|
                  69[7-9]|
                  70[013579]
                )|
                (?:
                  (?:
                    5[0-26-9]|
                    [78][0-49]
                  )\\d|
                  6(?:
                    [0-4]\\d|
                    50
                  )
                )\\d
              )|
              2(?:
                (?:
                  0[024-9]|
                  2[3-9]|
                  3[3-79]|
                  4[1-689]|
                  [58][02-9]|
                  6[0-47-9]|
                  7[013-9]|
                  9\\d
                )\\d\\d|
                1(?:
                  [0-7]\\d\\d|
                  8(?:
                    [02]\\d|
                    1[0-246-9]
                  )
                )
              )|
              (?:
                3(?:
                  0\\d|
                  1[0-8]|
                  [25][02-9]|
                  3[02-579]|
                  [468][0-46-9]|
                  7[1-35-79]|
                  9[2-578]
                )|
                4(?:
                  0[03-9]|
                  [137]\\d|
                  [28][02-57-9]|
                  4[02-69]|
                  5[0-8]|
                  [69][0-79]
                )|
                5(?:
                  0[1-35-9]|
                  [16]\\d|
                  2[024-9]|
                  3[015689]|
                  4[02-9]|
                  5[03-9]|
                  7[0-35-9]|
                  8[0-468]|
                  9[0-57-9]
                )|
                6(?:
                  0[034689]|
                  1\\d|
                  2[0-35689]|
                  [38][013-9]|
                  4[1-467]|
                  5[0-69]|
                  6[13-9]|
                  7[0-8]|
                  9[0-24578]
                )|
                7(?:
                  0[0246-9]|
                  2\\d|
                  3[0236-8]|
                  4[03-9]|
                  5[0-46-9]|
                  6[013-9]|
                  7[0-35-9]|
                  8[024-9]|
                  9[02-9]
                )|
                8(?:
                  0[35-9]|
                  2[1-57-9]|
                  3[02-578]|
                  4[0-578]|
                  5[124-9]|
                  6[2-69]|
                  7\\d|
                  8[02-9]|
                  9[02569]
                )|
                9(?:
                  0[02-589]|
                  [18]\\d|
                  2[02-689]|
                  3[1-57-9]|
                  4[2-9]|
                  5[0-579]|
                  6[2-47-9]|
                  7[0-24578]|
                  9[2-57]
                )
              )\\d\\d
            )|
            2(?:
              0[013478]|
              3[0189]|
              4[017]|
              8[0-46-9]|
              9[0-2]
            )\\d{3}
          )\\d{4}|
          1(?:
            2(?:
              0(?:
                46[1-4]|
                87[2-9]
              )|
              545[1-79]|
              76(?:
                2\\d|
                3[1-8]|
                6[1-6]
              )|
              9(?:
                7(?:
                  2[0-4]|
                  3[2-5]
                )|
                8(?:
                  2[2-8]|
                  7[0-47-9]|
                  8[3-5]
                )
              )
            )|
            3(?:
              6(?:
                38[2-5]|
                47[23]
              )|
              8(?:
                47[04-9]|
                64[0157-9]
              )
            )|
            4(?:
              044[1-7]|
              20(?:
                2[23]|
                8\\d
              )|
              6(?:
                0(?:
                  30|
                  5[2-57]|
                  6[1-8]|
                  7[2-8]
                )|
                140
              )|
              8(?:
                052|
                87[1-3]
              )
            )|
            5(?:
              2(?:
                4(?:
                  3[2-79]|
                  6\\d
                )|
                76\\d
              )|
              6(?:
                26[06-9]|
                686
              )
            )|
            6(?:
              06(?:
                4\\d|
                7[4-79]
              )|
              295[5-7]|
              35[34]\\d|
              47(?:
                24|
                61
              )|
              59(?:
                5[08]|
                6[67]|
                74
              )|
              9(?:
                55[0-4]|
                77[23]
              )
            )|
            7(?:
              26(?:
                6[13-9]|
                7[0-7]
              )|
              (?:
                442|
                688
              )\\d|
              50(?:
                2[0-3]|
                [3-68]2|
                76
              )
            )|
            8(?:
              27[56]\\d|
              37(?:
                5[2-5]|
                8[239]
              )|
              843[2-58]
            )|
            9(?:
              0(?:
                0(?:
                  6[1-8]|
                  85
                )|
                52\\d
              )|
              3583|
              4(?:
                66[1-8]|
                9(?:
                  2[01]|
                  81
                )
              )|
              63(?:
                23|
                3[1-4]
              )|
              9561
            )
          )\\d{3}
        ',
                'geographic' => '
          (?:
            1(?:
              1(?:
                3(?:
                  [0-58]\\d\\d|
                  73[0235]
                )|
                4(?:
                  [0-5]\\d\\d|
                  69[7-9]|
                  70[013579]
                )|
                (?:
                  (?:
                    5[0-26-9]|
                    [78][0-49]
                  )\\d|
                  6(?:
                    [0-4]\\d|
                    50
                  )
                )\\d
              )|
              2(?:
                (?:
                  0[024-9]|
                  2[3-9]|
                  3[3-79]|
                  4[1-689]|
                  [58][02-9]|
                  6[0-47-9]|
                  7[013-9]|
                  9\\d
                )\\d\\d|
                1(?:
                  [0-7]\\d\\d|
                  8(?:
                    [02]\\d|
                    1[0-246-9]
                  )
                )
              )|
              (?:
                3(?:
                  0\\d|
                  1[0-8]|
                  [25][02-9]|
                  3[02-579]|
                  [468][0-46-9]|
                  7[1-35-79]|
                  9[2-578]
                )|
                4(?:
                  0[03-9]|
                  [137]\\d|
                  [28][02-57-9]|
                  4[02-69]|
                  5[0-8]|
                  [69][0-79]
                )|
                5(?:
                  0[1-35-9]|
                  [16]\\d|
                  2[024-9]|
                  3[015689]|
                  4[02-9]|
                  5[03-9]|
                  7[0-35-9]|
                  8[0-468]|
                  9[0-57-9]
                )|
                6(?:
                  0[034689]|
                  1\\d|
                  2[0-35689]|
                  [38][013-9]|
                  4[1-467]|
                  5[0-69]|
                  6[13-9]|
                  7[0-8]|
                  9[0-24578]
                )|
                7(?:
                  0[0246-9]|
                  2\\d|
                  3[0236-8]|
                  4[03-9]|
                  5[0-46-9]|
                  6[013-9]|
                  7[0-35-9]|
                  8[024-9]|
                  9[02-9]
                )|
                8(?:
                  0[35-9]|
                  2[1-57-9]|
                  3[02-578]|
                  4[0-578]|
                  5[124-9]|
                  6[2-69]|
                  7\\d|
                  8[02-9]|
                  9[02569]
                )|
                9(?:
                  0[02-589]|
                  [18]\\d|
                  2[02-689]|
                  3[1-57-9]|
                  4[2-9]|
                  5[0-579]|
                  6[2-47-9]|
                  7[0-24578]|
                  9[2-57]
                )
              )\\d\\d
            )|
            2(?:
              0[013478]|
              3[0189]|
              4[017]|
              8[0-46-9]|
              9[0-2]
            )\\d{3}
          )\\d{4}|
          1(?:
            2(?:
              0(?:
                46[1-4]|
                87[2-9]
              )|
              545[1-79]|
              76(?:
                2\\d|
                3[1-8]|
                6[1-6]
              )|
              9(?:
                7(?:
                  2[0-4]|
                  3[2-5]
                )|
                8(?:
                  2[2-8]|
                  7[0-47-9]|
                  8[3-5]
                )
              )
            )|
            3(?:
              6(?:
                38[2-5]|
                47[23]
              )|
              8(?:
                47[04-9]|
                64[0157-9]
              )
            )|
            4(?:
              044[1-7]|
              20(?:
                2[23]|
                8\\d
              )|
              6(?:
                0(?:
                  30|
                  5[2-57]|
                  6[1-8]|
                  7[2-8]
                )|
                140
              )|
              8(?:
                052|
                87[1-3]
              )
            )|
            5(?:
              2(?:
                4(?:
                  3[2-79]|
                  6\\d
                )|
                76\\d
              )|
              6(?:
                26[06-9]|
                686
              )
            )|
            6(?:
              06(?:
                4\\d|
                7[4-79]
              )|
              295[5-7]|
              35[34]\\d|
              47(?:
                24|
                61
              )|
              59(?:
                5[08]|
                6[67]|
                74
              )|
              9(?:
                55[0-4]|
                77[23]
              )
            )|
            7(?:
              26(?:
                6[13-9]|
                7[0-7]
              )|
              (?:
                442|
                688
              )\\d|
              50(?:
                2[0-3]|
                [3-68]2|
                76
              )
            )|
            8(?:
              27[56]\\d|
              37(?:
                5[2-5]|
                8[239]
              )|
              843[2-58]
            )|
            9(?:
              0(?:
                0(?:
                  6[1-8]|
                  85
                )|
                52\\d
              )|
              3583|
              4(?:
                66[1-8]|
                9(?:
                  2[01]|
                  81
                )
              )|
              63(?:
                23|
                3[1-4]
              )|
              9561
            )
          )\\d{3}
        ',
                'mobile' => '
          7(?:
            457[0-57-9]|
            700[01]|
            911[028]
          )\\d{5}|
          7(?:
            [1-3]\\d\\d|
            4(?:
              [0-46-9]\\d|
              5[0-689]
            )|
            5(?:
              0[0-8]|
              [13-9]\\d|
              2[0-35-9]
            )|
            7(?:
              0[1-9]|
              [1-7]\\d|
              8[02-9]|
              9[0-689]
            )|
            8(?:
              [014-9]\\d|
              [23][0-8]
            )|
            9(?:
              [024-9]\\d|
              1[02-9]|
              3[0-689]
            )
          )\\d{6}
        ',
                'pager' => '
          76(?:
            464|
            652
          )\\d{5}|
          76(?:
            0[0-28]|
            2[356]|
            34|
            4[01347]|
            5[49]|
            6[0-369]|
            77|
            8[14]|
            9[139]
          )\\d{6}
        ',
                'personal_number' => '70\\d{8}',
                'specialrate' => '(
          (?:
            8(?:
              4[2-5]|
              7[0-3]
            )|
            9(?:
              [01]\\d|
              8[2-49]
            )
          )\\d{7}|
          845464\\d
        )|(
          (?:
            3[0347]|
            55
          )\\d{8}
        )',
                'toll_free' => '
          80[08]\\d{7}|
          800\\d{6}|
          8001111
        ',
                'voip' => '56\\d{8}'
              };
my %areanames = ();
$areanames{en} = {"4414300", "North\ Cave\/Market\ Weighton",
"441777", "Retford",
"441980", "Amesbury",
"441438", "Stevenage",
"441427", "Gainsborough",
"441407", "Holyhead",
"441485", "Hunstanton",
"441592", "Kirkcaldy",
"441342", "East\ Grinstead",
"442829", "Kilrea",
"441306", "Dorking",
"441256", "Basingstoke",
"441237", "Bideford",
"441689", "Orpington",
"441326", "Falmouth",
"442896", "Belfast",
"4419467", "Gosforth",
"441549", "Lairg",
"441228", "Carlisle",
"441208", "Bodmin",
"4419648", "Hornsea",
"441358", "Ellon",
"441977", "Pontefract",
"441780", "Stamford",
"441568", "Leominster",
"441406", "Holbeach",
"441809", "Tomdoun",
"441829", "Tarporley",
"441442", "Hemel\ Hempstead",
"44117", "Bristol",
"441864", "Abington\ \(Crawford\)",
"441896", "Galashiels",
"441591", "Llanwrtyd\ Wells",
"441341", "Barmouth",
"441458", "Glastonbury",
"441784", "Staines",
"441244", "Chester",
"441499", "Inveraray",
"441833", "Barnard\ Castle",
"441776", "Stranraer",
"4419751", "Alford\ \(Aberdeen\)\/Strathdon",
"442897", "Saintfield",
"4414340", "Bellingham\/Haltwhistle\/Hexham",
"441695", "Skelmersdale",
"441984", "Watchet\ \(Williton\)",
"441293", "Crawley",
"441257", "Coppull",
"441307", "Forfar",
"441236", "Coatbridge",
"4414379", "Haverfordwest",
"441327", "Daventry",
"4415074", "Alford\ \(Lincs\)",
"441474", "Gravesend",
"441769", "South\ Molton",
"441932", "Weybridge",
"441889", "Rugeley",
"441751", "Pickering",
"441704", "Southport",
"4418476", "Tongue",
"4414232", "Harrogate",
"441724", "Scunthorpe",
"441951", "Colonsay",
"441697", "Brampton",
"441924", "Wakefield",
"441904", "York",
"442895", "Belfast",
"4414377", "Haverfordwest",
"441653", "Malton",
"441732", "Sevenoaks",
"441969", "Leyburn",
"441325", "Darlington",
"441255", "Clacton\-on\-Sea",
"441305", "Dorchester",
"4412292", "Barrow\-in\-Furness",
"441387", "Dumfries",
"4418518", "Stornoway",
"441775", "Spalding",
"441948", "Whitchurch",
"441573", "Kelso",
"441900", "Workington",
"4418903", "Coldstream",
"441895", "Uxbridge",
"441920", "Ware",
"441952", "Telford",
"441487", "Warboys",
"441405", "Goole",
"4415242", "Hornby",
"441425", "Ringwood",
"44238", "Southampton",
"441271", "Barnstaple",
"4413392", "Aboyne",
"441235", "Abingdon",
"441470", "Isle\ of\ Skye\ \-\ Edinbane",
"4415076", "Louth",
"441752", "Plymouth",
"441629", "Matlock",
"441386", "Evesham",
"441609", "Northallerton",
"4420", "London",
"442889", "Fivemiletown",
"441748", "Richmond",
"441931", "Shap",
"441288", "Bude",
"441664", "Melton\ Mowbray",
"4416865", "Newtown",
"441720", "Isles\ of\ Scilly",
"4418474", "Thurso",
"441633", "Newport",
"441700", "Rothesay",
"441202", "Bournemouth",
"441561", "Laurencekirk",
"441352", "Mold",
"442890", "Belfast",
"44118", "Reading",
"441866", "Kilchrenan",
"441469", "Killingholme",
"441246", "Chesterfield",
"4416973", "Wigton",
"441786", "Stirling",
"441404", "Honiton",
"4413873", "Langholm",
"441559", "Llandysul",
"441424", "Hastings",
"441598", "Lynton",
"441348", "Fishguard",
"441250", "Blairgowrie",
"441300", "Cerne\ Abbas",
"4414309", "Market\ Weighton",
"441320", "Fort\ Augustus",
"441451", "Stow\-on\-the\-Wold",
"441263", "Cromer",
"441375", "Grays\ Thurrock",
"441234", "Bedford",
"441843", "Thanet",
"44286", "Northern\ Ireland",
"442867", "Lisnaskea",
"441974", "Llanon",
"441665", "Alnwick",
"4419645", "Hornsea",
"441986", "Bungay",
"441913", "Durham",
"441432", "Hereford",
"441539", "Kendal",
"442843", "Newcastle\ \(Co\.\ Down\)",
"441431", "Helmsdale",
"441475", "Greenock",
"441332", "Derby",
"441503", "Looe",
"441725", "Rockbourne",
"4417684", "Pooley\ Bridge",
"4419753", "Strathdon",
"441970", "Aberystwyth",
"441787", "Sudbury",
"441925", "Warrington",
"442894", "Antrim",
"441905", "Worcester",
"4414370", "Haverfordwest\/Clynderwen\ \(Clunderwen\)",
"442866", "Enniskillen",
"441369", "Dunoon",
"441770", "Isle\ of\ Arran",
"441987", "Ebbsfleet",
"441452", "Gloucester",
"441562", "Kidderminster",
"441420", "Alton",
"441400", "Honington",
"441324", "Falkirk",
"4414349", "Bellingham",
"441254", "Blackburn",
"441304", "Dover",
"441738", "Perth",
"441477", "Holmes\ Chapel",
"441643", "Minehead",
"4412296", "Barrow\-in\-Furness",
"441785", "Stafford",
"441583", "Carradale",
"441245", "Chelmsford",
"441727", "St\ Albans",
"441707", "Welwyn\ Garden\ City",
"441865", "Oxford",
"441666", "Malmesbury",
"441694", "Church\ Stretton",
"441278", "Bridgwater",
"4414236", "Harrogate",
"4418472", "Thurso",
"441985", "Warminster",
"4414347", "Hexham",
"441480", "Huntingdon",
"441938", "Welshpool",
"441384", "Dudley",
"442879", "Magherafelt",
"4413394", "Ballater",
"441376", "Braintree",
"441282", "Burnley",
"4414234", "Boroughbridge",
"44151", "Liverpool",
"441690", "Betws\-y\-Coed",
"4418515", "Stornoway",
"441726", "St\ Austell",
"4414307", "Market\ Weighton",
"44292", "Cardiff",
"441706", "Rochdale",
"441476", "Grantham",
"4413880", "Bishop\ Auckland\/Stanhope\ \(Eastgate\)",
"441484", "Huddersfield",
"441758", "Pwllheli",
"441799", "Saffron\ Walden",
"4413396", "Ballater",
"441380", "Devizes",
"4415072", "Spilsby\ \(Horncastle\)",
"441879", "Scarinish",
"44247", "Coventry",
"441377", "Driffield",
"4412294", "Barrow\-in\-Furness",
"4418901", "Coldstream\/Ayton",
"441667", "Nairn",
"441942", "Wigan",
"4416868", "Newtown",
"441926", "Warwick",
"441440", "Haverhill",
"441241", "Arbroath",
"441566", "Launceston",
"441344", "Bracknell",
"441428", "Haslemere",
"441594", "Lydney",
"441408", "Golspie",
"441456", "Glenurquhart",
"4418900", "Coldstream\/Ayton",
"4419646", "Patrington",
"441778", "Bourne",
"441945", "Wisbech",
"441859", "Harris",
"441285", "Cirencester",
"441978", "Wrexham",
"441745", "Rhyl",
"441543", "Cannock",
"441227", "Canterbury",
"441357", "Strathaven",
"441207", "Consett",
"441981", "Wormbridge",
"4413881", "Bishop\ Auckland\/Stanhope\ \(Eastgate\)",
"441683", "Moffat",
"442823", "Northern\ Ireland",
"441457", "Glossop",
"441436", "Helensburgh",
"441982", "Builth\ Wells",
"441493", "Great\ Yarmouth",
"4419757", "Strathdon",
"441823", "Taunton",
"441803", "Torquay",
"441567", "Killin",
"441308", "Bridport",
"441258", "Blandford",
"441444", "Haywards\ Heath",
"441328", "Fakenham",
"441299", "Bewdley",
"44161", "Manchester",
"441590", "Lymington",
"441340", "Craigellachie\ \(Aberlour\)",
"441782", "Stoke\-on\-Trent",
"441242", "Cheltenham",
"4419644", "Patrington",
"442898", "Belfast",
"441226", "Barnsley",
"441862", "Tain",
"441356", "Brechin",
"441206", "Colchester",
"441337", "Ladybank",
"441922", "Walsall",
"441902", "Wolverhampton",
"4414371", "Haverfordwest\/Clynderwen\ \(Clunderwen\)",
"4418514", "Great\ Bernera",
"441455", "Hinckley",
"4414235", "Harrogate",
"441946", "Whitehaven",
"441763", "Royston",
"441565", "Knutsford",
"4419759", "Alford\ \(Aberdeen\)",
"441950", "Sandwick",
"441883", "Caterham",
"441388", "Bishop\ Auckland",
"441963", "Wincanton",
"4412295", "Barrow\-in\-Furness",
"441750", "Selkirk",
"44281", "Northern\ Ireland",
"441472", "Grimsby",
"441934", "Weston\-super\-Mare",
"441661", "Prudhoe",
"441335", "Ashbourne",
"441371", "Great\ Dunmow",
"441702", "Southend\-on\-Sea",
"44114", "Sheffield",
"441722", "Salisbury",
"441746", "Bridgnorth",
"441659", "Sanquhar",
"4418478", "Thurso",
"4414343", "Haltwhistle",
"441698", "Motherwell",
"441286", "Caernarfon",
"441274", "Bradford",
"441721", "Peebles",
"4415078", "Alford\ \(Lincs\)",
"441372", "Esher",
"441754", "Skegness",
"441488", "Hungerford",
"441579", "Liskeard",
"441270", "Crewe",
"441947", "Whitby",
"441471", "Isle\ of\ Skye\ \-\ Broadford",
"4414303", "North\ Cave",
"441435", "Heathfield",
"4418516", "Great\ Bernera",
"441205", "Boston",
"441355", "East\ Kilbride",
"4416862", "Llanidloes",
"441225", "Bath",
"441639", "Neath",
"441747", "Shaftesbury",
"441287", "Guisborough",
"4413395", "Aboyne",
"441954", "Madingley",
"442883", "Northern\ Ireland",
"441730", "Petersfield",
"441603", "Norwich",
"441623", "Mansfield",
"441553", "Kings\ Lynn",
"4418909", "Ayton",
"441597", "Llandrindod\ Wells",
"441347", "Easingwold",
"441972", "Glenborrodale",
"441330", "Banchory",
"441463", "Inverness",
"441301", "Arrochar",
"441450", "Hawick",
"441772", "Preston",
"441919", "Durham",
"4419642", "Hornsea",
"442868", "Kesh",
"441354", "Chatteris",
"441204", "Bolton",
"441224", "Aberdeen",
"441892", "Tunbridge\ Wells",
"441955", "Wick",
"441269", "Ammanford",
"441446", "Barry",
"441422", "Halifax",
"441560", "Moscow",
"442891", "Bangor\ \(Co\.\ Down\)",
"441529", "Sleaford",
"441248", "Bangor\ \(Gwynedd\)",
"441788", "Rugby",
"441509", "Loughborough",
"441454", "Chipping\ Sodbury",
"441350", "Dunkeld",
"441200", "Clitheroe",
"442892", "Lisburn",
"441771", "Maud",
"441322", "Dartford",
"441302", "Doncaster",
"441252", "Aldershot",
"441346", "Fraserburgh",
"441564", "Lapworth",
"442849", "Northern\ Ireland",
"441935", "Yeovil",
"441971", "Scourie",
"441673", "Market\ Rasen",
"441363", "Crediton",
"441988", "Wigtown",
"441275", "Clevedon",
"441334", "St\ Andrews",
"4414238", "Harrogate",
"4419750", "Alford\ \(Aberdeen\)\/Strathdon",
"4414341", "Bellingham\/Haltwhistle\/Hexham",
"441728", "Saxmundham",
"441708", "Romford",
"441692", "North\ Walsham",
"441481", "Guernsey",
"441740", "Sedgefield",
"441280", "Buckingham",
"44115", "Nottingham",
"441382", "Dundee",
"441478", "Isle\ of\ Skye\ \-\ Portree",
"441737", "Redhill",
"441756", "Skipton",
"441937", "Wetherby",
"4412298", "Barrow\-in\-Furness",
"441445", "Gairloch",
"441908", "Milton\ Keynes",
"441928", "Runcorn",
"4418475", "Thurso",
"4416864", "Llanidloes",
"441277", "Brentwood",
"4414373", "Clynderwen\ \(Clunderwen\)",
"441793", "Swindon",
"441595", "Lerwick\,\ Foula\ \&\ Fair\ Isle",
"44113", "Leeds",
"441873", "Abergavenny",
"441736", "Penzance",
"441757", "Selby",
"4415075", "Spilsby\ \(Horncastle\)",
"4418512", "Stornoway",
"4418907", "Ayton",
"441944", "West\ Heslerton",
"4416866", "Newtown",
"4414301", "North\ Cave\/Market\ Weighton",
"441381", "Fortrose",
"441668", "Bamburgh",
"441284", "Bury\ St\ Edmunds",
"441744", "St\ Helens",
"441276", "Camberley",
"441993", "Witney",
"441482", "Kingston\-upon\-Hull",
"4413398", "Aboyne",
"441957", "Mid\ Yell",
"441691", "Oswestry",
"441677", "Bedale",
"4419758", "Strathdon",
"4414230", "Harrogate\/Boroughbridge",
"441443", "Pontypridd",
"441989", "Ross\-on\-Wye",
"441367", "Faringdon",
"441832", "Clopton",
"4412290", "Barrow\-in\-Furness\/Millom",
"441789", "Stratford\-upon\-Avon",
"441508", "Brooke",
"441494", "High\ Wycombe",
"441528", "Laggan",
"441249", "Chippenham",
"441466", "Huntly",
"441869", "Bicester",
"4418479", "Tongue",
"441540", "Kingussie",
"442820", "Ballycastle",
"441824", "Ruthin",
"441292", "Ayr",
"441680", "Isle\ of\ Mull\ \-\ Craignure",
"442848", "Northern\ Ireland",
"441556", "Castle\ Douglas",
"441490", "Corwen",
"441291", "Chepstow",
"441394", "Felixstowe",
"441366", "Downham\ Market",
"441544", "Kington",
"441852", "Kilmelford",
"441918", "Tyneside",
"4415079", "Alford\ \(Lincs\)",
"441268", "Basildon",
"441684", "Malvern",
"441995", "Garstang",
"442824", "Northern\ Ireland",
"441676", "Meriden",
"4419641", "Hornsea\/Patrington",
"441848", "Thornhill",
"441795", "Sittingbourne",
"441593", "Lybster",
"441343", "Elgin",
"441875", "Tranent",
"441536", "Kettering",
"441557", "Kirkcudbright",
"441467", "Inverurie",
"4413390", "Aboyne\/Ballater",
"4415077", "Louth",
"441572", "Oakham",
"441669", "Rothbury",
"441379", "Diss",
"442884", "Northern\ Ireland",
"441953", "Wymondham",
"441880", "Tarbert",
"4418905", "Ayton",
"4414302", "North\ Cave",
"441624", "Isle\ of\ Man",
"441604", "Northampton",
"441651", "Oldmeldrum",
"441997", "Strathpeffer",
"441760", "Swaffham",
"441877", "Callander",
"441753", "Slough",
"441555", "Lanark",
"4414374", "Clynderwen\ \(Clunderwen\)",
"441797", "Rye",
"4416863", "Llanidloes",
"4418511", "Great\ Bernera\/Stornoway",
"4415395", "Grange\-over\-Sands",
"442311", "Southampton",
"441465", "Girvan",
"442877", "Limavady",
"44287", "Northern\ Ireland",
"441933", "Wellingborough",
"4414376", "Haverfordwest",
"441675", "Coleshill",
"441631", "Oban",
"441273", "Brighton",
"441929", "Wareham",
"441909", "Worksop",
"441588", "Bishops\ Castle",
"441709", "Rotherham",
"441729", "Settle",
"441652", "Brigg",
"441876", "Lochmaddy",
"441535", "Keighley",
"441733", "Peterborough",
"441600", "Monmouth",
"441620", "North\ Berwick",
"4414342", "Bellingham",
"441571", "Lochinver",
"441884", "Tiverton",
"442880", "Carrickmore",
"441796", "Pitlochry",
"441764", "Crieff",
"4418477", "Tongue",
"441479", "Grantown\-on\-Spey",
"441298", "Buxton",
"441329", "Fareham",
"441259", "Alloa",
"441309", "Forres",
"441674", "Montrose",
"442826", "Northern\ Ireland",
"4419755", "Alford\ \(Aberdeen\)",
"441911", "Tyneside\/Durham\/Sunderland",
"442842", "Kircubbin",
"441550", "Llandovery",
"4414239", "Boroughbridge",
"441460", "Chard",
"441333", "Peat\ Inn\ \(Leven\ \(Fife\)\)",
"441522", "Lincoln",
"441502", "Lowestoft",
"441261", "Banff",
"441841", "Newquay\ \(Padstow\)",
"441546", "Lochgilphead",
"441364", "Ashburton",
"442899", "Northern\ Ireland",
"441497", "Hay\-on\-Wye",
"441453", "Dursley",
"44239", "Portsmouth",
"441838", "Dalmally",
"441563", "Kilmarnock",
"441765", "Ripon",
"4418470", "Thurso\/Tongue",
"441827", "Tamworth",
"441807", "Ballindalloch",
"4412299", "Millom",
"441534", "Jersey",
"441885", "Pencombe",
"4413882", "Stanhope\ \(Eastgate\)",
"441223", "Cambridge",
"441353", "Ely",
"442838", "Portadown",
"4415070", "Louth\/Alford\ \(Lincs\)\/Spilsby\ \(Horncastle\)",
"441547", "Knighton",
"441397", "Fort\ William",
"442827", "Ballymoney",
"44280", "Northern\ Ireland",
"441687", "Mallaig",
"441239", "Cardigan",
"442885", "Ballygawley",
"441625", "Macclesfield",
"441530", "Coalville",
"4417687", "Keswick",
"441501", "Harthill",
"441262", "Bridlington",
"441806", "Shetland",
"4419643", "Patrington",
"441670", "Morpeth",
"441409", "Holsworthy",
"441554", "Llanelli",
"4413399", "Ballater",
"441842", "Thetford",
"441429", "Hartlepool",
"441779", "Peterhead",
"441464", "Insch",
"441496", "Port\ Ellen",
"441858", "Market\ Harborough",
"441899", "Biggar",
"441912", "Tyneside",
"441360", "Killearn",
"442841", "Rostrevor",
"441433", "Hathersage",
"441743", "Shrewsbury",
"441545", "Llanarth",
"441395", "Budleigh\ Salterton",
"441283", "Burton\-on\-Trent",
"441638", "Newmarket",
"4418513", "Stornoway",
"4416861", "Newtown\/Llanidloes",
"442887", "Dungannon",
"4418908", "Coldstream",
"441685", "Merthyr\ Tydfil",
"441994", "St\ Clears",
"442825", "Ballymena",
"442870", "Coleraine",
"441874", "Brecon",
"441581", "New\ Luce",
"44116", "Leicester",
"441886", "Bromyard\ \(Knightwick\/Leigh\ Sinton\)",
"441489", "Bishops\ Waltham",
"441766", "Porthmadog",
"441794", "Romsey",
"4414306", "Market\ Weighton",
"4414344", "Bellingham",
"441578", "Lauder",
"441943", "Guiseley",
"4413397", "Ballater",
"441641", "Strathy",
"442886", "Cookstown",
"441870", "Isle\ of\ Benbecula",
"4414237", "Harrogate",
"441606", "Northwich",
"441626", "Newton\ Abbot",
"441389", "Dumbarton",
"441642", "Middlesbrough",
"441967", "Strontian",
"4414304", "North\ Cave",
"4414346", "Hexham",
"441790", "Spilsby",
"441582", "Luton",
"44121", "Birmingham",
"4412297", "Millom",
"441495", "Pontypool",
"441887", "Aberfeldy",
"4414372", "Clynderwen\ \(Clunderwen\)",
"441805", "Torrington",
"441825", "Uckfield",
"441767", "Sandy",
"441368", "Dunbar",
"441983", "Isle\ of\ Wight",
"441916", "Tyneside",
"442821", "Martinstown",
"441681", "Isle\ of\ Mull\ \-\ Fionnphort",
"441492", "Colwyn\ Bay",
"441294", "Ardrossan",
"441822", "Tavistock",
"441449", "Stowmarket",
"4416974", "Raughton\ Head",
"441678", "Bala",
"441538", "Ipstones",
"442847", "Northern\ Ireland",
"4419756", "Strathdon",
"44291", "Cardiff",
"441243", "Chichester",
"442830", "Newry",
"441834", "Narberth",
"441527", "Redditch",
"441863", "Ardgay",
"4419754", "Alford\ \(Aberdeen\)",
"4417683", "Appleby",
"441267", "Carmarthen",
"441830", "Kirkwhelpington",
"441917", "Sunderland",
"4418519", "Great\ Bernera",
"441542", "Keith",
"441392", "Exeter",
"441854", "Ullapool",
"441506", "Bathgate",
"441821", "Kinrossie",
"441526", "Martin",
"442846", "Northern\ Ireland",
"4419647", "Patrington",
"4416860", "Newtown\/Llanidloes",
"441599", "Kyle",
"441349", "Dingwall",
"441558", "Llandeilo",
"441491", "Henley\-on\-Thames",
"441290", "Cumnock",
"442822", "Northern\ Ireland",
"4418517", "Stornoway",
"442310", "Portsmouth",
"441959", "Westerham",
"4414305", "North\ Cave",
"4418902", "Coldstream",
"441373", "Frome",
"441845", "Thirsk",
"441634", "Medway",
"441663", "New\ Mills",
"441915", "Sunderland",
"441650", "Cemmaes\ Road",
"4419649", "Hornsea",
"441761", "Temple\ Cloud",
"441586", "Campbeltown",
"4413393", "Aboyne",
"4415071", "Louth\/Alford\ \(Lincs\)\/Spilsby\ \(Horncastle\)",
"441798", "Pulborough",
"441646", "Milford\ Haven",
"441759", "Pocklington",
"441878", "Lochboisdale",
"442882", "Omagh",
"441622", "Maidstone",
"441903", "Worthing",
"441279", "Bishops\ Stortford",
"441923", "Watford",
"441654", "Machynlleth",
"441621", "Maldon",
"441570", "Lampeter",
"442881", "Newtownstewart",
"441939", "Wem",
"4418471", "Thurso\/Tongue",
"4414233", "Boroughbridge",
"441882", "Kinloch\ Rannoch",
"4414345", "Haltwhistle",
"441647", "Moretonhampstead",
"441962", "Winchester",
"441473", "Ipswich",
"4414378", "Haverfordwest",
"442845", "Northern\ Ireland",
"441723", "Scarborough",
"441525", "Leighton\ Buzzard",
"441630", "Market\ Drayton",
"441505", "Johnstone",
"4412293", "Millom",
"442893", "Ballyclare",
"441655", "Maybole",
"4419752", "Alford\ \(Aberdeen\)",
"441303", "Folkestone",
"441253", "Blackpool",
"441323", "Eastbourne",
"441297", "Axminster",
"441840", "Camelford",
"442844", "Downpatrick",
"441569", "Stonehaven",
"441828", "Coupar\ Angus",
"441808", "Tomatin",
"441461", "Gretna",
"441672", "Marlborough",
"441260", "Congleton",
"441856", "Orkney",
"441837", "Okehampton",
"441910", "Tyneside\/Durham\/Sunderland",
"441362", "Dereham",
"441524", "Lancaster",
"441233", "Ashford\ \(Kent\)",
"441361", "Duns",
"442840", "Banbridge",
"441844", "Thame",
"441688", "Isle\ of\ Mull\ \-\ Tobermory",
"441264", "Andover",
"441296", "Aylesbury",
"442828", "Larne",
"4418510", "Great\ Bernera\/Stornoway",
"441359", "Pakenham",
"441209", "Redruth",
"441548", "Kingsbridge",
"441398", "Dulverton",
"44283", "Northern\ Ireland",
"4413885", "Stanhope\ \(Eastgate\)",
"441914", "Tyneside",
"442837", "Armagh",
"441635", "Newbury",
"441520", "Lochcarron",
"441671", "Newton\ Stewart",
"441462", "Hitchin",
"441857", "Sanday",
"441773", "Ripley",
"441575", "Kirriemuir",
"441531", "Ledbury",
"441439", "Helmsley",
"4416869", "Newtown",
"441403", "Horsham",
"44131", "Edinburgh",
"441792", "Swansea",
"4414308", "Market\ Weighton",
"441872", "Truro",
"44241", "Coventry",
"442888", "Northern\ Ireland",
"441608", "Chipping\ Norton",
"441628", "Maidenhead",
"441289", "Berwick\-upon\-Tweed",
"4415073", "Louth",
"441637", "Newquay",
"441749", "Shepton\ Mallet",
"441656", "Bridgend",
"4413391", "Aboyne\/Ballater",
"442871", "Londonderry",
"4415396", "Sedbergh",
"441580", "Cranbrook",
"441949", "Whatton",
"441855", "Ballachulish",
"441577", "Kinross",
"441992", "Lea\ Valley",
"4418906", "Ayton",
"4419640", "Hornsea\/Patrington",
"4416867", "Llanidloes",
"441483", "Guildford",
"4412291", "Barrow\-in\-Furness\/Millom",
"441636", "Newark\-on\-Trent",
"441383", "Dunfermline",
"441295", "Banbury",
"441968", "Penicuik",
"4418904", "Coldstream",
"441644", "New\ Galloway",
"441768", "Penrith",
"4414375", "Clynderwen\ \(Clunderwen\)",
"4414231", "Harrogate\/Boroughbridge",
"4418473", "Thurso",
"4414348", "Hexham",
"44141", "Glasgow",
"441888", "Turriff",
"441584", "Ludlow",
"4415394", "Hawkshead",
"441871", "Castlebay",
"441576", "Lockerbie",
"441835", "St\ Boswells",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+44|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;