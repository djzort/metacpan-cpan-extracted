=encoding utf8

=head1

Locale::CLDR::Locales::Ckb - Package for language Central Kurdish

=cut

package Locale::CLDR::Locales::Ckb;
# This file auto generated from Data/common/main/ckb.xml
#	on Mon 11 Apr  5:25:41 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.34.1');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::Root');
has 'display_name_language' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub { 
		 sub {
			 my %languages = (
				'aa' => 'ئەفار',
 				'ab' => 'ئەبخازی',
 				'ace' => 'ئاچەیی',
 				'ada' => 'دانگمێ',
 				'ady' => 'ئادیگی',
 				'af' => 'ئەفریکانس',
 				'agq' => 'ئاگێم',
 				'ain' => 'ئاینوو',
 				'ak' => 'ئاکان',
 				'ale' => 'ئالیوت',
 				'alt' => 'ئاڵتایی باشوور',
 				'am' => 'ئەمھەری',
 				'an' => 'ئاراگۆنی',
 				'anp' => 'ئەنگیکا',
 				'ar' => 'عەرەبی',
 				'ar_001' => 'عەرەبیی ستاندارد',
 				'arn' => 'ماپووچە',
 				'arp' => 'ئاراپاهۆ',
 				'as' => 'ئاسامی',
 				'asa' => 'ئاسوو',
 				'ast' => 'ئاستۆری',
 				'av' => 'ئەڤاری',
 				'awa' => 'ئاوادهی',
 				'ay' => 'ئایمارا',
 				'az' => 'ئازەربایجانی',
 				'az@alt=short' => 'ئازەربایجانی',
 				'az_Arab' => 'ئازەربایجانی باشووری',
 				'ba' => 'باشکیەر',
 				'ban' => 'بالی',
 				'bas' => 'باسا',
 				'be' => 'بیلاڕووسی',
 				'bem' => 'بێمبا',
 				'bez' => 'بێنا',
 				'bg' => 'بۆلگاری',
 				'bho' => 'بوجپووری',
 				'bi' => 'بیسلاما',
 				'bin' => 'بینی',
 				'bla' => 'سیکسیکا',
 				'bm' => 'بامبارا',
 				'bn' => 'بەنگلادێشی',
 				'bo' => 'تەبەتی',
 				'br' => 'برێتونی',
 				'brx' => 'بۆدۆ',
 				'bs' => 'بۆسنی',
 				'bug' => 'بووگی',
 				'byn' => 'بلین',
 				'ca' => 'كاتالۆنی',
 				'ce' => 'چیچانی',
 				'ceb' => 'سێبوانۆ',
 				'cgg' => 'کیگا',
 				'ch' => 'چامۆرۆ',
 				'chk' => 'چووکی',
 				'chm' => 'ماری',
 				'cho' => 'چۆکتاو',
 				'chr' => 'چێرۆکی',
 				'chy' => 'شایان',
 				'ckb' => 'کوردیی ناوەندی',
 				'co' => 'کۆرسیکی',
 				'crs' => 'فەرەنسیی سیشێلی',
 				'cs' => 'چێکی',
 				'cu' => 'سلاویی کلیسەیی',
 				'cv' => 'چووڤاشی',
 				'cy' => 'وێلزی',
 				'da' => 'دانماركی',
 				'dak' => 'داکۆتایی',
 				'dar' => 'دارگینی',
 				'dav' => 'تایتا',
 				'de' => 'ئەڵمانی',
 				'dgr' => 'دۆگریب',
 				'dje' => 'زارما',
 				'dsb' => 'سربیی خوارین',
 				'dua' => 'دووالا',
 				'dv' => 'دیڤێهی',
 				'dyo' => 'جۆلافۆنی',
 				'dz' => 'دزوونگخا',
 				'dzg' => 'دازا',
 				'ebu' => 'ئێمبوو',
 				'ee' => 'ئێوێیی',
 				'efi' => 'ئێفیک',
 				'eka' => 'ئێکاجووک',
 				'el' => 'یۆنانی',
 				'en' => 'ئینگلیزی',
 				'en_AU' => 'ئینگلیزیی ئۆسترالیایی',
 				'en_CA' => 'ئینگلیزیی کەنەدایی',
 				'en_GB' => 'ئینگلیزیی بریتانیایی',
 				'en_GB@alt=short' => 'ئینگلیزی (GB)',
 				'en_US' => 'ئینگلیزیی ئەمەریکایی',
 				'en_US@alt=short' => 'ئینگلیزیی ئەمەریکایی',
 				'eo' => 'ئێسپیرانتۆ',
 				'es' => 'ئیسپانی',
 				'et' => 'ئیستۆنی',
 				'eu' => 'باسکی',
 				'ewo' => 'ئێوۆندۆ',
 				'fa' => 'فارسی',
 				'ff' => 'فوولایی',
 				'fi' => 'فینلەندی',
 				'fil' => 'فیلیپینی',
 				'fj' => 'فیجی',
 				'fo' => 'فەرۆیی',
 				'fon' => 'فۆنی',
 				'fr' => 'فەرەنسی',
 				'fur' => 'فریئوولی',
 				'fy' => 'فریسیی ڕۆژاوا',
 				'ga' => 'ئیرلەندی',
 				'gaa' => 'گایی',
 				'gd' => 'گه‌لیكی سكۆتله‌ندی',
 				'gez' => 'گیزی',
 				'gil' => 'گیلبێرتی',
 				'gl' => 'گالیسی',
 				'gn' => 'گووارانی',
 				'gor' => 'گۆرۆنتالی',
 				'gsw' => 'ئەڵمانیی سویسڕا',
 				'gu' => 'گوجاراتی',
 				'guz' => 'گووسی',
 				'gv' => 'مانکی',
 				'gwi' => 'گویچین',
 				'ha' => 'هائووسا',
 				'haw' => 'هاوایی',
 				'he' => 'عیبری',
 				'hi' => 'هیندی',
 				'hil' => 'هیلیگاینۆن',
 				'hmn' => 'همۆنگ',
 				'hr' => 'كرواتی',
 				'hsb' => 'سربیی سەروو',
 				'ht' => 'کریولی هائیتی',
 				'hu' => 'هەنگاری (مەجاری)',
 				'hup' => 'هووپا',
 				'hy' => 'ئەرمەنی',
 				'hz' => 'هێرێرۆ',
 				'ia' => 'ئینترلینگووا',
 				'iba' => 'ئیبان',
 				'ibb' => 'ئیبیبۆ',
 				'id' => 'ئیندۆنیزی',
 				'ie' => 'ئینتەرلیگ',
 				'ig' => 'ئیگبۆ',
 				'ii' => 'سیچوان یی',
 				'ilo' => 'ئیلۆکۆ',
 				'inh' => 'ئینگووش',
 				'io' => 'ئیدۆ',
 				'is' => 'ئیسلەندی',
 				'it' => 'ئیتالی',
 				'iu' => 'ئینوکتیتوت',
 				'ja' => 'ژاپۆنی',
 				'jbo' => 'لۆژبان',
 				'jgo' => 'نگۆمبا',
 				'jmc' => 'ماچامێ',
 				'jv' => 'جاڤایی',
 				'ka' => 'گۆرجستانی',
 				'kab' => 'کبائیلی',
 				'kac' => 'کاچین',
 				'kaj' => 'کیجوو',
 				'kam' => 'کامبا',
 				'kbd' => 'کاباردی',
 				'kcg' => 'تیاپ',
 				'kde' => 'ماکۆندە',
 				'kea' => 'کابووڤێردیانۆ',
 				'kfo' => 'کۆرۆ',
 				'kha' => 'کهاسی',
 				'khq' => 'کۆیرا چینی',
 				'ki' => 'کیکوویوو',
 				'kj' => 'کوانیاما',
 				'kk' => 'کازاخی',
 				'kkj' => 'کاکۆ',
 				'kl' => 'کالالیسووت',
 				'kln' => 'کالێنجین',
 				'km' => 'خمێر',
 				'kmb' => 'کیمبووندوو',
 				'kn' => 'کاننادا',
 				'ko' => 'كۆری',
 				'kok' => 'کۆنکانی',
 				'kpe' => 'کپێلێ',
 				'kr' => 'کانووری',
 				'krc' => 'کاراچای بالکار',
 				'krl' => 'کارێلی',
 				'kru' => 'کوورووخ',
 				'ks' => 'کەشمیری',
 				'ksb' => 'شامابالا',
 				'ksf' => 'بافیا',
 				'ksh' => 'کۆلۆنی',
 				'ku' => 'کوردی',
 				'kum' => 'کوومیک',
 				'kv' => 'کۆمی',
 				'kw' => 'کۆڕنی',
 				'ky' => 'كرگیزی',
 				'la' => 'لاتینی',
 				'lad' => 'لادینۆ',
 				'lag' => 'لانگی',
 				'lb' => 'لوکسەمبورگی',
 				'lez' => 'لەزگی',
 				'lg' => 'گاندا',
 				'li' => 'لیمبورگی',
 				'lkt' => 'لاکۆتا',
 				'ln' => 'لينگالا',
 				'lo' => 'لائۆیی',
 				'loz' => 'لۆزی',
 				'lrc' => 'لوڕیی باکوور',
 				'lt' => 'لیتوانی',
 				'lu' => 'لووبا کاتانگا',
 				'lua' => 'لووبا لوولووا',
 				'lun' => 'لووندا',
 				'luo' => 'لووئۆ',
 				'lus' => 'میزۆ',
 				'luy' => 'لوویا',
 				'lv' => 'لێتۆنی',
 				'mad' => 'مادووری',
 				'mag' => 'ماگاهی',
 				'mai' => 'مائیتیلی',
 				'mak' => 'ماکاسار',
 				'mas' => 'ماسایی',
 				'mdf' => 'مۆکشا',
 				'men' => 'مێندێ',
 				'mer' => 'مێروو',
 				'mfe' => 'مۆریسی',
 				'mg' => 'مالاگاسی',
 				'mgh' => 'ماخوامیتۆ',
 				'mgo' => 'مێتە',
 				'mh' => 'مارشاڵی',
 				'mi' => 'مائۆری',
 				'mic' => 'میکماک',
 				'min' => 'مینانکاباو',
 				'mk' => 'ماكێدۆنی',
 				'ml' => 'مالایالام',
 				'mn' => 'مەنگۆلی',
 				'mni' => 'مانیپووری',
 				'moh' => 'مۆهاوک',
 				'mos' => 'مۆسی',
 				'mr' => 'ماراتی',
 				'ms' => 'مالیزی',
 				'mt' => 'ماڵتی',
 				'mua' => 'موندانگ',
 				'mul' => 'چەند زمان',
 				'mus' => 'کریک',
 				'mwl' => 'میراندی',
 				'my' => 'میانماری',
 				'myv' => 'ئێرزیا',
 				'mzn' => 'مازەندەرانی',
 				'na' => 'نائوروو',
 				'nap' => 'ناپۆلی',
 				'naq' => 'ناما',
 				'nb' => 'نەرویژیی بۆکمال',
 				'nd' => 'ئندێبێلێی باکوور',
 				'ne' => 'نیپالی',
 				'new' => 'نێواری',
 				'ng' => 'ندۆنگا',
 				'nia' => 'نیاس',
 				'niu' => 'نیئوویی',
 				'nl' => 'هۆڵەندی',
 				'nl_BE' => 'فلێمی',
 				'nmg' => 'کواسیۆ',
 				'nn' => 'نەرویژیی نینۆرسک',
 				'nnh' => 'نگیمبوون',
 				'no' => 'نۆروێژی',
 				'nog' => 'نۆگای',
 				'nqo' => 'نکۆ',
 				'nr' => 'ئندێبێلێی باشوور',
 				'nso' => 'سۆتۆی باکوور',
 				'nus' => 'نوێر',
 				'nv' => 'ناڤاجۆ',
 				'ny' => 'نیانجا',
 				'nyn' => 'نیانکۆلێ',
 				'oc' => 'ئۆکسیتانی',
 				'om' => 'ئۆرۆمۆ',
 				'or' => 'ئۆدیا',
 				'os' => 'ئۆسێتی',
 				'pa' => 'پەنجابی',
 				'pag' => 'پانگاسینان',
 				'pam' => 'پامپانگا',
 				'pap' => 'پاپیامێنتۆ',
 				'pau' => 'پالائوویی',
 				'pcm' => 'پیجینی نیجریا',
 				'pl' => 'پۆڵەندی',
 				'prg' => 'پڕووسی',
 				'ps' => 'پەشتوو',
 				'pt' => 'پورتوگالی',
 				'qu' => 'کێچوا',
 				'quc' => 'کیچەیی',
 				'rap' => 'ڕاپانوویی',
 				'rar' => 'ڕاڕۆتۆنگان',
 				'rm' => 'ڕۆمانش',
 				'rn' => 'ڕووندی',
 				'ro' => 'ڕۆمانی',
 				'ro_MD' => 'مۆڵداڤی',
 				'rof' => 'ڕۆمبۆ',
 				'root' => 'ڕووت',
 				'ru' => 'ڕووسی',
 				'rup' => 'ئارمۆمانی',
 				'rw' => 'کینیارواندا',
 				'rwk' => 'ڕوا',
 				'sa' => 'سانسکريت',
 				'sad' => 'سانداوێ',
 				'sah' => 'ساخا',
 				'saq' => 'سامبووروو',
 				'sat' => 'سانتالی',
 				'sba' => 'نگامبای',
 				'sbp' => 'سانگوو',
 				'sc' => 'ساردینی',
 				'scn' => 'سیسیلی',
 				'sco' => 'سکۆتس',
 				'sd' => 'سيندی',
 				'sdh' => 'کوردیی باشووری',
 				'se' => 'سامیی باکوور',
 				'seh' => 'سێنا',
 				'ses' => 'کۆیرابۆرۆ سێنی',
 				'sg' => 'سانگۆ',
 				'sh' => 'سێربۆكرواتی',
 				'shi' => 'شیلها',
 				'shn' => 'شان',
 				'si' => 'سینهالی',
 				'sk' => 'سلۆڤاكی',
 				'sl' => 'سلۆڤێنی',
 				'sm' => 'سامۆیی',
 				'sma' => 'سامیی باشوور',
 				'smj' => 'لوولێ سامی',
 				'smn' => 'ئیناری سامی',
 				'sms' => 'سامیی سکۆڵت',
 				'sn' => 'شۆنا',
 				'snk' => 'سۆنینکێ',
 				'so' => 'سۆمالی',
 				'sq' => 'ئەڵبانی',
 				'sr' => 'سربی',
 				'srn' => 'سرانان تۆنگۆ',
 				'ss' => 'سواتی',
 				'ssy' => 'ساهۆ',
 				'st' => 'سۆتۆی باشوور',
 				'su' => 'سوندانی',
 				'suk' => 'سووکووما',
 				'sv' => 'سویدی',
 				'sw' => 'سواهیلی',
 				'sw_CD' => 'سواهیلیی کۆنگۆ',
 				'swb' => 'کۆمۆری',
 				'syr' => 'سریانی',
 				'ta' => 'تامیلی',
 				'te' => 'تێلووگوو',
 				'tem' => 'تیمنێ',
 				'teo' => 'تێسوو',
 				'tet' => 'تێتووم',
 				'tg' => 'تاجیکی',
 				'th' => 'تایلەندی',
 				'ti' => 'تیگرینیا',
 				'tig' => 'تیگرێ',
 				'tk' => 'تورکمانی',
 				'tlh' => 'كلینگۆن',
 				'tn' => 'تسوانا',
 				'to' => 'تۆنگان',
 				'tpi' => 'تۆکپیسین',
 				'tr' => 'تورکی',
 				'trv' => 'تارۆکۆ',
 				'ts' => 'تسۆنگا',
 				'tt' => 'تاتاری',
 				'tum' => 'تومبووکا',
 				'tvl' => 'تووڤالوو',
 				'tw' => 'توی',
 				'twq' => 'تاساواک',
 				'ty' => 'تاهیتی',
 				'tyv' => 'تووڤینی',
 				'tzm' => 'ئەمازیغی ناوەڕاست',
 				'udm' => 'ئوودموورت',
 				'ug' => 'ئۆیخۆری',
 				'uk' => 'ئۆكراینی',
 				'umb' => 'ئومبووندوو',
 				'und' => 'زمانی نەناسراو',
 				'ur' => 'ئۆردوو',
 				'uz' => 'ئوزبەکی',
 				'vai' => 'ڤایی',
 				've' => 'ڤێندا',
 				'vi' => 'ڤیەتنامی',
 				'vo' => 'ڤۆلاپووک',
 				'vun' => 'ڤوونجوو',
 				'wa' => 'والوون',
 				'wae' => 'والسێر',
 				'wal' => 'وۆلایتا',
 				'war' => 'وارای',
 				'wo' => 'وۆلۆف',
 				'xal' => 'کالمیک',
 				'xh' => 'سسوسا',
 				'xog' => 'سۆگا',
 				'yav' => 'یانگبێن',
 				'ybb' => 'یێمبا',
 				'yi' => 'ییدیش',
 				'yo' => 'یۆرووبا',
 				'yue' => 'کانتۆنی',
 				'zgh' => 'ئەمازیغیی مەغریب',
 				'zh' => 'چینی',
 				'zh_Hans' => 'چینی (چینیی ئاسانکراو)',
 				'zh_Hant' => 'چینی (چینیی دێرین)',
 				'zu' => 'زوولوو',
 				'zun' => 'زوونی',
 				'zxx' => 'هیچ ناوەرۆکی زمانی نیە',
 				'zza' => 'زازا',

			);
			if (@_) {
				return $languages{$_[0]};
			}
			return \%languages;
		}
	},
);

