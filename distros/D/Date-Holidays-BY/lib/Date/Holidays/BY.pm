package Date::Holidays::BY;
our $VERSION = '1.2023.1'; # VERSION

=encoding utf8

=head1 NAME

Date::Holidays::BY - Determine Belorussian official holidays and business days.

=head1 SYNOPSIS

    use Date::Holidays::BY qw( is_holiday holidays is_business_day );

    my ( $year, $month, $day ) = ( localtime )[ 5, 4, 3 ];
    $year  += 1900;
    $month += 1;

    if ( my $holidayname = is_holiday( $year, $month, $day ) ) {
        print "Today is a holiday: $holidayname\n";
    }

    my $ref = holidays( $year );
    while ( my ( $md, $name ) = each %$ref ) {
        print "On $md there is a holiday named $name\n";
    }

    if ( is_business_day( 2012, 03, 11 ) ) {
        print "2012-03-11 is business day on weekend\n";
    }

    if ( is_short_business_day( 2015, 04, 30 ) ) {
        print "2015-04-30 is short business day\n";
    }

    $Date::Holidays::BY::strict=1;
    # here we die because time outside from $HOLIDAYS_VALID_SINCE to $INACCURATE_TIMES_SINCE
    holidays( 9001 );

=cut

use warnings;
use strict;
use utf8;
use base 'Exporter';
use Carp;

our @EXPORT_OK = qw(
    is_holiday
    is_by_holiday
    holidays
    is_business_day
    is_short_business_day
);

=head2 $Date::Holidays::BY::HOLIDAYS_VALID_SINCE, $Date::Holidays::BY::INACCURATE_TIMES_SINCE

HOLIDAYS_VALID_SINCE before this year package doesn't matter
INACCURATE_TIMES_SINCE after this year dates of holidays and working day shift are not accurate, but you can most likely be sure of historical holidays

=cut

use List::Util;

our $HOLIDAYS_VALID_SINCE = 2013; # TODO add all old
our $INACCURATE_TIMES_SINCE = 2024;

=head2 $Date::Holidays::BY::strict

Allows you to return an error if the requested date is outside the determined times.
Default is 0.

=cut

our $strict = 0;

# internal date formatting alike ISO 8601: MMDD
my @REGULAR_HOLIDAYS = (
    {
        name => 'Новый год',
        days => {
          1992 => '0101',
          2020 => [ qw( 0101 0102 ) ],
        },
    },
    {
        name => 'Международный женский день',
        days => '0308',
    },
    {
        name => 'Праздник труда',
        days => '0501',
    },
    {
        name => 'День Победы',
        days => '0509',
    },
    {
        name => 'День Независимости Республики Беларусь',
        days => '0703',
    },
    {
        name => 'День Октябрьской революции',
        days => '1107',
    },
    {
        name => 'Рождество Христово (православное Рождество)',
        days => '0107',
    },
    {
        name => 'Рождество Христово (католическое Рождество)',
        days => '1225',
    },
    {
        name => 'Радоница',
        days => \&_radonitsa_mmdd,
    },
);

my %HOLIDAYS_SPECIAL = (
    2013 => [ qw( 0102 0510 ) ],
    2014 => [ qw( 0102 0106 0430 0704 1226 ) ],
    2015 => [ qw( 0102 0420 ) ],
    2016 => [ qw( 0108 0307 ) ],
    2017 => [ qw( 0102 0424 0425 0508 1106 ) ],
    2018 => [ qw( 0102 0309 0416 0417 0430 0702 1224 1231 ) ],
    2019 => [ qw( 0506 0507 0508 1108 ) ],
    2020 => [ qw( 0106 0427 0428 ) ],
    2021 => [ qw( 0108 0510 0511 ) ],
    2022 => [ qw( 0307 0502 ) ],
    2023 => [ qw( 0424 0508 1106 ) ],
);

my %BUSINESS_DAYS_ON_WEEKENDS = (
    2013 => [ qw( 0105 0518 ) ],
    2014 => [ qw( 0104 0111 0503 0712 1220 ) ],
    2015 => [ qw( 0110 0425 ) ],
    2016 => [ qw( 0116 0305 ) ],
    2017 => [ qw( 0121 0429 0506 1104 ) ],
    2018 => [ qw( 0120 0303 0414 0428 0707 1222 1229 ) ],
    2019 => [ qw( 0504 0511 1116 ) ],
    2020 => [ qw( 0104 0404 ) ],
    2021 => [ qw( 0116 0515 ) ],
    2022 => [ qw( 0312 0514 ) ],
    2023 => [ qw( 0429 0513 1111 ) ],
);

