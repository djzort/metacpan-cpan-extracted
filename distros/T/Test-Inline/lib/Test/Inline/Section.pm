package Test::Inline::Section;
# ABSTRACT: Implements a section of tests

#pod =pod
#pod
#pod =head1 DESCRIPTION
#pod
#pod This class implements a single section of tests. That is, a section of POD
#pod beginning with C<=begin test> or C<=begin testing>.
#pod
#pod =head2 Types of Sections
#pod
#pod There are two types of code sections. The first, beginning with 
#pod C<=begin testing ...>, contains a set of tests and other code to be executed
#pod at any time (within a set of specifyable constraints). The second, labelled
#pod C<=begin testing SETUP>, contains code to be executed at the beginning of the
#pod test script, before any of the other sections are executed. This allows
#pod any needed variables or environment to be set up before the tests are run.
#pod You can have more than one setup section, and they will be written to the
#pod test file in order of appearance.
#pod
#pod =head2 Test Section Header Syntax
#pod
#pod Some examples of the different types of test headers are as follows.
#pod
#pod   # Normal anonymous test
#pod   =begin testing
#pod   
#pod   ok( $foo == $bar, 'This is a test' );
#pod   
#pod   =end testing
#pod   
#pod   # A named test. Also provides the number of tests to run.
#pod   # Any test section can specify the number of tests.
#pod   =begin testing my_method 1
#pod   
#pod   ok( $foo->my_method, '->my_method returns true' );
#pod   
#pod   =end testing
#pod   
#pod   # A named test with pre-requisites.
#pod   # Note that ONLY named tests can have pre-requisites
#pod   =begin testing this after my_method foo bar other_method Other::Class
#pod   
#pod   ok( $foo->this, '->this returns true' );
#pod   
#pod   =end testing
#pod
#pod The first example shows a normal anonymous test. All anonymous test sections
#pod are considered low priority, and we be run, in order of appearance, AFTER all
#pod named tests have been run.
#pod
#pod Any and all arguments used after "testing" must be in the form of simple
#pod space seperated words. The first word is considered the "name" of the test.
#pod The intended use for these is generally to create one named test section for 
#pod each function or method, but you can name them as you please. Test names 
#pod B<must> be unique, and B<are> case sensitive.
#pod
#pod After the name, you can provide the word "after" and provide a list of other
#pod named tests that must be completed first in order to run this test. This is
#pod provided so that when errors are encounted, they are probably the result of
#pod this method or set of tests, and not in some other method that this one 
#pod relies on. It makes debugging a lot easier. The word after is only a 
#pod keyword when after the test name, so you can use a test name of after as well.
#pod The following are both legal
#pod
#pod   =begin testing after after that
#pod   =begin testing this after after
#pod
#pod The easiest and recommended way of labeling the tests is simple to name all
#pod tests after their methods, and put as a pre-requisite any other methods that
#pod the method you are testing calls. Test::Inline will take care of writing the
#pod tests to the test script in the correct order. Please note you can NOT define
#pod circular relationships in the prerequisites, or an error will occur.
#pod
#pod If a number is provided as the last value, it will be taken to mean the
#pod number of actual tests that will occur during the test section. While
#pod preparing to write the test files, the processor will try to use these
#pod to try to determine the number of files to write. If ALL test sections to
#pod be written to a particular file have a test count, then the script will
#pod use the total of these as a basic for providing Test::More with a plan.
#pod
#pod If ANY test sections to be written to a file do not have a test count, the
#pod test file with use C<no_plan>.
#pod
#pod Finally, Test::Inline will try to be forgiving in it's parsing of the tests.
#pod any missing prerequisites will be ignored. Also, as long as it does not
#pod break a prerequisite, all named tests will be attempted to be run in their
#pod order of appearance.
#pod
#pod =head1 METHODS
#pod
#pod =cut

use strict;
use List::Util                  ();
use Params::Util                qw{_ARRAY};
use Algorithm::Dependency::Item ();

our $VERSION = '2.214';
our @ISA     = 'Algorithm::Dependency::Item';
our $errstr  = '';





#####################################################################
# Constructor and Parsing