has 'display_name_script' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub {
		sub {
			my %scripts = (
			'Arab' => 'عەرەبی',
 			'Armn' => 'ئەرمەنی',
 			'Beng' => 'بەنگالی',
 			'Bopo' => 'بۆپۆمۆفۆ',
 			'Brai' => 'برەیل',
 			'Cyrl' => 'سریلیک',
 			'Deva' => 'دەڤەناگەری',
 			'Ethi' => 'ئەتیۆپیک',
 			'Geor' => 'گورجی',
 			'Grek' => 'یۆنانی',
 			'Gujr' => 'گوجەراتی',
 			'Guru' => 'گورموکھی',
 			'Hanb' => 'هان لەگەڵ بۆپۆمۆفۆ',
 			'Hang' => 'ھانگول',
 			'Hani' => 'ھان',
 			'Hans' => 'ئاسانکراو',
 			'Hans@alt=stand-alone' => 'هانی ئاسانکراو',
 			'Hant' => 'دێرین',
 			'Hant@alt=stand-alone' => 'هانی دێرین',
 			'Hebr' => 'عیبری',
 			'Hira' => 'ھیراگانا',
 			'Hrkt' => 'ژاپۆنیی بڕگەیی',
 			'Jamo' => 'جامۆ',
 			'Jpan' => 'ژاپۆنی',
 			'Kana' => 'کاتاکانا',
 			'Khmr' => 'خمێر',
 			'Knda' => 'کاننادا',
 			'Kore' => 'کۆری',
 			'Laoo' => 'لائۆ',
 			'Latn' => 'لاتینی',
 			'Mlym' => 'مالایالام',
 			'Mong' => 'مەنگۆلی',
 			'Mymr' => 'میانمار',
 			'Orya' => 'ئۆدیا',
 			'Sinh' => 'سینھالا',
 			'Taml' => 'تامیلی',
 			'Telu' => 'تێلووگوو',
 			'Thaa' => 'تانا',
 			'Thai' => 'تایلەندی',
 			'Tibt' => 'تەبەتی',
 			'Zmth' => 'نیشانەی بیرکاری',
 			'Zsye' => 'ئیمۆجی',
 			'Zsym' => 'هێماکان',
 			'Zxxx' => 'نەنووسراو',
 			'Zyyy' => 'باو',
 			'Zzzz' => 'خەتی نەناسراو',

			);
			if ( @_ ) {
				return $scripts{$_[0]};
			}
			return \%scripts;
		}
	}
);

