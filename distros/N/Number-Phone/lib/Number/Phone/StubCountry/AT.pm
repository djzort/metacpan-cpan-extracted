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
package Number::Phone::StubCountry::AT;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20221202211022;

my $formatters = [
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            1(?:
              11|
              [2-9]
            )
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d)(\\d{3,12})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '517',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{2})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '5[079]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{3,5})'
                },
                {
                  'format' => '$1',
                  'intl_format' => 'NA',
                  'leading_digits' => '[18]',
                  'pattern' => '(\\d{6})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            (?:
              31|
              4
            )6|
            51|
            6(?:
              5[0-3579]|
              [6-9]
            )|
            7(?:
              20|
              32|
              8
            )|
            [89]
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{3})(\\d{3,10})'
                },
                {
                  'format' => '$1 $2',
                  'leading_digits' => '
            [2-467]|
            5[2-6]
          ',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{4})(\\d{3,9})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '5',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{3})(\\d{3,4})'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '5',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{4})(\\d{4,7})'
                }
              ];

my $validators = {
                'fixed_line' => '
          1(?:
            11\\d|
            [2-9]\\d{3,11}
          )|
          (?:
            316|
            463|
            (?:
              51|
              66|
              73
            )2
          )\\d{3,10}|
          (?:
            2(?:
              1[467]|
              2[13-8]|
              5[2357]|
              6[1-46-8]|
              7[1-8]|
              8[124-7]|
              9[1458]
            )|
            3(?:
              1[1-578]|
              3[23568]|
              4[5-7]|
              5[1378]|
              6[1-38]|
              8[3-68]
            )|
            4(?:
              2[1-8]|
              35|
              7[1368]|
              8[2457]
            )|
            5(?:
              2[1-8]|
              3[357]|
              4[147]|
              5[12578]|
              6[37]
            )|
            6(?:
              13|
              2[1-47]|
              4[135-8]|
              5[468]
            )|
            7(?:
              2[1-8]|
              35|
              4[13478]|
              5[68]|
              6[16-8]|
              7[1-6]|
              9[45]
            )
          )\\d{4,10}
        ',
                'geographic' => '
          1(?:
            11\\d|
            [2-9]\\d{3,11}
          )|
          (?:
            316|
            463|
            (?:
              51|
              66|
              73
            )2
          )\\d{3,10}|
          (?:
            2(?:
              1[467]|
              2[13-8]|
              5[2357]|
              6[1-46-8]|
              7[1-8]|
              8[124-7]|
              9[1458]
            )|
            3(?:
              1[1-578]|
              3[23568]|
              4[5-7]|
              5[1378]|
              6[1-38]|
              8[3-68]
            )|
            4(?:
              2[1-8]|
              35|
              7[1368]|
              8[2457]
            )|
            5(?:
              2[1-8]|
              3[357]|
              4[147]|
              5[12578]|
              6[37]
            )|
            6(?:
              13|
              2[1-47]|
              4[135-8]|
              5[468]
            )|
            7(?:
              2[1-8]|
              35|
              4[13478]|
              5[68]|
              6[16-8]|
              7[1-6]|
              9[45]
            )
          )\\d{4,10}
        ',
                'mobile' => '
          6(?:
            5[0-3579]|
            6[013-9]|
            [7-9]\\d
          )\\d{4,10}
        ',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '(
          8(?:
            10|
            2[018]
          )\\d{6,10}|
          828\\d{5}
        )|(
          (?:
            8[69][2-68]|
            9(?:
              0[01]|
              3[019]
            )
          )\\d{6,10}
        )',
                'toll_free' => '800\\d{6,10}',
                'voip' => '
          5(?:
            0[1-9]|
            17|
            [79]\\d
          )\\d{2,10}|
          7[28]0\\d{6,10}
        '
              };