#pod =pod
#pod
#pod =head2 new
#pod
#pod   my $Section = Test::Inline::Section->new( $pod );
#pod
#pod The C<new> constructor takes a string of POD, which must be a single section
#pod of relevant pod ( preferably produced by L<Test::Inline::ExtractHandler> ),
#pod and creates a new section object for it.
#pod
#pod Returns a new C<Test::Inline::Section> object if passed POD in the form
#pod C<=begin testing ...>. Returns C<undef> on error.
#pod
#pod =cut

my $RE_begin   = qr/=begin\s+(?:test|testing)/;
my $RE_example = qr/=for\s+example\s+begin/;

sub new {
	$errstr     = '';
	my $class   = shift;
	my $pod     = $_[0] =~ /^(?:$RE_begin|$RE_example)\b/ ? shift :
		return $class->_error("Test section does not begin with =begin test[ing]");
	my $context = shift;

	# Split into lines
	my @lines = split /(?:\015{1,2}\012|\015|\012)/, $pod;

	# Handle =for example seperately
	if ( $pod =~ /^$RE_example\b/ ) {
		return $class->_example( \@lines, $context );
	}

	# Get the begin paragraph ( yes, paragraph. NOT line )
	my $begin = '';
	while ( @lines and $lines[0] !~ /^\s*$/ ) {
		$begin .= ' ' if $begin;
		$begin .= shift @lines;
	}

	# Remove the trailing end tag
	if ( @lines and $lines[-1] =~ /^=end\s+(?:test|testing)\b/o ) {
		pop @lines;
	}

	# Do some cleaning up and checking
	$class->_trim_empty_lines( \@lines );
	$class->_check_nesting( \@lines, $begin ) or return undef;

	# Create the basic object
	my $self = bless {
		begin   => $begin,
		content => join( '', map { "$_\n" } @lines ),
		setup   => '',       # Is this a setup section
		example => '',       # Is this an example section
		context => $context, # Package context
		name    => undef,    # The name of the test
		tests   => undef,    # undef means unknown test count
		after   => {},       # Other named methods this should be after
		classes => {},       # Other classes this should be after
		}, $class;

	# Start processing the begin line
	my @parts = split /\s+/, $begin;

	# Remove the =begin
	shift @parts;

	# If the line contains a number then this is part of the tests
	foreach my $i ( 0 .. $#parts ) {
		next unless $parts[$i] =~ /^(0|[1-9]\d*)$/;
		$self->{tests} = splice @parts, $i, 1;
		last;
	}

	# Handle setup sections via =begin test setup or =begin testing SETUP
	if ( @parts == 2 and $parts[0] eq 'test' and $parts[1] eq 'setup' ) {
		$self->{setup} = 1;
	}
	if ( @parts >= 2 and $parts[0] eq 'testing' and $parts[1] eq 'SETUP' ) {
		$self->{setup} = 1;
	}

	# Any other form of =begin test is not allowed
	if ( $parts[0] eq 'test' and ! $self->{setup} ) {
		# Unknown =begin test line
		return $class->_error("Unsupported '=begin test' line '$begin'");
	}

	# Remove the "testing" word
	shift @parts;

	# If there are no remaining parts, we are anonymous,
	# and can just return as is.
	return $self unless @parts;

	# Make sure all remaining parts are only words
	if ( grep { ! /^[\w:]+$/ } @parts ) {
		return $class->_error("Found something other than words: $begin");
	}

	# The first word is our name and must match the perl
	# format for a method name.
	if ( $self->{setup} ) {
		shift @parts;
	} else {
		$self->{name} = shift @parts;
		unless ( $self->{name} =~ /^[^\W\d]\w*$/ ) {
			return $class->_error("'$self->{name}' is not a valid test name: $begin");
		}
	}
	return $self unless @parts;

	# The next word MUST be "after"
	unless ( shift @parts eq 'after' ) {
		return $class->_error("Word after test name is something other than 'after': $begin");
	}

	# The remaining words are our dependencies.
	# Simple words chunks are method dependencies, and anything
	# containing :: (including at the end) is a dependency on
	# another module that should be part of the testing process.
	foreach my $part ( @parts ) {
		if ( $part =~ /^[^\W\d]\w*$/ ) {
			if ( $self->setup ) {
				return $class->_error("SETUP sections can only have class dependencies");
			}
			$self->{after}->{$part} = 1;
		} elsif ( $part =~ /::/ ) {
			$part =~ s/::$//; # Strip trailing ::
			$self->{classes}->{$part} = 1;
		} else {
			return $class->_error("Unknown dependency '$part' in begin line: $begin");
		}
	}

	$self;
}