has 'display_name_region' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { 
		{
			'001' => 'جیهان',
 			'002' => 'ئەفریقا',
 			'003' => 'ئەمەریکای باکوور',
 			'005' => 'ئەمەریکای باشوور',
 			'009' => 'ئۆقیانووسیا',
 			'011' => 'ڕۆژاوای ئەفریقا',
 			'013' => 'ئەمریکای ناوەڕاست',
 			'014' => 'ڕۆژھەڵاتی ئەفریقا',
 			'015' => 'باکووری ئەفریقا',
 			'017' => 'ناوەڕاستی ئەفریقا',
 			'018' => 'باشووری ئەفریقا',
 			'019' => 'ئەمەریکای باکوور و باشوور',
 			'021' => 'ئەمریکای باکوور',
 			'029' => 'کاریبی',
 			'030' => 'ڕۆژهەڵاتی ئاسیا',
 			'034' => 'باشووری ئاسیا',
 			'035' => 'باشووری ڕۆژھەڵاتی ئاسیا',
 			'039' => 'باشووری ئەورووپا',
 			'053' => 'ئۆسترالیا',
 			'054' => 'میلانێزیا',
 			'057' => 'ناوچەی مایکرۆنیزیا',
 			'061' => 'پۆلینیزیا',
 			'142' => 'ئاسیا',
 			'143' => 'ناوەڕاستی ئاسیا',
 			'145' => 'ڕۆژاوای ئاسیا',
 			'150' => 'ئەورووپا',
 			'151' => 'ڕۆژهەڵاتی ئەورووپا',
 			'154' => 'باکووری ئەورووپا',
 			'155' => 'ڕۆژاوای ئەورووپا',
 			'202' => 'ئەفریقای ژێر سەحرا',
 			'419' => 'ئەمەریکای لاتین',
 			'AC' => 'دوورگەی ئاسینسیۆن',
 			'AD' => 'ئاندۆرا',
 			'AE' => 'میرنشینە یەکگرتووە عەرەبییەکان',
 			'AF' => 'ئەفغانستان',
 			'AG' => 'ئانتیگوا و باربودا',
 			'AI' => 'ئانگویلا',
 			'AL' => 'ئەڵبانیا',
 			'AM' => 'ئەرمەنستان',
 			'AO' => 'ئەنگۆلا',
 			'AQ' => 'ئانتارکتیکا',
 			'AR' => 'ئەرژەنتین',
 			'AS' => 'ساموای ئەمەریکایی',
 			'AT' => 'نەمسا',
 			'AU' => 'ئوسترالیا',
 			'AW' => 'ئارووبا',
 			'AX' => 'دوورگەکانی ئالاند',
 			'AZ' => 'ئازەربایجان',
 			'BA' => 'بۆسنیا و ھەرزەگۆڤینا',
 			'BB' => 'باربادۆس',
 			'BD' => 'بەنگلادیش',
 			'BE' => 'بەلژیک',
 			'BF' => 'بورکینافاسۆ',
 			'BG' => 'بولگاریا',
 			'BH' => 'بەحرەین',
 			'BI' => 'بوروندی',
 			'BJ' => 'بێنین',
 			'BL' => 'سەن بارتێلێمی',
 			'BM' => 'بێرموودا',
 			'BN' => 'بروونای',
 			'BO' => 'بۆلیڤیا',
 			'BQ' => 'دوورگە کاریبیەکانی هۆڵەندا',
 			'BR' => 'برازیل',
 			'BS' => 'بەھاما',
 			'BT' => 'بووتان',
 			'BV' => 'دوورگەی بووڤێ',
 			'BW' => 'بۆتسوانا',
 			'BY' => 'بیلاڕووس',
 			'BZ' => 'بەلیز',
 			'CA' => 'کەنەدا',
 			'CC' => 'دوورگەکانی کیلینگ',
 			'CD' => 'کۆنگۆ کینشاسا',
 			'CD@alt=variant' => 'کۆماری دیموکراتیکی کۆنگۆ',
 			'CF' => 'کۆماری ئەفریقای ناوەڕاست',
 			'CG' => 'کۆنگۆ برازاڤیل',
 			'CG@alt=variant' => 'کۆماری کۆنگۆ',
 			'CH' => 'سویسڕا',
 			'CI' => 'کۆتدیڤوار',
 			'CK' => 'دوورگەکانی کوک',
 			'CL' => 'چیلی',
 			'CM' => 'کامیرۆن',
 			'CN' => 'چین',
 			'CO' => 'کۆلۆمبیا',
 			'CP' => 'دوورگەی کلیپێرتۆن',
 			'CR' => 'کۆستاریکا',
 			'CU' => 'کووبا',
 			'CV' => 'کەیپڤەرد',
 			'CW' => 'کوراچاو',
 			'CX' => 'دوورگەی کریسمس',
 			'CY' => 'قیبرس',
 			'CZ' => 'کۆماری چیک',
 			'DE' => 'ئەڵمانیا',
 			'DG' => 'دیەگۆ گارسیا',
 			'DJ' => 'جیبووتی',
 			'DK' => 'دانمارک',
 			'DM' => 'دۆمینیکا',
 			'DO' => 'کۆماری دۆمینیکا',
 			'DZ' => 'جەزایر',
 			'EA' => 'سێئووتا و مێلییا',
 			'EC' => 'ئیکوادۆر',
 			'EE' => 'ئیستۆنیا',
 			'EG' => 'میسر',
 			'EH' => 'سەحرای ڕۆژاوا',
 			'ER' => 'ئەریتریا',
 			'ES' => 'ئیسپانیا',
 			'ET' => 'ئەتیۆپیا',
 			'EU' => 'یەکێتیی ئەورووپا',
 			'EZ' => 'ناوچەی یۆرۆ',
 			'FI' => 'فینلاند',
 			'FJ' => 'فیجی',
 			'FK' => 'دوورگەکانی مالڤیناس',
 			'FM' => 'مایکرۆنیزیا',
 			'FO' => 'دوورگەکانی فارەو',
 			'FR' => 'فەڕەنسا',
 			'GA' => 'گابۆن',
 			'GB' => 'شانشینی یەکگرتوو',
 			'GB@alt=short' => 'شانشینی یەکگرتوو',
 			'GD' => 'گرینادا',
 			'GE' => 'گورجستان',
 			'GF' => 'گیانای فەرەنسا',
 			'GG' => 'گێرنزی',
 			'GH' => 'غەنا',
 			'GI' => 'گیبرالتار',
 			'GL' => 'گرینلاند',
 			'GM' => 'گامبیا',
 			'GN' => 'گینێ',
 			'GP' => 'گوادێلۆپ',
 			'GQ' => 'گینێی ئیستوایی',
 			'GR' => 'یۆنان',
 			'GS' => 'دوورگەکانی جۆرجیا و ساندویچی باشوور',
 			'GT' => 'گواتیمالا',
 			'GU' => 'گوام',
 			'GW' => 'گینێ بیساو',
 			'GY' => 'گویانا',
 			'HK' => 'هۆنگ کۆنگ',
 			'HK@alt=short' => 'هۆنگ کۆنگ',
 			'HM' => 'دوورگەکانی هێرد و مەکدانڵد',
 			'HN' => 'ھۆندووراس',
 			'HR' => 'کرۆواتیا',
 			'HT' => 'ھایتی',
 			'HU' => 'هەنگاریا',
 			'IC' => 'دوورگەکانی کەناری',
 			'ID' => 'ئیندۆنیزیا',
 			'IE' => 'ئیرلەند',
 			'IL' => 'ئیسرائیل',
 			'IM' => 'دوورگەی مان',
 			'IN' => 'ھیندستان',
 			'IO' => 'ھەرێمی بەریتانی لە ئۆقیانووسی ھیند',
 			'IQ' => 'عێراق',
 			'IR' => 'ئێران',
 			'IS' => 'ئایسلەند',
 			'IT' => 'ئیتالیا',
 			'JE' => 'جێرسی',
 			'JM' => 'جامایکا',
 			'JO' => 'ئوردن',
 			'JP' => 'ژاپۆن',
 			'KE' => 'کینیا',
 			'KG' => 'قرغیزستان',
 			'KH' => 'کەمبۆدیا',
 			'KI' => 'کیریباس',
 			'KM' => 'دوورگەکانی کۆمۆر',
 			'KN' => 'سەن کیتس و نیڤیس',
 			'KP' => 'کۆریای باکوور',
 			'KR' => 'کۆریای باشوور',
 			'KW' => 'کوەیت',
 			'KY' => 'دوورگەکانی کایمان',
 			'KZ' => 'کازاخستان',
 			'LA' => 'لاوس',
 			'LB' => 'لوبنان',
 			'LC' => 'سەن لووسیا',
 			'LI' => 'لیختنشتاین',
 			'LK' => 'سریلانکا',
 			'LR' => 'لیبەریا',
 			'LS' => 'لەسۆتۆ',
 			'LT' => 'لیتوانایا',
 			'LU' => 'لوکسەمبورگ',
 			'LV' => 'لاتڤیا',
 			'LY' => 'لیبیا',
 			'MA' => 'مەغریب',
 			'MC' => 'مۆناکۆ',
 			'MD' => 'مۆلدۆڤا',
 			'ME' => 'مۆنتینیگرۆ',
 			'MF' => 'سەن مارتین',
 			'MG' => 'ماداگاسکار',
 			'MH' => 'دوورگەکانی مارشاڵ',
 			'MK' => 'ماکەدۆنیا',
 			'ML' => 'مالی',
 			'MM' => 'میانمار',
 			'MN' => 'مەنگۆلیا',
 			'MO' => 'ماکائۆ',
 			'MO@alt=short' => 'ماکائۆ',
 			'MP' => 'دوورگەکانی ماریانای باکوور',
 			'MQ' => 'مارتینیک',
 			'MR' => 'مۆریتانیا',
 			'MS' => 'مۆنتسێرات',
 			'MT' => 'ماڵتا',
 			'MU' => 'مووریتیووس',
 			'MV' => 'مالدیڤ',
 			'MW' => 'مالاوی',
 			'MX' => 'مەکسیک',
 			'MY' => 'مالیزیا',
 			'MZ' => 'مۆزامبیک',
 			'NA' => 'نامیبیا',
 			'NC' => 'نیووکالێدۆنیا',
 			'NE' => 'نیجەر',
 			'NF' => 'دوورگەی نۆرفۆڵک',
 			'NG' => 'نیجریا',
 			'NI' => 'نیکاراگوا',
 			'NL' => 'ھۆڵەندا',
 			'NO' => 'نۆرویژ',
 			'NP' => 'نیپال',
 			'NR' => 'نائوروو',
 			'NU' => 'نیووئی',
 			'NZ' => 'نیوزیلاند',
 			'OM' => 'عومان',
 			'PA' => 'پاناما',
 			'PE' => 'پێروو',
 			'PF' => 'پۆلینیسیای فەرەنسا',
 			'PG' => 'پاپوا گینێی نوێ',
 			'PH' => 'فلیپین',
 			'PK' => 'پاکستان',
 			'PL' => 'پۆڵەندا',
 			'PM' => 'سەن پیێر و میکێلۆن',
 			'PN' => 'دوورگەکانی پیتکەرن',
 			'PR' => 'پۆرتۆڕیکۆ',
 			'PS' => 'ناوچە فەلەستینیەکان',
 			'PS@alt=short' => 'فەلەستین',
 			'PT' => 'پورتوگال',
 			'PW' => 'پالاو',
 			'PY' => 'پاراگوای',
 			'QA' => 'قەتەر',
 			'QO' => 'دەرەوەی ئۆقیانووسیا',
 			'RE' => 'ڕییوونیەن',
 			'RO' => 'ڕۆمانیا',
 			'RS' => 'سربیا',
 			'RU' => 'ڕووسیا',
 			'RW' => 'ڕواندا',
 			'SA' => 'عەرەبستانی سەعوودی',
 			'SB' => 'دوورگەکانی سلێمان',
 			'SC' => 'سیشێل',
 			'SD' => 'سوودان',
 			'SE' => 'سوید',
 			'SG' => 'سینگاپور',
 			'SH' => 'سەن هێلێنا',
 			'SI' => 'سلۆڤێنیا',
 			'SJ' => 'سڤالبارد و یان مایەن',
 			'SK' => 'سلۆڤاکیا',
 			'SL' => 'سیەرالیۆن',
 			'SM' => 'سان مارینۆ',
 			'SN' => 'سێنێگاڵ',
 			'SO' => 'سۆمالیا',
 			'SR' => 'سورینام',
 			'SS' => 'سوودانی باشوور',
 			'ST' => 'ساوتۆمێ و پرینسیپی',
 			'SV' => 'ئێلسالڤادۆر',
 			'SX' => 'سینت مارتن',
 			'SY' => 'سووریا',
 			'SZ' => 'سوازیلاند',
 			'TA' => 'تریستێن دا کوونا',
 			'TC' => 'دوورگەکانی تورکس و کایکۆس',
 			'TD' => 'چاد',
 			'TF' => 'هەرێمە باشووریەکانی فەرەنسا',
 			'TG' => 'تۆگۆ',
 			'TH' => 'تایلەند',
 			'TJ' => 'تاجیکستان',
 			'TK' => 'تۆکێلاو',
 			'TL' => 'تیمۆری ڕۆژھەڵات',
 			'TM' => 'تورکمانستان',
 			'TN' => 'توونس',
 			'TO' => 'تۆنگا',
 			'TR' => 'تورکیا',
 			'TT' => 'ترینیداد و تۆباگو',
 			'TV' => 'تووڤالوو',
 			'TW' => 'تایوان',
 			'TZ' => 'تانزانیا',
 			'UA' => 'ئۆکرانیا',
 			'UG' => 'ئوگاندا',
 			'UM' => 'دوورگەکانی دەرەوەی ئەمریکا',
 			'UN' => 'نەتەوە یەکگرتووەکان',
 			'US' => 'ویلایەتە یەکگرتووەکان',
 			'US@alt=short' => 'ویلایەتە یەکگرتووەکان',
 			'UY' => 'ئوروگوای',
 			'UZ' => 'ئوزبەکستان',
 			'VA' => 'ڤاتیکان',
 			'VC' => 'سەینت ڤینسەنت و گرینادینز',
 			'VE' => 'ڤەنزوێلا',
 			'VG' => 'دوورگەکانی ڤیرجنی بەریتانیا',
 			'VI' => 'دوورگەکانی ڤیرجنی ئەمەریکا',
 			'VN' => 'ڤیەتنام',
 			'VU' => 'ڤانوواتوو',
 			'WF' => 'والیس و فوتونا',
 			'WS' => 'ساموا',
 			'XK' => 'کۆسۆڤۆ',
 			'YE' => 'یەمەن',
 			'YT' => 'مایۆت',
 			'ZA' => 'ئەفریقای باشوور',
 			'ZM' => 'زامبیا',
 			'ZW' => 'زیمبابوی',
 			'ZZ' => 'ناوچەی نەناسراو',

		}
	},
);

