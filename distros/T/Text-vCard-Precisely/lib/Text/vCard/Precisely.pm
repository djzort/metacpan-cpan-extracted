package Text::vCard::Precisely;

our $VERSION = '0.28';

use Moose;
use Moose::Util::TypeConstraints;

extends 'Text::vCard::Precisely::V3';

enum 'Version' => [qw( 3.0 4.0 )];
has version    => ( is => 'ro', isa => 'Version', default => '3.0', required => 1 );

sub BUILD {
    my $self = shift;
    return Text::vCard::Precisely::V3->new(@_) unless $self->version() eq '4.0';

    require Text::vCard::Precisely::V4;
    our @ISA = 'Text::vCard::Precisely::V4';
    return Text::vCard::Precisely::V4->new(@_);
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=encoding UTF8

=head1 NAME

Text::vCard::Precisely - Read, Write and Edit the vCards 3.0 and/or 4.0 precisely

=head1 SYNOPSIS
 
 use Text::vCard::Precisely;
 my $vc = Text::vCard::Precisely->new();
 # Or now you can write like below if you want to use 4.0:
 my $vc4 = Text::vCard::Precisely->new( version => '4.0' );
 #or $vc4 = Text::vCard::Precisely::V4->new(); # it's same

 $vc->n([ 'Gump', 'Forrest', , 'Mr', '' ]);
 $vc->fn( 'Forrest Gump' );

 use GD;
 use MIME::Base64;
 my $gd = GD::Image->new( 100, 100 );
 my $black = $gd->colorAllocate( 0, 0, 0 );
 $gd->rectangle( 0, 0, 99, 99, $black );

 my $img = $gd->png();
 my $base64 = MIME::Base64::encode($img);

 $vc->photo([
    { content => 'https://avatars2.githubusercontent.com/u/2944869?v=3&s=400',  media_type => 'image/jpeg' },
    { content => $img, media_type => 'image/png' }, # Now you can set a binary image directly
    { content => $base64, media_type => 'image/png' }, # Also accept the text encoded in Base64
 ]);

 $vc->org('Bubba Gump Shrimp Co.'); # Now you can set/get org!

 $vc->tel({ content => '+1-111-555-1212', types => ['work'], pref => 1 });

 $vc->email({ content => 'forrestgump@example.com', types => ['work'] });

 $vc->adr( {
    types => ['work'],
    pobox     => '109',
    extended  => 'Shrimp Bld.',
    street    => 'Waters Edge',
    city      => 'Baytown',
    region    => 'LA',
    post_code => '30314',
    country   => 'United States of America',
 });

 $vc->url({ content => 'https://twitter.com/worthmine', types => ['twitter'] }); # for URL param

 print $vc->as_string();

=head1 DESCRIPTION

A vCard is a digital business card.
vCard and L<Text::vFile::asData> provides an API for parsing vCards

This module is forked from L<Text::vCard>
because some reason below:

=over

=item

Text::vCard B<doesn't provide> full methods based on L<RFC2426|https://tools.ietf.org/html/rfc2426>

=item

Mac OS X and iOS can't parse vCard4.0 with UTF-8 precisely. they cause some Mojibake

=item

Android 4.4.x can't parse vCard4.0

=back

To handle an address book with several vCard entries in it, start with
L<Text::vFile::asData> and then come back to this module.

Note that the vCard RFC requires C<VERSION> and C<FN>.  This module does not check or warn yet if these conditions have not been met

=head1 Constructors

=head2 load_hashref($HashRef)

Accepts a HashRef that looks like below:

 my $hashref = {
    N   => [ 'Gump', 'Forrest', '', 'Mr.', '' ],
    FN  => 'Forrest Gump',
    SORT_STRING => 'Forrest Gump',
    ORG => 'Bubba Gump Shrimp Co.',
    TITLE => 'Shrimp Man',
    PHOTO => { media_type => 'image/gif', content => 'http://www.example.com/dir_photos/my_photo.gif' },
    TEL => [
        { types => ['WORK','VOICE'], content => '(111) 555-1212' },
        { types => ['HOME','VOICE'], content => '(404) 555-1212' },
    ],
    ADR =>[{
        types       => ['work'],
        pref        => 1,
        extended    => 100,
        street      => 'Waters Edge',
        city        => 'Baytown',
        region      => 'LA',
        post_code   => '30314',
        country     => 'United States of America'
    },{
        types       => ['home'],
        extended    => 42,
        street      => 'Plantation St.',
        city        => 'Baytown',
        region      => 'LA',
        post_code   => '30314',
        country     => 'United States of America'
    }],
    URL => 'http://www.example.com/dir_photos/my_photo.gif',
    EMAIL => 'forrestgump@example.com',
    REV => '2008-04-24T19:52:43Z',
 };

=head2 load_file($file_name)

Accepts a file name

=head2 load_string($vCard)

Accepts a vCard string

=head1 METHODS

=head2 as_string()

Returns the vCard as a string.
You have to use C<Encode::encode_utf8()> if your vCard is written in utf8

=head2 as_file($filename)

Write data in vCard format to $filename.
Dies if not successful

=head1 SIMPLE GETTERS/SETTERS

These methods accept and return strings

=head2 version()

returns Version number of the vcard.
Defaults to B<'3.0'> and this method is B<READONLY>

=head2 rev()

To specify revision information about the current vCard

=head2 sort_string()

To specify the family name, given name or organization text to be used for
national-language-specific sorting of the C<FN>, C<N> and C<ORG>.

B<This method is DEPRECATED in vCard4.0> Use C<SORT-AS> param instead of it.

=head1 COMPLEX GETTERS/SETTERS

They are based on Moose with coercion.
So these methods accept not only ArrayRef[HashRef] but also ArrayRef[Str],
single HashRef or single Str.

Read source if you were confused

=head2 n()

To specify the components of the name of the object the vCard represents

=head2 tel()

Accepts/returns an ArrayRef that looks like:

 [
    { type => ['work'], content => '651-290-1234', preferred => 1 },
    { type => ['home'], content => '651-290-1111' },
 ]

After version 0.18, B<content will not be validated as phone numbers> 
All I<Str> type is accepted.

So you have to validate phone numbers with your way.

=head2 adr(), address()

Accepts/returns an ArrayRef that looks like:

 [
    { types => ['work'], street => 'Main St', pref => 1 },
    {   types     => ['home'],
        pobox     => 1234,
        extended  => 'asdf',
        street    => 'Army St',
        city      => 'Desert Base',
        region    => '',
        post_code => '',
        country   => 'USA',
        pref      => 2,
    },
 ]

=head2 email()

Accepts/returns an ArrayRef that looks like:

 [
    { type => ['work'], content => 'bbanner@ssh.secret.army.mil' },
    { type => ['home'], content => 'bbanner@timewarner.com', pref => 1 },
 ]

or accept the string as email like below

 'bbanner@timewarner.com'

=head2 url()

Accepts/returns an ArrayRef that looks like:

 [
    { content => 'https://twitter.com/worthmine', types => ['twitter'] },
    { content => 'https://github.com/worthmine' },
 ]

or accept the string as URL like below

 'https://github.com/worthmine'

=head2 photo(), logo()

Accepts/returns an ArrayRef of URLs or Images: 
Even if they are raw image binary or text encoded in Base64, it does not matter

B<Attention!> Mac OS X and iOS B<ignore> the description beeing URL

use Base64 encoding or raw image binary if you have to show the image you want

=head2 note()

To specify supplemental information or a comment that is associated with the vCard

=head2 org(), title(), role(), categories()

To specify additional information for your jobs

In these, C<CATEGORIES> may have multiple content with being separated by COMMA.
multiple content is expressed by using ArrayRef like this:

 $vc->categories([qw(Internet Travel)]);

=head2 fn(), full_name(), fullname()

A person's entire name as they would like to see it displayed

=head2 nickname()

To specify the text corresponding to the nickname of the object the vCard represents

Like C<CATEGORIES>, It ALSO may have multiple content with being separated by COMMA.

 $vc->nickname([qw(Johny John)]);

=head2 geo()

To specify information related to the global positioning of the object the vCard represents

=head2 key()

To specify a public key or authentication certificate associated with the object that the vCard represents

=head2 label()

ToDo: because B<It's DEPRECATED in vCard4.0>

To specify the formatted text corresponding to delivery address of the object the vCard represents

=head2 uid()

To specify a value that represents a globally unique identifier corresponding to 
the individual or resource associated with the vCard

=head2 tz(), timezone()

Both are same method with Alias

To specify information related to the time zone of the object the vCard represents

utc-offset format is NOT RECOMMENDED from vCard4.0

C<TZ> can be a URL, but there is no document in
 L<RFC2426|https://tools.ietf.org/html/rfc2426>
or L<RFC6350|https://tools.ietf.org/html/rfc6350>

So it just supports some text values

=head2 bday(), birthday()

Both are same method with Alias

To specify the birth date of the object the vCard represents

=head2 prodid()

To specify the identifier for the product that created the vCard object

=head2 source()

To identify the source of directory information contained in the content type

=head2 sound()

To specify a digital sound content information that annotates some aspect of the vCard

This property is often used to specify the proper pronunciation of 
the name property value of the vCard

=head2 socialprofile()

There is no documents about C<X-SOCIALPROFILE> in RFC but it works in iOS and Mac OS X!

I don't know well about in Android or Windows. Somebody please feedback me

=head2 label()

B<It's DEPRECATED in vCard4.0> You can use this method Just ONLY in vCard3.0

=head1 For operating files with multiple vCards

See L<Text::vCard::Precisely::Multiple>

=head1 aroud UTF-8

If you want to send precisely the vCard with UTF-8 characters to the B<ALMOST>
of smartphones, Use 3.0

It seems to be TOO EARLY to use 4.0

=head1 for under perl-5.12.5

This module uses C<\P{ascii}> in regexp so You have to use 5.12.5 and later

=head1 SEE ALSO

=over

=item

L<RFC 2426|https://tools.ietf.org/html/rfc2426>

=item

L<RFC 2425|https://tools.ietf.org/html/rfc2425>

=item

L<RFC 6350|https://tools.ietf.org/html/rfc6350>

=item

L<Text::vCard::Precisely::Multiple>

=item

L<Text::vFile::asData>

=back

=head1 AUTHOR

Yuki Yoshida(L<worthmine|https://github.com/worthmine>)

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as Perl.
