=head1 NAME

StreamFinder::Tunein - Fetch actual raw streamable URLs from radio-station websites on Tunein.com

=head1 AUTHOR

This module is Copyright (C) 2021-2022 by

Jim Turner, C<< <turnerjw784 at yahoo.com> >>
		
Email: turnerjw784@yahoo.com

All rights reserved.

You may distribute this module under the terms of either the GNU General 
Public License or the Artistic License, as specified in the Perl README 
file.

=head1 SYNOPSIS

	#!/usr/bin/perl

	use strict;

	use StreamFinder::Tunein;

	die "..usage:  $0 ID|ID/ID|URL\n"  unless ($ARGV[0]);

	my $station = new StreamFinder::Tunein($ARGV[0]);

	die "Invalid URL or no streams found!\n"  unless ($station);

	my @streams = $station->get();

	my $url = $station->getURL();

	print "Stream URL=$url\n";

	my $stationTitle = $station->getTitle();
	
	print "Title=$stationTitle\n";
	
	my $stationDescription = $station->getTitle('desc');
	
	print "Description=$stationDescription\n";
	
	my $stationID = $station->getID();

	print "Station ID=$stationID\n";
	
	my $genre = $station->{'genre'};

	print "Genre=$genre\n"  if ($genre);
	
	my $artist = $station->{'artist'};

	print "Artist=$artist\n"  if ($artist);
	
	my $album = $video->{'album'};

	print "Album (podcast)=$album\n"  if ($album);
	
	my $albumartist = $video->{'albumartist'};

	print "Album Artist=$albumartist\n"  if ($albumartist);
	
	my $icon_url = $station->getIconURL();

	if ($icon_url) {   #SAVE THE ICON TO A TEMP. FILE:

		my ($image_ext, $icon_image) = $station->getIconData();

		if ($icon_image && open IMGOUT, ">/tmp/${stationID}.$image_ext") {

			binmode IMGOUT;

			print IMGOUT $icon_image;

			close IMGOUT;

		}

	}

	my $stream_count = $station->count();

	print "--Stream count=$stream_count=\n";

	my @streams = $station->get();

	foreach my $s (@streams) {

		print "------ stream URL=$s=\n";

	}

=head1 DESCRIPTION

StreamFinder::Tunein accepts a valid radio station or podcast ID or URL on 
Tunein.com and returns the actual stream URL(s), title, and cover art icon.  
The purpose is that one needs one of these URLs in order to have the option to 
stream the station in one's own choice of media player software rather than 
using their web browser and accepting any / all flash, ads, javascript, 
cookies, trackers, web-bugs, and other crapware that can come with that method 
of play.  The author uses his own custom all-purpose media player called 
"fauxdacious" (his custom hacked version of the open-source "audacious" 
audio player).  "fauxdacious" can incorporate this module to decode and play 
Tunein.com streams.  One or more streams can be returned for each station.  

Depends:  

L<URI::Escape>, L<HTML::Entities>, L<LWP::UserAgent>

=head1 SUBROUTINES/METHODS

=over 4

=item B<new>(I<ID>|I<ID/ID>|I<url> [, I<-notrim> [ => 0|1 ]]
[, I<-formats> => "type1,type2?..." | [type1,type2?...] ] 
[, I<-secure> [ => 0|1 ]] [, I<-debug> [ => 0|1|2 ]])

Accepts a tunein.com station / podcast ID or URL and creates and returns a new 
station object, or I<undef> if the URL is not a valid Tunein station or podcast, 
or no streams are found.  The URL can be the full URL, 
ie. https://tunein.com/radio/B<station-id>, 
https://tunein.com/podcasts/B<podcast-id>/?topicId=B<episode-id>, 
or just I<station-id> or I<podcast-id>/I<episode-id>.  NOTE:  For podcasts, 
you must also include the I<episode-id>, otherwise, the I<podcast-id> will be 
interpreted as a I<station-id> and you'll likely get no streams!