has 'display_name_key' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { 
		{
			'calendar' => 'ڕۆژژمێر',
 			'collation' => 'ڕیزبەندی',
 			'currency' => 'دراو',
 			'numbers' => 'ژمارەکان',

		}
	},
);

has 'display_name_type' => (
	is			=> 'ro',
	isa			=> HashRef[HashRef[Str]],
	init_arg	=> undef,
	default		=> sub {
		{
			'calendar' => {
 				'chinese' => q{ڕۆژژمێری چینی},
 				'gregorian' => q{ڕۆژژمێری گورجی},
 				'hebrew' => q{ڕۆژژمێری عیبری},
 				'indian' => q{ڕۆژژمێری نەتەوەیی ھیندی},
 				'islamic' => q{ڕۆژژمێری کۆچیی مانگی},
 				'persian' => q{ڕۆژژمێری کۆچیی ھەتاوی},
 			},
 			'numbers' => {
 				'arab' => q{ژمارە عەربی-ھیندییەکان},
 				'gujr' => q{ژمارە گوجەراتییەکان},
 				'khmr' => q{ژمارە خمێرییەکان},
 				'latn' => q{ژمارە ڕۆژاوایییەکان},
 				'mymr' => q{ژمارە میانمارییەکان},
 			},

		}
	},
);