my %areanames = ();
$areanames{en} = {"432947", "Theras",
"432662", "Gloggnitz",
"435525", "Nenzing",
"437443", "Ybbsitz",
"435212", "Seefeld\ in\ Tirol",
"436245", "Hallein",
"436583", "Leogang",
"433457", "Gleinstätten",
"432163", "Petronell\-Carnuntum",
"432754", "Loosdorf",
"435473", "Nauders",
"436477", "St\.\ Michael\ im\ Lungau",
"433178", "St\.\ Ruprecht\ an\ der\ Raab",
"435414", "Wenns",
"432954", "Göllersdorf",
"432623", "Pottendorf",
"433337", "Vorau",
"433356", "Markt\ Allhau",
"433862", "Bruck\ an\ der\ Mur",
"433145", "Edelschrott",
"437249", "Bad\ Schallerbach",
"433328", "Kukmirn",
"435279", "St\.\ Jodok\ am\ Brenner",
"432639", "Bad\ Fischau",
"432747", "Ober\-Grafendorf",
"432287", "Strasshof\ an\ der\ Nordbahn",
"433617", "Gaishorn\ am\ See",
"434215", "Liebenfels",
"436278", "Ostermiething",
"432146", "Nickelsdorf",
"436138", "St\.\ Wolfgang\ im\ Salzkammergut",
"432734", "Langenlois",
"434826", "Mörtschach",
"434262", "Treibach",
"432816", "Karlstift",
"433456", "Fresing",
"433859", "Mürzsteg",
"436484", "Lessach",
"432763", "St\.\ Veit\ an\ der\ Gölsen",
"434842", "Sillian",
"436476", "St\.\ Margarethen\ im\ Lungau",
"432946", "Pulkau",
"437268", "Grein",
"437684", "Frankenmarkt",
"434858", "Nikolsdorf",
"435513", "Hittisau",
"437676", "Ottnang\ am\ Hausruck",
"433861", "Aflenz",
"435574", "Bregenz",
"432213", "Lassee",
"435634", "Elbigenalp",
"432746", "Wilhelmsburg",
"432286", "Obersiebenbrunn",
"434353", "Prebl",
"432274", "Sieghartskirchen",
"434223", "Maria\ Saal",
"434712", "Greifenburg",
"432147", "Zurndorf",
"433616", "Selzthal",
"432722", "Kirchberg\ an\ der\ Pielach",
"433683", "Donnersbach",
"435265", "Nassereith",
"437718", "Waldkirchen\ am\ Wesen",
"434239", "St\.\ Kanzian\ am\ Klopeiner\ See",
"435373", "Ebbs",
"432615", "Lutzmannsburg",
"433182", "Wildon",
"433336", "Waldbach",
"433357", "Pinkafeld",
"432823", "Grossglobnitz",
"434874", "Virgen",
"433579", "Pöls",
"435558", "Gaschurn",
"434766", "Millstatt",
"433134", "Heiligenkreuz\ am\ Waasen",
"436246", "Grödig",
"437953", "Liebenau",
"435526", "Laterns",
"432982", "Horn",
"434283", "St\.\ Stefan\ im\ Gailtal",
"436432", "Bad\ Hofgastein",
"433150", "Paldau",
"432862", "Heidenreichstein",
"432145", "Prellenkirchen",
"433623", "Bad\ Mitterndorf",
"432782", "Herzogenburg",
"432242", "St\.\ Andrä\-Wördern",
"437753", "Eberschwang",
"433146", "Modriach",
"433355", "Stadtschlaining",
"436234", "Zell\ am\ Moos",
"432617", "Drassmarkt",
"432258", "Alland",
"433512", "Knittelfeld",
"435243", "Maurach",
"435585", "Dalaas",
"436247", "Grossgmain",
"437675", "Ampflwang\ im\ Hausruckwald",
"432859", "Brand\-Nagelberg",
"433883", "Terz",
"432945", "Zellerndorf",
"437412", "Ybbs\ an\ der\ Donau",
"436475", "Ramingstein",
"437214", "Reichenthal",
"434825", "Grosskirchheim",
"434767", "Rothenthurn",
"433455", "Arnfels",
"437273", "Aschach\ an\ der\ Donau",
"432815", "Grossschönau",
"432683", "Purbach\ am\ Neusiedler\ See",
"432616", "Lockenhaus",
"433147", "Salla",
"433335", "Pöllau",
"432238", "Kaltenleutgeben",
"437729", "Neukirchen\ an\ der\ Enknach",
"435449", "Fliess",
"437588", "Ried\ im\ Traunkreis",
"435266", "Ötztal\-Bahnhof",
"436562", "Mittersill",
"436221", "Koppl",
"435678", "Weissenbach\ am\ Lech",
"437764", "Riedau",
"436452", "Radstadt",
"437479", "Ardagger",
"433615", "Trieben",
"432285", "Marchegg",
"437733", "Neumarkt\ im\ Hausruckkreis",
"432745", "Pyhra",
"433472", "Mureck",
"433322", "Güssing",
"436131", "Obertraun",
"432944", "Haugsdorf",
"433533", "Turrach",
"436272", "Oberndorf\ bei\ Salzburg",
"437613", "Laakirchen",
"437259", "Sierning",
"433155", "Fehring",
"437674", "Attnang\-Puchheim",
"435576", "Hohenems",
"434824", "Heiligenblut",
"432757", "Pöchlarn",
"437215", "Hellmonsödt",
"432736", "Paudorf",
"432873", "Kottes",
"433454", "Leutschach",
"432814", "Langschlag",
"433119", "St\.\ Marein\ bei\ Graz",
"435417", "Roppen",
"433868", "Tragöss",
"436413", "Wagrain",
"437261", "Schönau\ im\ Mühlkreis",
"436474", "Tamsweg",
"433363", "Rechnitz",
"432957", "Hohenwarth",
"433172", "Weiz",
"433334", "Kaindorf",
"436219", "Obertrum\ am\ See",
"432284", "Oberweiden",
"432744", "Kasten\ bei\ Böheimkirchen",
"432276", "Reidling",
"437711", "Suben",
"437563", "Spital\ am\ Pyhrn",
"437765", "Lambrechten",
"433614", "Rottenmann",
"437712", "Schärding",
"432756", "St\.\ Leonhard\ am\ Forst",
"432649", "Mönichkirchen",
"433463", "Stainz",
"434875", "Matrei\ in\ Osttirol",
"437353", "Gaflenz",
"4315", "Vienna",
"437223", "Enns",
"433171", "Gasen",
"433135", "Kalsdorf\ bei\ Graz",
"435577", "Lustenau",
"434718", "Dellach",
"437239", "Lichtenberg",
"432728", "Wienerbruck",
"432277", "Zwentendorf",
"435289", "Häusling",
"434852", "Lienz",
"437262", "Perg",
"433849", "Vordernberg",
"432144", "Deutsch\ Jahrndorf",
"434268", "Friesach",
"432956", "Ziersdorf",
"436132", "Bad\ Ischl",
"437433", "Wallsee",
"436470", "Atzmannsdorf",
"433354", "Bernstein",
"436235", "Thalgau",
"434848", "Kartitsch",
"433140", "St\.\ Martin\ am\ Wöllmissberg",
"434877", "Prägraten\ am\ Grossvenediger",
"437283", "Sarleinsbach",
"437743", "Maria\ Schmolln",
"437216", "Helfenberg",
"432735", "Hadersdorf\ am\ Kamp",
"432533", "Neusiedl\ an\ der\ Zaya",
"432252", "Baden",
"433137", "Söding",
"435575", "Langen\ bei\ Bregenz",
"432248", "Markgrafneusiedl",
"435359", "Hochfilzen",
"437766", "Andorf",
"432172", "Frauenkirchen",
"437489", "Purgstall\ an\ der\ Erlauf",
"436240", "Krispl",
"435635", "Elmen",
"436549", "Piesendorf",
"436228", "Faistenau",
"432231", "Purkersdorf",
"432988", "Neupölla",
"432275", "Atzenbrugg",
"432614", "Kleinwarasdorf",
"435552", "Bludenz",
"432673", "Altenmarkt\ an\ der\ Triesting",
"435264", "Mieming",
"437943", "Windhaag\ bei\ Freistadt",
"433136", "Dobl",
"433157", "Kapfenstein",
"436244", "Golling\ an\ der\ Salzach",
"433382", "Fürstenfeld",
"432719", "Dross",
"436458", "Hüttau",
"435524", "Satteins",
"434876", "Kals\ am\ Grossglockner",
"434733", "Malta",
"432610", "Horitschon",
"437582", "Kirchdorf\ an\ der\ Krems",
"432232", "Fischamend",
"435672", "Reutte",
"432755", "Mank",
"437217", "St\.\ Veit\ im\ Mühlkreis",
"432849", "Schwarzenau",
"433144", "Köflach",
"435253", "Längenfeld",
"432955", "Grossweikersdorf",
"432269", "Niederfellabrunn",
"434214", "Brückl",
"435339", "Wildschönau",
"437767", "Eggerding",
"434273", "Reifnitz",
"432772", "Neulengbach",
"433177", "Puch\ bei\ Weiz",
"432169", "Trautmannsdorf\ an\ der\ Leitha",
"433864", "St\.\ Marein\ im\ Mürztal",
"436478", "Zederhaus",
"432952", "Hollabrunn",
"436136", "Gosau",
"433833", "Traboch",
"437266", "Bad\ Kreuzen",
"436589", "Unken",
"432731", "Idolsberg",
"432573", "Wilfersdorf",
"432948", "Weitersfeld",
"435214", "Leutasch",
"432633", "Markt\ Piesting",
"433618", "Hohentauern",
"435273", "Matrei\ am\ Brenner",
"433385", "Ilz",
"436277", "St\.\ Pantaleon",
"434710", "Oberdrauburg",
"432748", "Kilb",
"432288", "Auersthal",
"432664", "Semmering",
"433327", "St\.\ Michael\ im\ Burgenland",
"432629", "Warth\,\ Lower\ Austria",
"433338", "Lafnitz",
"435412", "Imst",
"434253", "St\.\ Jakob\ im\ Rosental",
"432271", "Ried\ am\ Riederberg",
"437585", "Klaus\ an\ der\ Pyhrnbahn",
"437243", "Marchtrenk",
"437716", "Münzkirchen",
"432235", "Maria\-Lanzendorf",
"435675", "Tannheim",
"432752", "Melk",
"434714", "Dellach\ im\ Drautal",
"432175", "Apetlon",
"4318", "Vienna",
"437267", "Mönchdorf",
"432724", "Schwarzenbach\ an\ der\ Pielach",
"435632", "Stanzach",
"435519", "Schröcken",
"432272", "Tulln\ an\ der\ Donau",
"433184", "Wolfsberg\ im\ Schwarzautal",
"433176", "Stubenberg",
"432769", "Türnitz",
"436137", "Strobl",
"433853", "Spital\ am\ Semmering",
"433358", "Litzelsdorf",
"434233", "Griffen",
"434264", "Klein\ St\.\ Paul",
"432732", "Krems\ an\ der\ Donau",
"437717", "St\.\ Aegidi",
"432255", "Deutsch\ Brodersdorf",
"437682", "Vöcklamarkt",
"434229", "Krumpendorf\ am\ Wörther\ See",
"436276", "Nussdorf\ am\ Haunsberg",
"434359", "Reichenfels",
"435572", "Dornbirn",
"433326", "Stegersbach",
"433689", "St\.\ Nikolai\ im\ Sölktal",
"432951", "Guntersdorf",
"432784", "Perschling",
"436463", "Annaberg\-Lungötz",
"432244", "Langenzersdorf",
"437211", "Reichenau\ im\ Mühlkreis",
"434855", "Assling",
"436434", "Bad\ Gastein",
"437265", "Pabneukirchen",
"432864", "Kautzen",
"432177", "Podersdorf\ am\ See",
"433573", "Fohnsdorf",
"437663", "Steinbach\ am\ Attersee",
"436135", "Bad\ Goisern",
"432829", "Schweiggers",
"433124", "Gratkorn",
"433514", "Seckau",
"433151", "Gnas",
"435557", "St\.\ Gallenkirch",
"436232", "Mondsee",
"432236", "Mödling",
"432257", "Klausen\-Leopoldsdorf",
"437586", "Pettenbach",
"435676", "Jungholz",
"434872", "Huben",
"432618", "Markt\ St\.\ Martin",
"433633", "Landl",
"436224", "Hintersee",
"432984", "Eggenburg",
"437759", "Antiesenhofen",
"433132", "Kumberg",
"433386", "Grosssteinbach",
"434768", "Kleblach\-Lind",
"436564", "Krimml",
"437279", "Haibach\ ob\ der\ Donau",
"435556", "Schruns",
"433175", "Anger",
"432853", "Schrems",
"433474", "Deutsch\ Goritz",
"437762", "Raab",
"432176", "Tadten",
"436454", "Mandling",
"433325", "Heiligenkreuz\ im\ Lafnitztal",
"437473", "Blindenmarkt",
"437414", "Weins\-Isperdorf",
"4316", "Vienna",
"433387", "Söchau",
"433152", "Feldbach",
"437212", "Zwettl\ an\ der\ Rodl",
"435677", "Vils",
"432237", "Gaaden",
"432256", "Leobersdorf",
"432689", "Hornstein",
"437587", "Wartberg\ an\ der\ Krems",
"433148", "Kainach\ bei\ Voitsberg",
"435443", "Galtür",
"437723", "Altheim",
"433113", "Pischelsdorf\ in\ der\ Steiermark",
"433867", "Pernegg\ an\ der\ Mur",
"435418", "Schönwies",
"433332", "Hartberg",
"433174", "Birkfeld",
"432758", "Pöggstall",
"436565", "Neukirchen\ am\ Grossvenediger",
"434783", "Reisseck",
"434716", "Lesachtal",
"434243", "Bodensdorf",
"436455", "Untertauern",
"432726", "Puchenstuben",
"433612", "Liezen",
"432282", "Gänserndorf",
"432742", "St\.\ Pölten",
"433475", "Hürth",
"437619", "Kirchham",
"437253", "Wolfern",
"436274", "Lamprechtshausen",
"435582", "Klösterle",
"437260", "Waldhausen",
"437672", "Vöcklabruck",
"436213", "Oberhofen\ am\ Irrsee",
"433324", "Strem",
"432942", "Retz",
"437415", "Altenmarkt\,\ Yspertal",
"432667", "Schwarzau\ im\ Gebirge",
"436472", "Mauterndorf",
"434846", "Abfaltersbach",
"434266", "Strassburg",
"434822", "Winklern",
"432958", "Maissau",
"433452", "Leibnitz",
"432812", "Gross\ Gerungs",
"436471", "Tweng",
"437264", "Windhaag\ bei\ Perg",
"432865", "Litschau",
"432142", "Gattendorf",
"435578", "Höchst",
"434717", "Steinfeld",
"432245", "Wolkersdorf\ im\ Weinviertel",
"437233", "Feldkirchen\ an\ der\ Donau",
"433866", "Breitenau\ am\ Hochlantsch",
"433352", "Oberwart",
"432643", "Lichtenegg",
"437229", "Traun",
"432738", "Fels\ am\ Wagram",
"436134", "Hallstatt",
"433125", "Übelbach",
"433515", "St\.\ Lorenzen\ bei\ Knittelfeld",
"433469", "St\.\ Oswald\ im\ Freiland",
"433611", "Johnsbach",
"433170", "Fischbach",
"434847", "Obertilliach",
"437714", "Esternberg",
"434267", "Metnitz",
"432741", "Flinsbach",
"433331", "St\.\ Lorenzen\ am\ Wechsel",
"435283", "Kaltenbach",
"436225", "Eugendorf",
"432666", "Reichenau",
"433843", "St\.\ Michael\ in\ Obersteiermark",
"432278", "Absdorf",
"432985", "Gars\ am\ Kamp",
"434761", "Stockenboi",
"432247", "Deutsch\-Wagram",
"433476", "Bad\ Radkersburg",
"432174", "Wallern\ im\ Burgenland",
"434715", "Kötschach\-Mauthen",
"436456", "Obertauern",
"432725", "Frankenfels",
"432523", "Kirchstetten\,\ Neudorf\ bei\ Staatz",
"433127", "Peggau",
"435262", "Telfs",
"432230", "Schwadorf",
"436566", "Bramberg\ am\ Wildkogel",
"433185", "Preding",
"432612", "Oberpullendorf",
"436241", "St\.\ Koloman",
"435554", "Sonntag",
"437289", "Rohrbach\ in\ Oberösterreich",
"434265", "Weitensfeld\ im\ Gurktal",
"432254", "Ebreichsdorf",
"435239", "Kühtai",
"437949", "Rainbach\ im\ Mühlkreis",
"432987", "St\.\ Leonhard\ am\ Hornerwald",
"437483", "Oberndorf\ an\ der\ Melk",
"435223", "Hall\ in\ Tirol",
"435353", "Waidring",
"436227", "St\.\ Gilgen",
"437416", "Wieselburg",
"433141", "Hirschegg",
"436543", "Taxenbach",
"437218", "Grosstraberg",
"433516", "Kleinlobming",
"433126", "Frohnleiten",
"433583", "Unzmarkt",
"433865", "Kindberg",
"433142", "Voitsberg",
"432713", "Spitz",
"432246", "Gerasdorf\ bei\ Wien",
"433477", "St\.\ Peter\ am\ Ottersbach",
"432786", "Oberwölbling",
"432774", "Innermanzing",
"434212", "St\.\ Veit\ an\ der\ Glan",
"436457", "Flachau",
"433158", "St\.\ Anna\ am\ Aigen",
"434279", "Sirnitz",
"435333", "Söll",
"436226", "Fuschl\ am\ See",
"432665", "Prein\ an\ der\ Rax",
"435522", "Feldkirch",
"432986", "Irnfritz",
"432913", "Hötzelsdorf",
"436242", "Russbach\ am\ Pass\ Gschütt",
"432611", "Mannersdorf\ an\ der\ Rabnitz",
"437584", "Molln",
"434762", "Spittal\ an\ der\ Drau",
"432234", "Gramatneusiedl",
"432843", "Dobersberg",
"435674", "Bichlbach",
"432263", "Grossrussbach",
"435550", "Thüringen",
"434263", "Hüttenberg",
"434234", "Ruden",
"432762", "Lilienfeld",
"43662", "Salzburg",
"434843", "Ausservillgraten",
"432621", "Sieggraben",
"435355", "Jochberg",
"433847", "Trofaiach",
"437485", "Gaming",
"435225", "Fulpmes",
"435512", "Egg",
"432279", "Kirchberg\ am\ Wagram",
"436216", "Neumarkt\ am\ Wallersee",
"436545", "Bruck\ an\ der\ Grossglocknerstrasse",
"435287", "Tux",
"435579", "Alberschwende",
"432212", "Orth\ an\ der\ Donau",
"434352", "Wolfsberg",
"437237", "St\.\ Georgen\ an\ der\ Gusen",
"437256", "Ternberg",
"434713", "Techendorf",
"434246", "Radenthein",
"432723", "Rabenstein\ an\ der\ Pielach",
"433682", "Stainach",
"432525", "Gnadendorf",
"432630", "Ternitz",
"433854", "Langenwang",
"435372", "Kufstein",
"437240", "Sipbachzell",
"433468", "St\.\ Oswald\ ob\ Eibiswald",
"433116", "Kirchbach\ in\ Steiermark",
"433183", "St\.\ Georgen\ an\ der\ Stiefing",
"437228", "Kematen\ an\ der\ Krems",
"432739", "Tiefenfucha",
"432647", "Krumbach\,\ Lower\ Austria",
"435335", "Hopfgarten\ im\ Brixental",
"432663", "Schottwien",
"433846", "Kalwang",
"437442", "Waidhofen\ an\ der\ Ybbs",
"432915", "Drosendorf\-Zissersdorf",
"432634", "Gutenstein",
"435213", "Scharnitz",
"436217", "Mattsee",
"435286", "Ginzling",
"436582", "Saalfelden\ am\ Steinernen\ Meer",
"435274", "Gries\ am\ Brenner",
"437244", "Sattledt",
"434221", "Gallizien",
"432845", "Weikertschlag\ an\ der\ Thaya",
"432162", "Bruck\ an\ der\ Leitha",
"432265", "Hausleiten",
"435472", "Prutz",
"434254", "Faak\ am\ See",
"432959", "Sitzendorf\ an\ der\ Schmida",
"432878", "Traunstein",
"433834", "Wald\ am\ Schoberpass",
"433585", "St\.\ Lambrecht",
"432622", "Wiener\ Neustadt",
"433863", "Turnau",
"436418", "Kleinarl",
"432646", "Kirchschlag\ in\ der\ Buckligen\ Welt",
"433117", "Eggersdorf\ bei\ Graz",
"434230", "Globasnitz",
"437236", "Pregarten",
"432715", "Weissenkirchen\ in\ der\ Wachau",
"437257", "Grünburg",
"432574", "Gaweinstal",
"43732", "Linz",
"437618", "Neukirchen\,\ Altmünster",
"434247", "Afritz",
"435242", "Schwaz",
"436546", "Fusch\ an\ der\ Grossglocknerstrasse",
"436215", "Strasswalchen",
"434278", "Gnesau",
"437474", "Euratsfeld",
"433882", "Mariazell",
"437486", "Lunz\ am\ See",
"435226", "Neustift\ im\ Stubaital",
"435356", "Kitzbühel",
"435337", "Brixlegg",
"437413", "Marbach\ an\ der\ Donau",
"437724", "Mauerkirchen",
"435444", "Ischgl",
"432267", "Sierndorf",
"432847", "Gross\-Siegharts",
"437751", "St\.\ Martin\ im\ Innkreis",
"437272", "Eferding",
"432682", "Eisenstadt",
"433115", "Studenzen",
"437219", "Vorderweissenbach",
"433587", "Schönberg\-Lachtal",
"436563", "Uttendorf",
"434245", "Feistritz\ an\ der\ Drau",
"434785", "Ausserfragant",
"436453", "Filzmoos",
"432526", "Stronsdorf",
"437732", "Haag\ am\ Hausruck",
"432854", "Kirchberg\ am\ Walde",
"433159", "Bad\ Gleichenberg",
"432717", "Unter\-Meisling",
"437255", "Losenstein",
"433473", "Straden",
"435238", "Zirl",
"432266", "Stockerau",
"432822", "Zwettl\,\ Lower\ Austria",
"433634", "Hieflau",
"432846", "Raabs\ an\ der\ Thaya",
"437948", "Hirschbach\ im\ Mühlkreis",
"436547", "Kaprun",
"435285", "Mayrhofen",
"433845", "Mautern\ in\ Steiermark",
"437487", "Gresten",
"435357", "Kirchberg\ in\ Tirol",
"435336", "Alpbach",
"437952", "Weitersfelden",
"436223", "Anthering",
"432983", "Sigmundsherberg",
"432916", "Riegersburg\,\ Hardegg",
"432527", "Wulzeshofen",
"436433", "Dorfgastein",
"434282", "Hermagor",
"432863", "Eggern",
"437235", "Gallneukirchen",
"432716", "Gföhl",
"432243", "Klosterneuburg",
"433622", "Bad\ Aussee",
"432783", "Traismauer",
"437752", "Ried\ im\ Innkreis",
"432645", "Wiesmath",
"437664", "Weyregg\ am\ Attersee",
"437288", "Ulrichsberg",
"437748", "Eggelsberg",
"433574", "Pusterwald",
"432538", "Velm\-Götzendorf",
"433123", "St\.\ Oswald\ bei\ Plankenwarth",
"433513", "Bischoffeld",
"434879", "St\.\ Veit\ in\ Defereggen",
"433586", "Mühlen",
"437713", "Schardenberg",
"437246", "Gunskirchen",
"433359", "Loipersdorf\-Kitzladen",
"433462", "Deutschlandsberg",
"434256", "Nötsch\ im\ Gailtal",
"434237", "Miklauzhof",
"433635", "Radmer",
"433844", "Kammern\ im\ Liesingtal",
"437250", "Maria\ Neustift",
"434358", "St\.\ Andrä",
"434228", "Feistritz\ im\ Rosental",
"435284", "Gerlos",
"432636", "Puchberg\ am\ Schneeberg",
"435276", "Gschnitz",
"433688", "Tauplitz",
"434240", "Bad\ Kleinkirchheim",
"437234", "Ottensheim",
"432576", "Ernstbrunn",
"437263", "Bad\ Zell",
"434853", "Ainet",
"435518", "Mellau",
"436133", "Ebensee",
"437665", "Unterach\ am\ Attersee",
"433575", "St\.\ Johann\ am\ Tauern",
"433857", "Neuberg\ an\ der\ Mürz",
"437432", "Strengberg",
"432644", "Grimmenstein",
"432768", "St\.\ Aegyd\ am\ Neuwalde",
"433323", "Eberau",
"437475", "Hausmening\,\ Neuhofen\ an\ der\ Ybbs",
"433619", "Oppenberg",
"437230", "Altenberg\ bei\ Linz",
"433532", "Murau",
"437612", "Gmunden",
"432289", "Matzen",
"436214", "Henndorf\ am\ Wallersee",
"432749", "Prinzersdorf",
"432637", "Grünbach\ am\ Schneeberg",
"433339", "Friedberg",
"432872", "Ottenschlag",
"437247", "Kematen\ am\ Innbach",
"432628", "Felixdorf",
"436412", "St\.\ Johann\ im\ Pongau",
"434257", "Fürnitz",
"434236", "Eberndorf",
"4312", "Vienna",
"435445", "Kappl",
"436479", "Muhr",
"432168", "Mannersdorf\ am\ Leithagebirge",
"433362", "Grosspetersdorf",
"433856", "Veitsch",
"433114", "Markt\ Hartmannsdorf",
"433173", "Ratten",
"432577", "Asparn\ an\ der\ Zaya",
"432855", "Waldenstein",
"437254", "Grossraming",
"437448", "Kematen\ an\ der\ Ybbs",
"432949", "Niederfladnitz",
"434244", "Bad\ Bleiberg",
"437562", "Windischgarsten",
"4346", "Klagenfurt",
"437221", "Hörsching",
"434784", "Mallnitz",
"433461", "Trahütten",
"436588", "Lofer",
"435280", "Hochfügen",
"432635", "Neunkirchen",
"433383", "Burgau",
"435275", "Trins",
"435334", "Westendorf",
"437941", "Neumarkt\ im\ Mühlkreis",
"432914", "Japons",
"437477", "St\.\ Peter\ in\ der\ Au",
"434732", "Gmünd\ in\ Kärnten",
"435447", "Flirsch",
"432688", "Steinbrunn",
"432264", "Rückersdorf\,\ Harmannsdorf",
"437727", "Ach",
"434255", "Arnoldstein",
"433636", "Wildalpen",
"432233", "Pressbaum",
"437245", "Lambach",
"437583", "Kremsmünster",
"432552", "Poysdorf",
"433149", "Geistthal",
"435673", "Ehrwald",
"432844", "Karlstein\ an\ der\ Thaya",
"435252", "Oetz",
"434769", "Möllbrücke",
"433576", "Bretstein",
"437666", "Attersee",
"433584", "Neumarkt\ in\ Steiermark",
"437278", "Neukirchen\ am\ Walde",
"435248", "Steinberg\ am\ Rofan",
"434272", "Pörtschach\ am\ Wörther\ See",
"437480", "Langau\,\ Gaming",
"436466", "Werfenweng",
"432714", "Rossatz",
"437281", "Aigen\ im\ Mühlkreis",
"432773", "Eichgraben",
"432575", "Ladendorf",
"432857", "Bad\ Grosspertholz",
"433637", "Gams\ bei\ Hieflau",
"434235", "Bleiburg",
"434271", "Steuerberg",
"435446", "St\.\ Anton\ am\ Arlberg",
"432532", "Zistersdorf",
"437742", "Mattighofen",
"437282", "Neufelden",
"432619", "Lackendorf",
"432253", "Oberwaltersdorf",
"436544", "Rauris",
"437476", "Aschbach\-Markt",
"435354", "Fieberbrunn",
"435224", "Wattens",
"437758", "Obernberg\ am\ Inn",
"437484", "Göstling\ an\ der\ Ybbs",
"432173", "Gols",
"432524", "Kautendorf",
"432856", "Weitra",
"436467", "Mühlbach\ am\ Hochkönig",
"432828", "Rappottenstein",
"435232", "Kematen\ in\ Tirol",
"432672", "Berndorf",
"435553", "Raggal",
"433577", "Zeltweg",
"433855", "Krieglach",
"437942", "Freistadt",
"437667", "St\.\ Georgen\ im\ Attergau",
"435288", "Fügen",
"437566", "Rosenau\ am\ Hengstpass",
"433684", "St\.\ Martin\ am\ Grimming",
"432214", "Kopfstetten",
"435633", "Hägerau",
"433848", "Eisenerz",
"434224", "Pischeldorf",
"432273", "Tulbing",
"437241", "Steinerkirchen\ an\ der\ Traun",
"434354", "Preitenegg",
"434269", "Flattnitz",
"432631", "Pöttsching",
"432160", "Jois",
"435374", "Walchsee",
"433852", "Mürzzuschlag",
"437945", "St\.\ Oswald\ bei\ Freistadt",
"433366", "Kohfidisch",
"432764", "Hainfeld",
"437357", "Kleinreifling",
"434232", "Völkermarkt",
"436483", "Göriach",
"436416", "Lend",
"437227", "Neuhofen\ an\ der\ Krems",
"432648", "Hochneukirchen",
"433467", "Schwanberg",
"437745", "Lochen",
"432535", "Hohenau\ an\ der\ March",
"432733", "Schönberg\ am\ Kamp",
"432876", "Els",
"437285", "Hofkirchen\ im\ Mühlkreis",
"432620", "Willendorf",
"437616", "Grünau\ im\ Almtal",
"435514", "Bezau",
"437683", "Frankenburg\ am\ Hausruck",
"435573", "Hörbranz",
"437238", "Mauthausen",
"433536", "St\.\ Peter\ am\ Kammersberg",
"435255", "Umhausen",
"433832", "Kraubath\ an\ der\ Mur",
"432953", "Nappersdorf",
"432624", "Ebenfurth",
"434275", "Ebene\ Reichenau",
"434231", "Mittertrixen",
"435510", "Damüls",
"432572", "Mistelbach",
"432632", "Pernitz",
"434248", "Treffen",
"433680", "Donnersbachwald",
"437617", "Traunkirchen",
"436584", "Maria\ Alm\ am\ Steinernen\ Meer",
"435272", "Steinach\ am\ Brenner",
"434350", "Bad\ St\.\ Leonhard\ im\ Lavanttal",
"433537", "St\.\ Georgen\ ob\ Murau",
"434220", "Köttmannsdorf",
"437444", "Opponitz",
"437258", "Bad\ Hall",
"433466", "Eibiswald",
"434735", "Kremsbrücke",
"433118", "Sinabelkirchen",
"435474", "Pfunds",
"434252", "Wernberg",
"435413", "St\.\ Leonhard\ im\ Pitztal",
"437226", "Wilhering",
"436417", "Hüttschlag",
"437242", "Wels",
"432753", "Gansbach",
"432555", "Herrnbaumgarten",
"432877", "Grainbrunn",
"433869", "St\.\ Katharein\ an\ der\ Laming",
"432164", "Rohrau",
"437946", "Gutau",
"432848", "Pfaffenschlag\ bei\ Waidhofen",
"433365", "Deutsch\ Schützen\-Eisenberg",
"435236", "Gries\ im\ Sellrain",
"432684", "Schützen\ am\ Gebirge",
"432268", "Grossmugl",
"437734", "Hofkirchen\ an\ der\ Trattnach",
"432852", "Gmünd",
"435338", "Kundl",
"437763", "Kopfing\ im\ Innkreis",
"433631", "Unterlaussa",
"437565", "St\.\ Pankraz",
"434277", "Glanegg",
"432718", "Lichtenau\ im\ Waldviertel",
"437472", "Amstetten",
"437750", "Andrichsfurt",
"433884", "Wegscheid",
"433571", "Möderbrugg",
"433535", "Krakaudorf",
"437615", "Scharnstein",
"435244", "Jenbach",
"433153", "Riegersburg",
"437286", "Lembach\ im\ Mühlkreis",
"432557", "Bernhardsthal",
"437746", "Friedburg",
"432875", "Grafenschlag",
"437213", "Bad\ Leonfelden",
"432536", "Drösing",
"437274", "Alkoven",
"436461", "Dienten\ am\ Hochkönig",
"433588", "Katsch\ an\ der\ Mur",
"436415", "Schwarzach\ im\ Pongau",
"437722", "Braunau\ am\ Inn",
"435442", "Landeck",
"433624", "Pichl\-Kainisch",
"436462", "Bischofshofen",
"437488", "Steinakirchen\ am\ Forst",
"437754", "Waldzell",
"435358", "Ellmau",
"435441", "See",
"434284", "Kirchbach",
"432989", "Brunn\ an\ der\ Wild",
"436548", "Niedernsill",
"436229", "Hof\ bei\ Salzburg",
"434276", "Feldkirchen\ in\ Kärnten",
"437947", "Kefermarkt",
"437662", "Seewalchen\ am\ Attersee",
"433572", "Judenburg",
"437435", "St\.\ Valentin",
"437471", "Neustadtl\ an\ der\ Donau",
"4319", "Vienna",
"435256", "Untergurgl",
"436233", "Oberwang",
"437287", "Peilstein\ im\ Mühlviertel",
"432556", "Grosskrut",
"437747", "Kirchberg\ bei\ Mattighofen",
"434873", "St\.\ Jakob\ in\ Defereggen",
"434736", "Innerkrems",
"433465", "Pölfing\-Brunn",
"432824", "Allentsteig",
"4317", "Vienna",
"437225", "Hargelsberg",
"432680", "St\.\ Margarethen\ im\ Burgenland",
"433632", "St\.\ Gallen",
"437355", "Weyer",
"437954", "St\.\ Georgen\ am\ Walde",
"433133", "Nestelbach",
"432249", "Gross\-Enzersdorf",
"433687", "Schladming",
"434285", "Tröpolach",
"432143", "Kittsee",
"437232", "St\.\ Martin\ im\ Mühlkreis",
"434357", "St\.\ Paul\ im\ Lavanttal",
"434227", "Ferlach",
"437755", "Mettmach",
"4313", "Vienna",
"432642", "Aspangberg\-St\.\ Peter",
"433353", "Oberschützen",
"434238", "Eisenkappel\-Vellach",
"437719", "Taufkirchen\ an\ der\ Pram",
"437434", "Haag",
"432626", "Mattersburg",
"435476", "Serfaus",
"432825", "Göpfritz\ an\ der\ Wild",
"433464", "Gross\ St\.\ Florian",
"437224", "St\.\ Florian",
"432767", "Hohenberg",
"437251", "Schiedlberg",
"432166", "Parndorf",
"433858", "Mitterdorf\ im\ Mürztal",
"435282", "Zell\ am\ Ziller",
"43512", "Innsbruck",
"435517", "Riezlern",
"433842", "Leoben",
"437955", "Königswiesen",
"437269", "Baumgartenberg",
"433112", "Gleisdorf",
"432685", "Rust",
"433333", "Sebersdorf",
"433460", "Soboth",
"434258", "Gummern",
"437248", "Grieskirchen",
"432627", "Pitten",
"433364", "Hannersdorf",
"435376", "Thiersee",
"437564", "Hinterstoder",
"434242", "Villach",
"434782", "Obervellach",
"432638", "Winzendorf\-Muthmannsdorf",
"433613", "Admont",
"435278", "Navis",
"433329", "Jennersdorf",
"433686", "Haus",
"432743", "Böheimkirchen",
"437735", "Gaspoltshofen",
"432216", "Leopoldsdorf\ im\ Marchfelde",
"432283", "Angern\ an\ der\ March",
"434356", "Lavamünd",
"437252", "Steyr",
"434226", "St\.\ Margareten\ im\ Rosental",
"435583", "Lech",
"4314", "Vienna",
"435245", "Hinterriss",
"437614", "Vorchdorf",
"435516", "Doren",
"436212", "Seekirchen\ am\ Wallersee",
"437673", "Schwanenstadt",
"432641", "Kirchberg\ am\ Wechsel",
"433885", "Greith",
"433534", "Stadl\ an\ der\ Mur",
"432943", "Obritz",
"436414", "Grossarl",
"432766", "Kleinzell",
"435477", "Tösens",
"436473", "Mariapfarr",
"432167", "Neusiedl\ am\ See",
"432874", "Martinsberg",
"433179", "Passail",
"434823", "Tresdorf\,\ Rangersdorf",
"432813", "Arbesbach",
"437231", "Herzogsdorf",
"433453", "Ehrenhausen",
"437280", "Schwarzenberg\ am\ Böhmerwald",
"432625", "Bad\ Sauerbrunn",
"433582", "Scheifling",
"436541", "Saalbach",
"433143", "Krottendorf",
"432687", "Siegendorf",
"435448", "Pettneu\ am\ Arlberg",
"432239", "Breitenfurt\ bei\ Wien",
"435254", "Sölden",
"437728", "Schwand\ im\ Innkreis",
"432712", "Aggsbach",
"437478", "Oed\-Oehling",
"434286", "Weissbriach",
"434213", "Launsdorf",
"434274", "Velden\ am\ Wörther\ See",
"432858", "Moorbad\ Harbach",
"437956", "Unterweissenbach",
"435332", "Wörgl",
"437445", "Hollenstein\ an\ der\ Ybbs",
"432912", "Geras",
"435523", "Götzis",
"436243", "Abtenau",
"437277", "Waizenkirchen",
"432554", "Stützenhofen",
"432842", "Waidhofen\ an\ der\ Thaya",
"432165", "Hainburg\ a\.d\.\ Donau",
"432262", "Korneuburg",
"432826", "Rastenfeld",
"434734", "Rennweg",
"435475", "Feichten",
"435230", "Sellrain",
"432841", "Vitis",
"437757", "Gurten",
"432215", "Probstdorf",
"437736", "Pram",
"434225", "Grafenstein",
"434355", "Gemmersdorf",
"433685", "Gröbming",
"432522", "Laa\ an\ der\ Thaya",
"435263", "Silz",
"435375", "Kössen",
"437944", "Sandl",
"435331", "Brandenberg",
"432686", "Drassburg",
"435234", "Axams",
"432613", "Deutschkreutz",
"432259", "Münchendorf",
"433638", "Palfau",
"432674", "Weissenbach\ an\ der\ Triesting",
"433578", "Obdach",
"437744", "Munderfing",
"432534", "Niedersulz",
"435559", "Brand",
"437284", "Oberkappel",
"432711", "Dürnstein",
"437276", "Peuerbach",
"432765", "Kaumberg",
"432827", "Schönbach",
"43316", "Graz",
"433886", "Weichselboden",
"436468", "Werfen",
"433581", "Oberwölz",
"435352", "St\.\ Johann\ in\ Tirol",
"437482", "Scheibbs",
"435246", "Achenkirch",
"435515", "Au",
"436542", "Zell\ am\ See",};
$areanames{de} = {"435449", "Fließ",
"435678", "Weißenbach\ am\ Lech",
"436247", "Großgmain",
"434825", "Großkirchheim",
"432815", "Großschönau",
"432242", "Sankt\ Andrä\-Wördern",
"434283", "Sankt\ Stefan\ im\ Gailtal",
"432617", "Draßmarkt",
"432823", "Großglobnitz",
"434239", "Sankt\ Kanzian\ am\ Klopeiner\ See",
"432763", "Sankt\ Veit\ an\ der\ Gölsen",
"436476", "Sankt\ Margarethen\ im\ Lungau",
"436138", "Sankt\ Wolfgang\ im\ Salzkammergut",
"435279", "Sankt\ Jodok\ am\ Brenner",
"436477", "Sankt\ Michael\ im\ Lungau",
"433178", "Sankt\ Ruprecht\ an\ der\ Raab",
"432955", "Großweikersdorf",
"432719", "Droß",
"437217", "Sankt\ Veit\ im\ Mühlkreis",
"434876", "Kals\ am\ Großglockner",
"433140", "Sankt\ Martin\ am\ Wöllmißberg",
"434877", "Prägraten\ am\ Großvenediger",
"4315", "Wien",
"432756", "Sankt\ Leonhard\ am\ Forst",
"433868", "Tragöß",
"433119", "Sankt\ Marein\ bei\ Graz",
"4316", "Wien",
"432618", "Markt\ Sankt\ Martin",
"433386", "Großsteinbach",
"435557", "Sankt\ Gallenkirch",
"434264", "Klein\ Sankt\ Paul",
"437717", "Sankt\ Aegidi",
"433689", "Sankt\ Nikolai\ im\ Sölktal",
"436276", "Nußdorf\ am\ Haunsberg",
"4318", "Wien",
"433327", "Sankt\ Michael\ im\ Burgenland",
"436277", "Sankt\ Pantaleon",
"432629", "Warth\,\ Niederösterreich",
"434253", "Sankt\ Jakob\ im\ Rosental",
"433864", "Sankt\ Marein\ im\ Mürztal",
"436242", "Rußbach\ am\ Paß\ Gschütt",
"432263", "Großrußbach",
"437218", "Großtraberg",
"434212", "Sankt\ Veit\ an\ der\ Glan",
"433158", "Sankt\ Anna\ am\ Aigen",
"433477", "Sankt\ Peter\ am\ Ottersbach",
"432987", "Sankt\ Leonhard\ am\ Hornerwald",
"436227", "Sankt\ Gilgen",
"436241", "Sankt\ Koloman",
"433843", "Sankt\ Michael\ in\ Obersteiermark",
"433331", "Sankt\ Lorenzen\ am\ Wechsel",
"433469", "Sankt\ Oswald\ im\ Freiland",
"433515", "Sankt\ Lorenzen\ bei\ Knittelfeld",
"434266", "Straßburg",
"432812", "Groß\ Gerungs",
"436565", "Neukirchen\ am\ Großvenediger",
"432742", "Sankt\ Pölten",
"434783", "Reißeck",
"433123", "Sankt\ Oswald\ bei\ Plankenwarth",
"434879", "Sankt\ Veit\ in\ Defereggen",
"432822", "Zwettl\-Niederösterreich",
"437219", "Vorderweißenbach",
"434785", "Außerfragant",
"436546", "Fusch\ an\ der\ Großglocknerstraße",
"436215", "Straßwalchen",
"432847", "Groß\-Siegharts",
"437751", "Sankt\ Martin\ im\ Innkreis",
"433834", "Wald\ am\ Schoberpaß",
"433585", "Sankt\ Lambrecht",
"432715", "Weißenkirchen\ in\ der\ Wachau",
"437237", "Sankt\ Georgen\ an\ der\ Gusen",
"433468", "Sankt\ Oswald\ ob\ Eibiswald",
"433183", "Sankt\ Georgen\ an\ der\ Stiefing",
"432647", "Krumbach\,\ Niederösterreich",
"434843", "Außervillgraten",
"436545", "Bruck\ an\ der\ Großglocknerstraße",
"437667", "Sankt\ Georgen\ im\ Attergau",
"435446", "Sankt\ Anton\ am\ Arlberg",
"432857", "Bad\ Großpertholz",
"437477", "Sankt\ Peter\ in\ der\ Au",
"432233", "Preßbaum",
"433362", "Großpetersdorf",
"437254", "Großraming",
"436412", "Sankt\ Johann\ im\ Pongau",
"4312", "Wien",
"432768", "Sankt\ Aegyd\ am\ Neuwalde",
"433575", "Sankt\ Johann\ am\ Tauern",
"434358", "Sankt\ Andrä",
"434873", "Sankt\ Jakob\ in\ Defereggen",
"4317", "Wien",
"432680", "Sankt\ Margarethen\ im\ Burgenland",
"433632", "Sankt\ Gallen",
"432556", "Großkrut",
"432249", "Groß\-Enzersdorf",
"437954", "Sankt\ Georgen\ am\ Walde",
"4319", "Wien",
"437435", "Sankt\ Valentin",
"432268", "Großmugl",
"437565", "Sankt\ Pankraz",
"434350", "Bad\ Sankt\ Leonhard\ im\ Lavanttal",
"433537", "Sankt\ Georgen\ ob\ Murau",
"433869", "Sankt\ Katharein\ an\ der\ Laming",
"435413", "Sankt\ Leonhard\ im\ Pitztal",
"433536", "Sankt\ Peter\ am\ Kammersberg",
"437566", "Rosenau\ am\ Hengstpaß",
"433684", "Sankt\ Martin\ am\ Grimming",
"437945", "Sankt\ Oswald\ bei\ Freistadt",
"435352", "Sankt\ Johann\ in\ Tirol",
"432686", "Draßburg",
"432674", "Weißenbach\ an\ der\ Triesting",
"437956", "Unterweißenbach",
"434286", "Weißbriach",
"4314", "Wien",
"435245", "Hinterriß",
"436414", "Großarl",
"434226", "Sankt\ Margareten\ im\ Rosental",
"433464", "Groß\ Sankt\ Florian",
"437224", "Sankt\ Florian",
"434357", "Sankt\ Paul\ im\ Lavanttal",
"437232", "Sankt\ Martin\ im\ Mühlkreis",
"4313", "Wien",
"432642", "Aspangberg\-Sankt\ Peter",};

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+43|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;