# Handle the creation of example sections
sub _example {
	my $class   = shift;
	my @lines   = @{shift()};
	my $context = shift;

	# Get the begin paragraph ( yes, paragraph. NOT line )
	my $begin = '';
	while ( @lines and $lines[0] !~ /^\s*$/ ) {
		$begin .= ' ' if $begin;
		$begin .= shift @lines;
	}

	# Remove the trailing end tag
	if ( @lines and $lines[-1] =~ /^=for\s+example\s+end\b/o ) {
		pop @lines;
	}

	# Remove any leading and trailing empty lines
	$class->_trim_empty_lines( \@lines );
	$class->_check_nesting( \@lines, $begin ) or return undef;

	# Create the basic object
	my $self = bless {
		begin   => $begin,
		content => join( '', map { "$_\n" } @lines ),
		setup   => '',       # Is this a setup section
		example => 1,        # Is this an example section
		context => $context, # Package context
		name    => undef,    # Examples arn't named
		tests   => 1,        # An example always consumes 1 test
		after   => {},       # Other named methods this should be after
		classes => {},       # Other classes this should be after
		}, $class;

	$self;
}

sub _error {
	$errstr = join ': ', @_;
	undef;
}

sub _short {
	my $either = shift;
	my $string = shift;
	chomp $string;
	$string =~ s/\n/ /g;
	if ( length($string) > 30 ) {
		$string = substr($string, 27);
		$string =~ s/\s+$//;
		$string .= '...';
	}
	$string;
}

sub _check_nesting {
	my ($class, $lines, $begin) = @_;

	# In the remaining lines there shouldn't be any lines
	# that look like a POD tag. If there is there is probably
	# a nesting problem.
	my $bad_line = List::Util::first { /^=\w+/ } @$lines;
	if ( $bad_line ) {
		$bad_line = $class->_short($bad_line);
		$begin    = $class->_short($begin);
		return $class->_error(
			"POD statement '$bad_line' illegally nested inside of section '$begin'"
			);
	}

	1;
}

sub _trim_empty_lines {
	my $lines = $_[1];
	while ( @$lines and $lines->[0]  eq '' ) { shift @$lines }
	while ( @$lines and $lines->[-1] eq '' ) { pop @$lines   }
	1;
}





#####################################################################
# Main Methods

#pod =pod
#pod
#pod =head2 parse
#pod
#pod   my $SectionList = Test::Inline::Section( @elements );
#pod
#pod Since version 1.50 L<Test::Inline> has been extracting package statements
#pod so that as the sections are extracted, we can determine which sections
#pod belong to which packages, and seperate them accordingly.
#pod
#pod The C<parse> method takes B<all> of the elements from a file, and returns
#pod all of the Sections. By doing it here, we can track the package context
#pod and set it in the Sections.
#pod
#pod =cut