has 'display_name_measurement_system' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { 
		{
			'metric' => q{مەتریک},
 			'UK' => q{بریتانی},
 			'US' => q{ئەمەریکی},

		}
	},
);

has 'display_name_code_patterns' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { 
		{
			'language' => 'زمان: {0}',
 			'script' => 'خەت: {0}',
 			'region' => 'ناوچە: {0}',

		}
	},
);

has 'text_orientation' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { return {
			lines => '',
			characters => 'right-to-left',
		}}
);

has 'characters' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> $^V ge v5.18.0
	? eval <<'EOT'
	sub {
		no warnings 'experimental::regex_sets';
		return {
			auxiliary => qr{[‎‏ ً ٌ ٍ َ ُ ِ ّ ْ ء آ أ ؤ إ ة ث ذ ص ض ط ظ ك ه ى ي]},
			index => ['ئ', 'ا', 'ب', 'پ', 'ت', 'ج', 'چ', 'ح', 'خ', 'د', 'ر', 'ز', 'ڕ', 'ژ', 'س', 'ش', 'ع', 'غ', 'ف', 'ڤ', 'ق', 'ک', 'گ', 'ل', 'ڵ', 'م', 'ن', 'ھ', 'ە', 'و', 'ۆ', 'ی', 'ێ'],
			main => qr{[ئ ا ب پ ت ج چ ح خ د ر ز ڕ ژ س ش ع غ ف ڤ ق ک گ ل ڵ م ن ھ ە و ۆ ی ێ]},
			numbers => qr{[‎‏ \- , ٫ ٬ . % ٪ ‰ ؉ + 0٠ 1١ 2٢ 3٣ 4٤ 5٥ 6٦ 7٧ 8٨ 9٩]},
		};
	},