my %SHORT_BUSINESS_DAYS = (
    2014 => [ qw( 0428 0508 0702 1106  1224 1231 ) ],
    2015 => [ qw( 0106 0430 0508 0702 1106  1224 ) ],
    2016 => [ qw( 0106 ) ],
    2017 => [ qw( 0106 0307 0429 0506 1104 ) ],
    2018 => [ qw( 0307 0508 1106 ) ],
    2019 => [ qw( 0307 0430 0506 0702 1106 1224 ) ],
    2020 => [ qw( ) ],
    2021 => [ qw( ) ],
    2022 => [ qw( ) ],
    2023 => [ qw( ) ],
);



sub _radonitsa_mmdd {
    my $year=$_[0];
    if ($year < 1583 || $year > 7666) {croak "Module has limitation in counting Easter outside the period 1583-7666";}
    require Date::Easter;
    my ($easter_month, $easter_day) = Date::Easter::orthodox_easter($year);
    my $radonitsa_month = $easter_month;
    my $radonitsa_day = $easter_day + 9;
    if ( $radonitsa_day > 30 ) {
        $radonitsa_month++;
        $radonitsa_day -= 30;
    }
return _get_date_key($radonitsa_month, $radonitsa_day);
}

=head2 is_holiday( $year, $month, $day )

Determine whether this date is a BY holiday. Returns holiday name or undef.

=cut

sub is_holiday {
    my ( $year, $month, $day ) = @_;
    croak 'Bad params'  unless $year && $month && $day;

    return holidays( $year )->{ _get_date_key($month, $day) };
}

=head2 is_by_holiday( $year, $month, $day )

Alias for is_holiday().

=cut

sub is_by_holiday {
    goto &is_holiday;
}

=head2 holidays( $year )

Returns hash ref of all BY holidays in the year.

=cut

my %cache;
sub holidays {
    my $year = shift or croak 'Bad year';

    return $cache{ $year }  if $cache{ $year };

    my $holidays = _get_regular_holidays_by_year($year);

    if ( my $spec = $HOLIDAYS_SPECIAL{ $year } ) {
        $holidays->{ $_ } = 'Перенос праздничного дня'  for @$spec;
    }

    return $cache{ $year } = $holidays;
}

sub _get_regular_holidays_by_year {
    my ($year) = @_;
    croak "BY holidays is not valid before $HOLIDAYS_VALID_SINCE"  if $year < $HOLIDAYS_VALID_SINCE;
    if ($strict) {
		croak "BY holidays is not valid after @{[ $INACCURATE_TIMES_SINCE - 1 ]}"  if $year >= $INACCURATE_TIMES_SINCE;
    }

    my %day;
    for my $holiday (@REGULAR_HOLIDAYS) {
        my $days = _resolve_yhash_value($holiday->{days}, $year);
        next  if !$days;
        $days = [$days]  if !ref $days;
        next  if !@$days;

        my $name = _resolve_yhash_value($holiday->{name}, $year);
        croak "Name is not defined"  if !$name; # assertion

        $day{$_} = $name  for @$days;
    }

    return \%day;
}

sub _resolve_yhash_value {
    my ($value, $year) = @_;
    return $value->($year)  if ref $value eq 'CODE';
    return $value  if ref $value ne 'HASH';

    my $ykey = List::Util::first {$year >= $_} reverse sort keys %$value;
    return  if !$ykey;
    return $value->{$ykey}->($year)  if ref $value->{$ykey} eq 'CODE';
    return $value->{$ykey};
}


=head2 is_business_day( $year, $month, $day )

Returns true if date is a business day in BY taking holidays and weekends into account.

=cut

sub is_business_day {
    my ( $year, $month, $day ) = @_;

    croak 'Bad params'  unless $year && $month && $day;

    return 0  if is_holiday( $year, $month, $day );

    # check if date is a weekend
    require Time::Piece;
    my $t = Time::Piece->strptime( "$year-$month-$day", '%Y-%m-%d' );
    my $wday = $t->day;
    return 1  unless $wday eq 'Sat' || $wday eq 'Sun';

    # check if date is a business day on weekend
    my $ref = $BUSINESS_DAYS_ON_WEEKENDS{ $year } or return 0;

    my $md = _get_date_key($month, $day);
    for ( @$ref ) {
        return 1  if $_ eq $md;
    }

    return 0;
}

=head2 is_short_business_day( $year, $month, $day )

Returns true if date is a shortened business day in BY.

=cut

sub is_short_business_day {
    my ( $year, $month, $day ) = @_;

    my $short_days_ref = $SHORT_BUSINESS_DAYS{ $year } or return 0;

    my $date_key = _get_date_key($month, $day);
    return !!grep { $_ eq $date_key } @$short_days_ref;
}


sub _get_date_key {
    my ($month, $day) = @_;
    return sprintf '%02d%02d', $month, $day;
}

=head1 LICENSE

This software is copyright (c) 2023 by Vladimir Varlamov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

Terms of the Perl programming language system itself

a) the GNU General Public License as published by the Free
   Software Foundation; either version 1, or (at your option) any
   later version, or
b) the "Artistic License"

=cut


=head1 AUTHOR

Vladimir Varlamov, C<< <bes.internal@gmail.com> >>

=cut



1;