The optional I<-notrim> argument can be either 0 or 1 (I<false> or I<true>).  
If 0 (I<false>) then stream URLs are trimmed of excess "ad" parameters 
(everything after the first "?" character, ie. "?ads.cust_params=premium" is 
removed, including the "?".  Otherwise, the stream URLs are returned as-is.  

DEFAULT I<-notrim> (if not given) is 0 (I<false>) and URLs are trimmed.  If 
I<-notrim> is specified without argument, the default is 1 (I<true>).  Try 
using I<-notrim> if stream will not play without the extra arguments.

The optional I<-formats> argument can be either a comma-separated string or an 
array reference ([...]) of stream types to keep (include) and returned in 
order specified (type1, type2...).  Each "type" can be an extension 
(ie. mp3, acc, pls, etc.), or ("any" or "all" to keep all formats).

DEFAULT I<-formats> list is:  'all', meaning that all streams are accepted. 

NOTE:  I<-formats> only applies to streaming stations and is ignored for podcasts.

The optional I<-secure> argument can be either 0 or 1 (I<false> or I<true>).  
If 1 then only secure ("https://") streams will be returned.

DEFAULT I<-secure> is 0 (false) - return all streams (http and https).

WARNING!:  As of the latest StreamFinder release, almost ALL Tunein radio 
station streams are "insecure" (http)!

Additional options:

I<-log> => "I<logfile>"

Specify path to a log file.  If a valid and writable file is specified, A line 
will be appended to this file every time one or more streams is successfully 
fetched for a url.

DEFAULT I<-none-> (no logging).

I<-logfmt> specifies a format string for lines written to the log file.

DEFAULT "I<[time] [url] - [site]: [title] ([total])>".  

The valid field I<[variables]> are:  [stream]: The url of the first/best 
stream found.  [site]:  The site name (Tunein).  [url]:  The url searched 
for streams.  [time]: Perl timestamp when the line was logged.  [title], 
[artist], [album], [description], [year], [genre], [total], [albumartist]:  
The corresponding field data returned (or "I<-na->", if no value).

=item $station->B<get>()

Returns an array of strings representing all stream URLs found.

=item $station->B<getURL>([I<options>])

Similar to B<get>() except it only returns a single stream representing 
the first valid stream found.  

Current options are:  I<"random">, I<"nopls">, and I<"noplaylists">.  
By default, the first ("best"?) stream is returned.  If I<"random"> is 
specified, then a random one is selected from the list of streams found.  
If I<"nopls"> is specified, and the stream to be returned is a ".pls" playlist, 
it is first fetched and the first entry (or a random entry if I<"random"> is 
specified) is returned.  This is needed by Fauxdacious Mediaplayer.
If I<"noplaylists"> is specified, and the stream to be returned is a 
"playlist" (either .pls or .m3u? extension), it is first fetched and the first 
entry (or a random entry if I<"random"> is specified) in the playlist 
is returned.

=item $station->B<count>()

Returns the number of streams found for the station.

=item $station->B<getID>(['fccid'])

Returns the station's Tunein ID (default) or 
station's FCC call-letters ("fccid").

=item $station->B<getTitle>(['desc'])

Returns the station's title, or (long description).  

=item $station->B<getIconURL>()

Returns the URL for the station's "cover art" icon image, if any.

=item $station->B<getIconData>()

Returns a two-element array consisting of the extension (ie. "png", 
"gif", "jpeg", etc.) and the actual icon image (binary data), if any.

=item $station->B<getImageURL>()

Returns the URL for the station's "cover art" (usually larger) 
banner image, if any.

=item $station->B<getImageData>()

Returns a two-element array consisting of the extension (ie. "png", 
"gif", "jpeg", etc.) and the actual station's banner image (binary data).

=item $station->B<getType>()

Returns the station's type ("Tunein").

=back

=head1 CONFIGURATION FILES

The default root location directory for StreamFinder configuration files 
is "~/.config/StreamFinder".  To use an alternate location directory, 
specify it in the "I<STREAMFINDER>" environment variable, ie.:  
B<$ENV{STREAMFINDER} = "/etc/StreamFinder">.

=over 4

=item ~/.config/StreamFinder/Tunein/config

Optional text file for specifying various configuration options 
for a specific site (submodule).  Each option is specified on a 
separate line in the format below:
NOTE:  Do not follow the lines with a semicolon, comma, or any other 
separator.  Non-numeric I<values> should be surrounded with quotes, either 
single or double.  Blank lines and lines beginning with a "#" sign as 
their first non-blank character are ignored as comments.

'option' => 'value' [,]

and the options are loaded into a hash used only by the specific 
(submodule) specified.  Valid options include 
I<-debug> => [0|1|2] and most of the L<LWP::UserAgent> options.  

Options specified here override any specified in I<~/.config/StreamFinder/config>.

Among options valid for Tunein streams is the I<-notrim> described in the 
B<new()> function.  

=item ~/.config/StreamFinder/config

Optional text file for specifying various configuration options.  
Each option is specified on a separate line in the format below:

'option' => 'value' [,]

and the options are loaded into a hash used by all sites 
(submodules) that support them.  Valid options include 
I<-debug> => [0|1|2] and most of the L<LWP::UserAgent> options.

=back

NOTE:  Options specified in the options parameter list of the I<new()> 
function will override those corresponding options specified in these files.

=head1 KEYWORDS

tunein

=head1 DEPENDENCIES

L<URI::Escape>, L<HTML::Entities>, L<LWP::UserAgent>

=head1 RECCOMENDS

wget

=head1 BUGS

Please report any bugs or feature requests to C<bug-streamFinder-tunein at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=StreamFinder-Tunein>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc StreamFinder::Tunein

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=StreamFinder-Tunein>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/StreamFinder-Tunein>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/StreamFinder-Tunein>

=item * Search CPAN

L<http://search.cpan.org/dist/StreamFinder-Tunein/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2021-2022 Jim Turner.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

package StreamFinder::Tunein;

use strict;
use warnings;
use URI::Escape;
use HTML::Entities ();
use LWP::UserAgent ();
use parent 'StreamFinder::_Class';

my $DEBUG = 0;

sub new
{
	my $class = shift;
	my $url = shift;

	return undef  unless ($url);

	my $self = $class->SUPER::new('Tunein', @_);
	$DEBUG = $self->{'debug'}  if (defined $self->{'debug'});

	my $okStreams;
	$self->{'notrim'} = 0;
	while (@_) {
		if ($_[0] =~ /^\-?formats$/o) {
			shift;
			if (defined $_[0]) {
				my $keeporder = shift;
				$okStreams = (ref($keeporder) =~ /ARRAY/) ? join(',',@{$keeporder}) : $keeporder;
			}
		} elsif ($_[0] =~ /^\-?notrim$/o) {
			shift;
			$self->{'notrim'} = (defined $_[0]) ? shift : 1;
		} else {
			shift;
		}
	}
	$okStreams = 'all'  unless ($okStreams);

	my $html = '';
	print STDERR "-0(Tunein): URL=$url=\n"  if ($DEBUG);
	my $ua = LWP::UserAgent->new(@{$self->{'_userAgentOps'}});		
	$ua->timeout($self->{'timeout'});
	$ua->cookie_jar({});
	$ua->env_proxy;

	(my $url2fetch = $url);

	my $tried = 0;
TRYIT:
	#DEPRECIATED (STATION-IDS NOW INCLUDE STUFF BEFORE THE DASH: ($self->{'id'} = $url) =~ s#^.*\-([a-z]\d+)\/?$#$1#;
	if ($url2fetch =~ m#^https?\:#) {
		($self->{'id'} = $url) =~ s#^.*?\/([a-zA-Z0-9\-\_]+)(?:\/?|\/\?[^\/]+\/?)$#$1#;
	} else {
		my ($id, $podcastid) = split(m#\/#, $url2fetch);
		$self->{'id'} = $id;
		$url2fetch = ($podcastid ? 'https://tunein.com/podcasts/' : 'https://tunein.com/radio/'). $id;
		$url2fetch .= '/?topicId=' . $podcastid  if ($podcastid);
	}
	print STDERR "-1 (try=$tried) FETCHING URL=$url2fetch=\n"  if ($DEBUG);
	my $response = $ua->get($url2fetch);
	if ($response->is_success) {
		$html = $response->decoded_content;
	} else {
		print STDERR $response->status_line  if ($DEBUG);
		my $no_wget = system('wget','-V');
		unless ($no_wget) {
			print STDERR "\n..trying wget...\n"  if ($DEBUG);
			$html = `wget -t 2 -T 20 -O- -o /dev/null \"$url2fetch\" 2>/dev/null `;
		}
	}
	print STDERR "-1: html=$html=\n"  if ($DEBUG > 1);
	$html =~ s/\\\"/\&quot\;/gs;
	if ($html) {  #EXTRACT METADATA, IF WE CAN:
		print STDERR "-1: EXTRACTING METADATA...\n"  if ($DEBUG);
		$self->{'id'} = $1  if ($html =~ m#\"guideId\"\:\"([^\"]+)\"#);
		$self->{'fccid'} = ($html =~ m#\"callSign\"\:\"([^\"]+)\"#i) ? $1 : '';
		$self->{'title'} = ($html =~ m#\"twitter\:title\"\s+content\=\"([^\"]+)\"#) ? $1 : '';
		$self->{'album'} ||= ($html =~ m#\<h1\s+data\-testid\=\"profileTitle\"\s+title\=\"([^\"]+)\"#) ? $1 : '';
		if ($self->{'title'} !~ /\S/) {
			$self->{'title'} = $self->{'album'};
			$self->{'album'} = '';
		}
		$self->{'artist'} = ($html =~ m#\"profileSubtitle\"\>([^\<]+)#) ? $1 : '';
		if ($html =~ m#\<div\s+class\=\"pageTitles\_+description\_+[^\"]+\"\>(.+?)\<\/div\>#s) {
			$self->{'description'} = $1;
		}
		$self->{'description'} ||= $1  if ($html =~ m#name\=\"twitter\:description\"\s+content\=\"([^\"]+)\"#i);
		$self->{'iconurl'} = ($html =~ m#\"twitter\:image\:src\"\s+content\=\"([^\"]+)\"#) ? $1 : '';
		$self->{'iconurl'} ||= ($html =~ m#\"image\"\:\"([^\"]+)\"#) ? $1 : '';
		$self->{'iconurl'} =~ s#\\u002F#\/#g;
		$self->{'iconurl'} =~ s#\?.+$##;
		$self->{'imageurl'} = ($html =~ m#\"bannerImage\"\:\"([^\"]+)\"#) ? $1 : $self->{'iconurl'};
		$self->{'imageurl'} =~ s#\\u002F#\/#g;
		$self->{'imageurl'} =~ s#\?.+$##;
		if ($self->{'artist'} =~ /\S/) {
			$self->{'artist'} =~ s/\s*\\?u?003E\s*$//;
			$self->{'artist'} = HTML::Entities::decode_entities($self->{'artist'});
			$self->{'artist'} = uri_unescape($self->{'artist'});
		}
		my $genre = ($html =~ m#\"rootGenre\"\:\"([^\"]+)\"#) ? $1 : '';
		my $subgenre = ($html =~ m#\"primaryGenreName\"\:\"([^\"]+)\"#) ? $1 : '';
		if ($genre && $subgenre) {
			#$self->{'genre'} = ($genre eq 'music') ? $subgenre : $genre . ' - ' . $subgenre;
			$self->{'genre'} = ($genre =~ /music/i) ? $subgenre : $genre;
		} elsif ($genre) {
			$self->{'genre'} = $genre;
		} elsif ($subgenre) {
			$self->{'genre'} = $subgenre;
		}
		if ($self->{'genre'}) {
			$self->{'genre'} =~ s/\s*\\?u?003E\s*$//;
			$self->{'genre'} = HTML::Entities::decode_entities($self->{'genre'});
			$self->{'genre'} = uri_unescape($self->{'genre'});
		}
	}
	return undef  unless ($self->{'id'});

	my $stationID = $self->{'id'};
	while ($html =~ s#\"playUrl\"\:\"([^\"]+)\"#STREAMFINDER_MARK#i) {  #PROBABLY A PODCAST?:
		(my $one = $1) =~ s#\\u002F#\/#g;
		$one =~ s/\.(mp3|pls)\?.*$/\.$1/  unless ($self->{'notrim'});   #STRIP OFF EXTRA GARBAGE PARMS, COMMENT OUT IF STARTS FAILING!
		unless ($self->{'secure'} && $one !~ /^https/o) {
			push @{$self->{'streams'}}, $one;
			$self->{'cnt'}++;
		}
		print STDERR "i:Found stream ($one) in page.\n"  if ($DEBUG);
	}
	if ($self->{'cnt'}) {   #STREAM(S) FOUND, PBLY. A PODCAST (EPISODE):
		$self->{'id'} .= '/' . $1  if ($html =~ s#\"guideId\"\:\"([^\"]+)\"\,STREAMFINDER_MARK#STREAMFINDER_MARK#i);
		$self->{'created'} = $1  if ($html =~ s#\"publishTime\"\:\"([^\"]*)\"\,STREAMFINDER_MARK##i);
		$self->{'year'} = (defined($self->{'created'}) && $self->{'created'} =~ /(\d\d\d\d)/) ? $1 : '';
		print STDERR "i:Podcast found, ID changed to (".$self->{'id'}."), year (".$self->{'year'}.").\n"  if ($DEBUG);
	} elsif ($html =~ m#\bhref\=\".+?\/\?topicId\=([^\"]+)#) {  #NO STREAMS FOUND, BUT WE'RE A PODCAST (PAGE):
		$url2fetch = 'https://tunein.com/podcasts/'.$self->{'id'}.'/?topicId=' . $1;
		print STDERR "--RETRY (PODCAST PAGE) 1ST EPISODE URL=$url2fetch=\n"  if ($DEBUG);
		++$tried;
		goto TRYIT;
	} elsif (!$tried) {  #(USUALLY) NO STREAMS / PODCASTS EPISODES FOUND (PBLY. A STATION):
		#SEE:  https://stackoverflow.com/questions/52754263/playing-a-live-tunein-radio-url-ios-swift
		#ALSO: https://github.com/core-hacked/tunein-api/commit/a1bebe327f46cdaab0f1306741546438020584b9
		my $tryStream = "https://opml.radiotime.com/Tune.ashx?id=$stationID&render=json";
		print STDERR "-2 (we're a station) FETCHING URL=$tryStream=\n"  if ($DEBUG);
		my $response = $ua->get($tryStream);
		if ($response->is_success) {
			$html = $response->decoded_content;
		} else {
			print STDERR $response->status_line  if ($DEBUG);
			my $no_wget = system('wget','-V');
			unless ($no_wget) {
				print STDERR "\n..trying wget...\n"  if ($DEBUG);
				$html = `wget -t 2 -T 20 -O- -o /dev/null \"$url2fetch\" 2>/dev/null `;
			}
		}

		if ($html) {
			print STDERR "-2a opml.radiotime.com returned HTML==>$html<==\n"  if ($DEBUG > 1);
			while ($html =~ s#\"url\"\:\s*\"([^\"]+)\"##so) {
				my $stream = $1;
				$stream =~ s/\.(mp3|pls)\?.*$/\.$1/  unless ($self->{'notrim'});
				unless ($self->{'secure'} && $stream !~ /^https/o) {
					my $ext = $1  if ($stream =~ m#\.(\w+)#);
					if ($okStreams =~ m#(?:any|all)#io || (defined($ext) && $okStreams =~ m#$ext#i)) {
						print STDERR "---ADDING STREAM=$stream=\n"  if ($DEBUG);
						push @{$self->{'streams'}}, $stream;
						$self->{'cnt'}++;
					}
				}
			}
		}
		$self->{'album'} = $self->{'artist'};
		$self->{'artist'} = '';  #ONLY PODCASTS HAVE ARTISTS, NOT STATIONS!
	}
	$self->{'total'} = $self->{'cnt'};
	$self->{'title'} = HTML::Entities::decode_entities($self->{'title'});
	$self->{'title'} = uri_unescape($self->{'title'});
	$self->{'description'} ||= $self->{'title'};
	$self->{'description'} = HTML::Entities::decode_entities($self->{'description'});
	$self->{'description'} = uri_unescape($self->{'description'});
	$self->{'Url'} = ($self->{'total'} > 0) ? $self->{'streams'}->[0] : '';
	print STDERR "--SUCCESS: 1st stream=".$self->{'Url'}."= total=".$self->{'total'}."=\n"
			if ($DEBUG && $self->{'cnt'} > 0);
	print STDERR "\n--ID=".$self->{'id'}."=\n--TITLE=".$self->{'title'}."\n--ARTIST=".$self->{'artist'}."=\n--GENRE=".$self->{'genre'}."=\n--ICON=".$self->{'iconurl'}."=\n--IMAGE=".$self->{'imageurl'}."=\n--STREAMS=".join('|',@{$self->{'streams'}})."=\n"  if ($DEBUG);
	$self->_log($url);

	bless $self, $class;   #BLESS IT!

	return $self;
}

1