EOT
: sub {
		return { index => ['ئ', 'ا', 'ب', 'پ', 'ت', 'ج', 'چ', 'ح', 'خ', 'د', 'ر', 'ز', 'ڕ', 'ژ', 'س', 'ش', 'ع', 'غ', 'ف', 'ڤ', 'ق', 'ک', 'گ', 'ل', 'ڵ', 'م', 'ن', 'ھ', 'ە', 'و', 'ۆ', 'ی', 'ێ'], };
},
);


has 'default_numbering_system' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> 'arab',
);

has native_numbering_system => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> 'arab',
);

has 'minimum_grouping_digits' => (
	is			=>'ro',
	isa			=> Int,
	init_arg	=> undef,
	default		=> 1,
);

has 'number_symbols' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'arab' => {
			'decimal' => q(٫),
			'exponential' => q(اس),
			'group' => q(٬),
			'infinity' => q(∞),
			'minusSign' => q(‏-),
			'nan' => q(NaN),
			'perMille' => q(؉),
			'percentSign' => q(٪),
			'plusSign' => q(‏+),
			'superscriptingExponent' => q(×),
		},
		'latn' => {
			'decimal' => q(.),
			'exponential' => q(E),
			'group' => q(,),
			'infinity' => q(∞),
			'minusSign' => q(-),
			'nan' => q(NaN),
			'perMille' => q(‰),
			'percentSign' => q(%),
			'plusSign' => q(‎+),
			'superscriptingExponent' => q(×),
		},
	} }
);

has 'number_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		decimalFormat => {
			'default' => {
				'standard' => {
					'default' => '#,##0.###',
				},
			},
		},
		percentFormat => {
			'default' => {
				'standard' => {
					'default' => '#,##0%',
				},
			},
		},
		scientificFormat => {
			'default' => {
				'standard' => {
					'default' => '#E0',
				},
			},
		},
} },
);

has 'number_currency_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'arab' => {
			'pattern' => {
				'default' => {
					'standard' => {
						'positive' => '#,##0.00 ¤',
					},
				},
			},
		},
		'latn' => {
			'pattern' => {
				'default' => {
					'accounting' => {
						'positive' => '¤ #,##0.00',
					},
					'standard' => {
						'positive' => '¤ #,##0.00',
					},
				},
			},
		},
} },
);

has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'AFN' => {
			display_name => {
				'currency' => q(ئەفغانیی ئەفغانستان),
			},
		},
		'BHD' => {
			display_name => {
				'currency' => q(دیناری بەحرەینی),
			},
		},
		'BZD' => {
			display_name => {
				'currency' => q(دۆلاری بەلیزی),
			},
		},
		'DZD' => {
			display_name => {
				'currency' => q(دیناری جەزائیری),
			},
		},
		'EUR' => {
			display_name => {
				'currency' => q(یورۆ),
			},
		},
		'IQD' => {
			symbol => 'د.ع.‏',
			display_name => {
				'currency' => q(دیناری عێراقی),
			},
		},
		'IRR' => {
			display_name => {
				'currency' => q(ڕیاڵی ئێرانی),
			},
		},
		'JOD' => {
			display_name => {
				'currency' => q(دیناری ئوردنی),
			},
		},
		'KWD' => {
			display_name => {
				'currency' => q(دیناری کووەیتی),
			},
		},
		'OMR' => {
			display_name => {
				'currency' => q(ڕیاڵی عومانی),
			},
		},
		'QAR' => {
			display_name => {
				'currency' => q(ڕیاڵی قەتەری),
			},
		},
		'SAR' => {
			display_name => {
				'currency' => q(ڕیاڵی سەعوودی),
			},
		},
		'TND' => {
			display_name => {
				'currency' => q(دیناری توونس),
			},
		},
		'TRY' => {
			display_name => {
				'currency' => q(لیرەی تورکیا),
			},
		},
		'TTD' => {
			display_name => {
				'currency' => q(دۆلاری ترینیداد و تۆباگۆ),
			},
		},
		'XAU' => {
			display_name => {
				'currency' => q(زێڕ),
			},
		},
	} },
);