sub parse {
	$errstr      = '';
	my $class    = shift;
	my $elements = _ARRAY(shift) or return undef;
	my @Sections = ();

	# Iterate over the elements and maintain package contexts
	my $context = '';
	foreach my $element ( @$elements ) {
		if ( $element =~ /^package\s+([\w:']+)/ ) {
			$context = $1;
			next;
		}

		# Handle weird unexpected elements
		unless ( $element =~ /^=/ ) {
			return $class->_error("Unexpected element '$element'");
		}

		# Hand off to the Section constructor
		my $Section = Test::Inline::Section->new( $element, $context ) or return undef;
		push @Sections, $Section;
	}

	@Sections ? \@Sections : undef;
}

#pod =pod
#pod
#pod =head2 setup
#pod
#pod   my $run_first = $Section->setup;
#pod
#pod The C<setup> accessor indicates that this section is a "setup" section,
#pod to be run at the beginning of the generated test script.
#pod
#pod Returns true if this is a setup section, false otherwise.
#pod
#pod =cut

sub setup { $_[0]->{setup} }

#pod =pod
#pod
#pod =head2 example
#pod
#pod   my $just_compile = $Section->example;
#pod
#pod The C<example> accessor indicates that this section is an "example"
#pod section, to be compile-tested instead of run.
#pod
#pod Returns true if this is an example section, false otherwise.
#pod
#pod =cut

sub example { $_[0]->{example} }

#pod =pod
#pod
#pod =head2 context
#pod
#pod The C<context> method returns the package context of the unit test section,
#pod or false if the unit test section appeared out of context.
#pod
#pod =cut

sub context { $_[0]->{context} }

#pod =pod
#pod
#pod =head2 name
#pod
#pod The C<name> method returns the name of the test section,
#pod or false if the test if anonymous.
#pod
#pod =cut

sub name  { defined $_[0]->{name} and $_[0]->{name} }

#pod =pod
#pod
#pod =head2 tests
#pod
#pod The C<tests> method returns the number of Test::Builder-compatible
#pod tests that will run within the test section. Returns C<undef> if the
#pod number of tests is unknown.
#pod
#pod =cut

sub tests { $_[0]->{tests} }

#pod =pod
#pod
#pod =head2 begin
#pod
#pod For use mainly in debugging, the C<begin> method returns the literal string
#pod of the begin line/paragraph.
#pod
#pod =cut

sub begin { $_[0]->{begin} }

#pod =pod
#pod
#pod =head2 anonymous
#pod
#pod   my $is_anonymous = $Section->anonymous;
#pod
#pod The C<anonymous> method returns true if the test section is an unnamed
#pod anonymous section, or false if it is a named section or a setup section.
#pod
#pod =cut

sub anonymous {
	my $self = shift;
	! (defined $self->{name} or $self->{setup});
}

#pod =pod
#pod
#pod =head2 after
#pod
#pod   my @names = $Section->after;
#pod
#pod The C<after> method returns the list of other named tests that this
#pod test section says it should be run after.
#pod
#pod Returns a list of test name, or the null list C<()> if the test does
#pod not have to run after any other named tests.
#pod
#pod =cut

sub after {
	keys %{$_[0]->{after}};
}

#pod =pod
#pod
#pod =head2 classes
#pod
#pod   my @classes = $Section->classes;
#pod
#pod The C<classes> method returns the list of test classes that the test depends
#pod on, and should be run before the tests. These values are used to determine the
#pod set of class-level dependencies for the entire test file.
#pod
#pod Returns a list of class names, or the null list C<()> if the test does
#pod not have any class-level dependencies.
#pod
#pod =cut

sub classes {
	keys %{$_[0]->{classes}};
}

#pod =pod
#pod
#pod =head2 content
#pod
#pod   my $code = $Section->content;
#pod
#pod The C<content> method returns the actual testing code contents of the 
#pod section, with the leading C<=begin> and trailing C<=end> removed.
#pod
#pod Returns a string containing the code, or the null string C<""> if the
#pod section was empty.
#pod
#pod =cut

sub content { $_[0]->{content} }





#####################################################################
# Implementing the Algorithm::Dependency::Item interface

# The ->depends method we have works the same as for
# Algorithm::Dependency::Item already, so we just need to implement
# it's ->id method, which is the same as our ->name method

sub id      { $_[0]->name  }
sub depends { $_[0]->after }

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::Inline::Section - Implements a section of tests

=head1 VERSION

version 2.214

=head1 DESCRIPTION

This class implements a single section of tests. That is, a section of POD
beginning with C<=begin test> or C<=begin testing>.

=head2 Types of Sections

There are two types of code sections. The first, beginning with 
C<=begin testing ...>, contains a set of tests and other code to be executed
at any time (within a set of specifyable constraints). The second, labelled
C<=begin testing SETUP>, contains code to be executed at the beginning of the
test script, before any of the other sections are executed. This allows
any needed variables or environment to be set up before the tests are run.
You can have more than one setup section, and they will be written to the
test file in order of appearance.

=head2 Test Section Header Syntax

Some examples of the different types of test headers are as follows.

  # Normal anonymous test
  =begin testing
  
  ok( $foo == $bar, 'This is a test' );
  
  =end testing
  
  # A named test. Also provides the number of tests to run.
  # Any test section can specify the number of tests.
  =begin testing my_method 1
  
  ok( $foo->my_method, '->my_method returns true' );
  
  =end testing
  
  # A named test with pre-requisites.
  # Note that ONLY named tests can have pre-requisites
  =begin testing this after my_method foo bar other_method Other::Class
  
  ok( $foo->this, '->this returns true' );
  
  =end testing

The first example shows a normal anonymous test. All anonymous test sections
are considered low priority, and we be run, in order of appearance, AFTER all
named tests have been run.

Any and all arguments used after "testing" must be in the form of simple
space seperated words. The first word is considered the "name" of the test.
The intended use for these is generally to create one named test section for 
each function or method, but you can name them as you please. Test names 
B<must> be unique, and B<are> case sensitive.

After the name, you can provide the word "after" and provide a list of other
named tests that must be completed first in order to run this test. This is
provided so that when errors are encounted, they are probably the result of
this method or set of tests, and not in some other method that this one 
relies on. It makes debugging a lot easier. The word after is only a 
keyword when after the test name, so you can use a test name of after as well.
The following are both legal

  =begin testing after after that
  =begin testing this after after

The easiest and recommended way of labeling the tests is simple to name all
tests after their methods, and put as a pre-requisite any other methods that
the method you are testing calls. Test::Inline will take care of writing the
tests to the test script in the correct order. Please note you can NOT define
circular relationships in the prerequisites, or an error will occur.

If a number is provided as the last value, it will be taken to mean the
number of actual tests that will occur during the test section. While
preparing to write the test files, the processor will try to use these
to try to determine the number of files to write. If ALL test sections to
be written to a particular file have a test count, then the script will
use the total of these as a basic for providing Test::More with a plan.

If ANY test sections to be written to a file do not have a test count, the
test file with use C<no_plan>.

Finally, Test::Inline will try to be forgiving in it's parsing of the tests.
any missing prerequisites will be ignored. Also, as long as it does not
break a prerequisite, all named tests will be attempted to be run in their
order of appearance.

=head1 METHODS

=head2 new

  my $Section = Test::Inline::Section->new( $pod );

The C<new> constructor takes a string of POD, which must be a single section
of relevant pod ( preferably produced by L<Test::Inline::ExtractHandler> ),
and creates a new section object for it.

Returns a new C<Test::Inline::Section> object if passed POD in the form
C<=begin testing ...>. Returns C<undef> on error.

=head2 parse

  my $SectionList = Test::Inline::Section( @elements );

Since version 1.50 L<Test::Inline> has been extracting package statements
so that as the sections are extracted, we can determine which sections
belong to which packages, and seperate them accordingly.

The C<parse> method takes B<all> of the elements from a file, and returns
all of the Sections. By doing it here, we can track the package context
and set it in the Sections.

=head2 setup

  my $run_first = $Section->setup;

The C<setup> accessor indicates that this section is a "setup" section,
to be run at the beginning of the generated test script.

Returns true if this is a setup section, false otherwise.

=head2 example

  my $just_compile = $Section->example;

The C<example> accessor indicates that this section is an "example"
section, to be compile-tested instead of run.

Returns true if this is an example section, false otherwise.

=head2 context

The C<context> method returns the package context of the unit test section,
or false if the unit test section appeared out of context.

=head2 name

The C<name> method returns the name of the test section,
or false if the test if anonymous.

=head2 tests

The C<tests> method returns the number of Test::Builder-compatible
tests that will run within the test section. Returns C<undef> if the
number of tests is unknown.

=head2 begin

For use mainly in debugging, the C<begin> method returns the literal string
of the begin line/paragraph.

=head2 anonymous

  my $is_anonymous = $Section->anonymous;

The C<anonymous> method returns true if the test section is an unnamed
anonymous section, or false if it is a named section or a setup section.

=head2 after

  my @names = $Section->after;

The C<after> method returns the list of other named tests that this
test section says it should be run after.

Returns a list of test name, or the null list C<()> if the test does
not have to run after any other named tests.

=head2 classes

  my @classes = $Section->classes;

The C<classes> method returns the list of test classes that the test depends
on, and should be run before the tests. These values are used to determine the
set of class-level dependencies for the entire test file.

Returns a list of class names, or the null list C<()> if the test does
not have any class-level dependencies.

=head2 content

  my $code = $Section->content;

The C<content> method returns the actual testing code contents of the 
section, with the leading C<=begin> and trailing C<=end> removed.

Returns a string containing the code, or the null string C<""> if the
section was empty.

=head1 SUPPORT

See the main L<SUPPORT|Test::Inline/SUPPORT> section.

Bugs may be submitted through L<the RT bug tracker|https://rt.cpan.org/Public/Dist/Display.html?Name=Test-Inline>
(or L<bug-Test-Inline@rt.cpan.org|mailto:bug-Test-Inline@rt.cpan.org>).

=head1 AUTHOR

Adam Kennedy <adamk@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2003 by Adam Kennedy.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