has 'calendar_months' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'gregorian' => {
				'format' => {
					abbreviated => {
						nonleap => [
							'کانوونی دووەم',
							'شوبات',
							'ئازار',
							'نیسان',
							'ئایار',
							'حوزەیران',
							'تەمووز',
							'ئاب',
							'ئەیلوول',
							'تشرینی یەکەم',
							'تشرینی دووەم',
							'کانونی یەکەم'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'ک',
							'ش',
							'ئ',
							'ن',
							'ئ',
							'ح',
							'ت',
							'ئ',
							'ئ',
							'ت',
							'ت',
							'ک'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'کانوونی دووەم',
							'شوبات',
							'ئازار',
							'نیسان',
							'ئایار',
							'حوزەیران',
							'تەمووز',
							'ئاب',
							'ئەیلوول',
							'تشرینی یەکەم',
							'تشرینی دووەم',
							'کانونی یەکەم'
						],
						leap => [
							
						],
					},
				},
				'stand-alone' => {
					abbreviated => {
						nonleap => [
							'کانوونی دووەم',
							'شوبات',
							'ئازار',
							'نیسان',
							'ئایار',
							'حوزەیران',
							'تەمووز',
							'ئاب',
							'ئەیلوول',
							'تشرینی یەکەم',
							'تشرینی دووەم',
							'کانونی یەکەم'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'ک',
							'ش',
							'ئ',
							'ن',
							'ئ',
							'ح',
							'ت',
							'ئ',
							'ئ',
							'ت',
							'ت',
							'ک'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'کانوونی دووەم',
							'شوبات',
							'ئازار',
							'نیسان',
							'ئایار',
							'حوزەیران',
							'تەمووز',
							'ئاب',
							'ئەیلوول',
							'تشرینی یەکەم',
							'تشرینی دووەم',
							'کانونی یەکەم'
						],
						leap => [
							
						],
					},
				},
			},
			'persian' => {
				'format' => {
					abbreviated => {
						nonleap => [
							'خاکەلێوە',
							'بانەمەڕ',
							'جۆزەردان',
							'پووشپەڕ',
							'گەلاوێژ',
							'خەرمانان',
							'ڕەزبەر',
							'خەزەڵوەر',
							'سەرماوەز',
							'بەفرانبار',
							'ڕێبەندان',
							'رەشەمێ'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'خاکەلێوە',
							'بانەمەڕ',
							'جۆزەردان',
							'پووشپەڕ',
							'گەلاوێژ',
							'خەرمانان',
							'ڕەزبەر',
							'خەزەڵوەر',
							'سەرماوەز',
							'بەفرانبار',
							'ڕێبەندان',
							'رەشەمێ'
						],
						leap => [
							
						],
					},
				},
				'stand-alone' => {
					abbreviated => {
						nonleap => [
							'خاکەلێوە',
							'بانەمەڕ',
							'جۆزەردان',
							'پووشپەڕ',
							'گەلاوێژ',
							'خەرمانان',
							'ڕەزبەر',
							'خەزەڵوەر',
							'سەرماوەز',
							'بەفرانبار',
							'ڕێبەندان',
							'رەشەمێ'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'خاکەلێوە',
							'بانەمەڕ',
							'جۆزەردان',
							'پووشپەڕ',
							'گەلاوێژ',
							'خەرمانان',
							'ڕەزبەر',
							'خەزەڵوەر',
							'سەرماوەز',
							'بەفرانبار',
							'ڕێبەندان',
							'رەشەمێ'
						],
						leap => [
							
						],
					},
				},
			},
	} },
);

has 'calendar_days' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'generic' => {
				'format' => {
					abbreviated => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
					narrow => {
						mon => 'د',
						tue => 'س',
						wed => 'چ',
						thu => 'پ',
						fri => 'ھ',
						sat => 'ش',
						sun => 'ی'
					},
					wide => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
				},
				'stand-alone' => {
					abbreviated => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
					narrow => {
						mon => 'د',
						tue => 'س',
						wed => 'چ',
						thu => 'پ',
						fri => 'ھ',
						sat => 'ش',
						sun => 'ی'
					},
					wide => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
				},
			},
			'gregorian' => {
				'format' => {
					abbreviated => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
					narrow => {
						mon => 'د',
						tue => 'س',
						wed => 'چ',
						thu => 'پ',
						fri => 'ھ',
						sat => 'ش',
						sun => 'ی'
					},
					short => {
						mon => '٢ش',
						tue => '٣ش',
						wed => '٤ش',
						thu => '٥ش',
						fri => 'ھ',
						sat => 'ش',
						sun => '١ش'
					},
					wide => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
				},
				'stand-alone' => {
					abbreviated => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
					narrow => {
						mon => 'د',
						tue => 'س',
						wed => 'چ',
						thu => 'پ',
						fri => 'ھ',
						sat => 'ش',
						sun => 'ی'
					},
					short => {
						mon => '٢ش',
						tue => '٣ش',
						wed => '٤ش',
						thu => '٥ش',
						fri => 'ھ',
						sat => 'ش',
						sun => '١ش'
					},
					wide => {
						mon => 'دووشەممە',
						tue => 'سێشەممە',
						wed => 'چوارشەممە',
						thu => 'پێنجشەممە',
						fri => 'ھەینی',
						sat => 'شەممە',
						sun => 'یەکشەممە'
					},
				},
			},
	} },
);

has 'calendar_quarters' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'generic' => {
				'format' => {
					wide => {0 => 'چارەکی یەکەم',
						1 => 'چارەکی دووەم',
						2 => 'چارەکی سێەم',
						3 => 'چارەکی چوارەم'
					},
				},
				'stand-alone' => {
					wide => {0 => 'چارەکی یەکەم',
						1 => 'چارەکی دووەم',
						2 => 'چارەکی سێەم',
						3 => 'چارەکی چوارەم'
					},
				},
			},
			'gregorian' => {
				'format' => {
					abbreviated => {0 => 'چ١',
						1 => 'چ٢',
						2 => 'چ٣',
						3 => 'چ٤'
					},
					narrow => {0 => '١',
						1 => '٢',
						2 => '٣',
						3 => '٤'
					},
					wide => {0 => 'چارەکی یەکەم',
						1 => 'چارەکی دووەم',
						2 => 'چارەکی سێەم',
						3 => 'چارەکی چوارەم'
					},
				},
				'stand-alone' => {
					abbreviated => {0 => 'چ١',
						1 => 'چ٢',
						2 => 'چ٣',
						3 => 'چ٤'
					},
					narrow => {0 => '١',
						1 => '٢',
						2 => '٣',
						3 => '٤'
					},
					wide => {0 => 'چارەکی یەکەم',
						1 => 'چارەکی دووەم',
						2 => 'چارەکی سێەم',
						3 => 'چارەکی چوارەم'
					},
				},
			},
	} },
);

has 'day_periods' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			'format' => {
				'abbreviated' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
				'wide' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
			},
		},
		'gregorian' => {
			'format' => {
				'abbreviated' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
				'narrow' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
				'wide' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
			},
			'stand-alone' => {
				'abbreviated' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
				'narrow' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
				'wide' => {
					'am' => q{ب.ن},
					'pm' => q{د.ن},
				},
			},
		},
	} },
);

has 'eras' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
		},
		'gregorian' => {
			abbreviated => {
				'0' => 'پێش زایین',
				'1' => 'زایینی'
			},
			narrow => {
				'0' => 'پ.ن',
				'1' => 'ز'
			},
			wide => {
				'0' => 'پێش زایین',
				'1' => 'زایینی'
			},
		},
		'persian' => {
		},
	} },
);

has 'date_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			'full' => q{G y MMMM d, EEEE},
			'long' => q{dی MMMMی y G},
			'medium' => q{G y MMM d},
			'short' => q{GGGGG y-MM-dd},
		},
		'gregorian' => {
			'full' => q{y MMMM d, EEEE},
			'long' => q{dی MMMMی y},
			'medium' => q{y MMM d},
			'short' => q{y-MM-dd},
		},
		'persian' => {
		},
	} },
);

has 'time_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
		},
		'gregorian' => {
			'full' => q{h:mm:ss a zzzz},
			'long' => q{h:mm:ss a z},
			'medium' => q{h:mm:ss a},
			'short' => q{h:mm a},
		},
		'persian' => {
		},
	} },
);

has 'datetime_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			'full' => q{{1} {0}},
			'long' => q{{1} {0}},
			'medium' => q{{1} {0}},
			'short' => q{{1} {0}},
		},
		'gregorian' => {
			'full' => q{{1} {0}},
			'long' => q{{1} {0}},
			'medium' => q{{1} {0}},
			'short' => q{{1} {0}},
		},
		'persian' => {
		},
	} },
);

has 'datetime_formats_available_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			E => q{ccc},
			Ed => q{E dھەم},
			Gy => q{G y},
			GyMMM => q{G y MMM},
			GyMMMEd => q{G y MMM d, E},
			GyMMMd => q{G y MMM d},
			M => q{L},
			MEd => q{E، M/d},
			MMM => q{LLL},
			MMMEd => q{E، dی MMM},
			MMMMd => q{MMMM d},
			MMMd => q{dی MMM},
			Md => q{MM-dd},
			d => q{d},
			h => q{hی a},
			y => q{G y},
			yM => q{M/y},
			yMEd => q{E، d/M/y},
			yMMM => q{MMMی y},
			yMMMEd => q{E، dی MMMی y},
			yMMMd => q{dی MMMی y},
			yMd => q{d/M/y},
			yyyy => q{G y},
			yyyyM => q{GGGGG y-MM},
			yyyyMEd => q{GGGGG y-MM-dd, E},
			yyyyMMM => q{G y MMM},
			yyyyMMMEd => q{G y MMM d, E},
			yyyyMMMM => q{G y MMMM},
			yyyyMMMd => q{G y MMM d},
			yyyyMd => q{GGGGG y-MM-dd},
			yyyyQQQ => q{G y QQQ},
			yyyyQQQQ => q{G y QQQQ},
		},
		'gregorian' => {
			E => q{ccc},
			EHm => q{E HH:mm},
			EHms => q{E HH:mm:ss},
			Ed => q{E dھەم},
			Ehm => q{E h:mm a},
			Ehms => q{E h:mm:ss a},
			Gy => q{G y},
			GyMMM => q{G y MMM},
			GyMMMEd => q{G y MMM d, E},
			GyMMMd => q{G y MMM d},
			H => q{HH},
			Hm => q{HH:mm},
			Hms => q{HH:mm:ss},
			Hmsv => q{HH:mm:ss v},
			Hmv => q{HH:mm v},
			M => q{L},
			MEd => q{E، M/d},
			MMM => q{LLL},
			MMMEd => q{E، dی MMM},
			MMMMW => q{هەفتەی W ی MMM},
			MMMMd => q{MMMM d},
			MMMd => q{dی MMM},
			Md => q{MM-dd},
			d => q{d},
			h => q{hی a},
			hm => q{h:mm a},
			hms => q{h:mm:ss a},
			hmsv => q{h:mm:ss a v},
			hmv => q{h:mm a v},
			ms => q{mm:ss},
			y => q{y},
			yM => q{M/y},
			yMEd => q{E، d/M/y},
			yMMM => q{MMMی y},
			yMMMEd => q{E، dی MMMی y},
			yMMMM => q{y MMMM},
			yMMMd => q{dی MMMی y},
			yMd => q{d/M/y},
			yQQQ => q{y QQQ},
			yQQQQ => q{y QQQQ},
			yw => q{هەفتەی w ی Y},
		},
	} },
);

has 'datetime_formats_append_item' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
			'Timezone' => '{0} {1}',
		},
	} },
);

has 'datetime_formats_interval' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			M => {
				M => q{MM–MM},
			},
			MEd => {
				M => q{E، M/d – E، M/d},
				d => q{E، M/d – E، M/d},
			},
			MMM => {
				M => q{MMM–MMM},
			},
			MMMEd => {
				M => q{MMM d, E – MMM d, E},
				d => q{E، dی MMM – E، dی MMM},
			},
			MMMd => {
				M => q{MMM d – MMM d},
				d => q{d–dی MMM},
			},
			Md => {
				M => q{MM-dd – MM-dd},
				d => q{MM-dd – MM-dd},
			},
			d => {
				d => q{d–d},
			},
			fallback => '{0} – {1}',
			y => {
				y => q{G y–y},
			},
			yM => {
				M => q{GGGGG y-MM – y-MM},
				y => q{GGGGG y-MM – y-MM},
			},
			yMEd => {
				M => q{E، d/M/y – E، d/M/y},
				d => q{E، d/M/y – E، d/M/y},
				y => q{E، d/M/y – E، d/M/y},
			},
			yMMM => {
				M => q{MMM–MMMی y},
				y => q{MMMی y – MMMی y},
			},
			yMMMEd => {
				M => q{G y MMM d, E – MMM d, E},
				d => q{G y MMM d, E – MMM d, E},
				y => q{G y MMM d, E – y MMM d, E},
			},
			yMMMM => {
				M => q{G y MMMM–MMMM},
				y => q{G y MMMM – y MMMM},
			},
			yMMMd => {
				M => q{dی MMM – dی MMMی y},
				d => q{d–dی MMMی y},
				y => q{dی MMMMی y – dی MMMMی y},
			},
			yMd => {
				M => q{GGGGG y-MM-dd – y-MM-dd},
				d => q{GGGGG y-MM-dd – y-MM-dd},
				y => q{d/M/y – d/M/y},
			},
		},
		'gregorian' => {
			MEd => {
				M => q{E، M/d – E، M/d},
				d => q{E، M/d – E، M/d},
			},
			MMM => {
				M => q{MMM–MMM},
			},
			MMMEd => {
				d => q{E، dی MMM – E، dی MMM},
			},
			MMMd => {
				d => q{d–dی MMM},
			},
			yMEd => {
				M => q{E، d/M/y – E، d/M/y},
				d => q{E، d/M/y – E، d/M/y},
				y => q{E، d/M/y – E، d/M/y},
			},
			yMMM => {
				M => q{MMM–MMMی y},
				y => q{MMMی y – MMMی y},
			},
			yMMMd => {
				M => q{dی MMM – dی MMMی y},
				d => q{d–dی MMMی y},
				y => q{dی MMMMی y – dی MMMMی y},
			},
			yMd => {
				y => q{d/M/y – d/M/y},
			},
		},
	} },
);

no Moo;

1;

# vim: tabstop=4
