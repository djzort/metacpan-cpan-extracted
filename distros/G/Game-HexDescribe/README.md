# Hex Describe

This application takes a map generated by *Text Mapper* and a set of
random tables to generate a textual description of the region. It's
ideal if your players are wandering into unprepared regions, and it's
great if you need some seed material to base your work on.

You can provide your own random tables if you have the file online
somewhere in a [Pastebin](https://en.wikipedia.org/wiki/Pastebin) or
shared it from Dropbox, etc.

The format is simple: every word in the map description and every two
word combo from the map description is a potential table in your file.
If it exists, it will be used.

Assuming the following description:

```text
0101 dark-green trees village
```

The description will be generated from any tables that match:

* dark-green
* trees
* village

It would make sense to just provide tables for "trees" and "village",
for example.

Tables looks like this:

```text
;trees
1,some trees
1,you encounter [forest monster]

;forest monster
3,[3d6] bandits
1,an elf
```

A semicolon and some text begin a new table. A number, a comma, and
some text are an entry in he table. The text needs to be on one line.
The numbers are relative probabilities. The chances for an encounter
in the forest are thus 50% and the chances to encounter an elf, if you
are encountering anything at all, are 25%. The example also shows how
you can link from one table to another using square brackets.

Square brackets are also used for dice rolls. A dice roll can look
like this: 3d6, 3d6+5 3d6x10, or 3d6x10+5.

There's an built-in help page with more details for end users. If you
intend to host the application yourself, use `perldoc hex-describe.pl`
to get a more technical documentation based on the comments in the
code.

[Try it](https://campaignwiki.org/hex-describe).

The app comes with a tutorial built in. See the
[Help](https://campaignwiki.org/hex-describe/help) link.

## Dependencies

Perl Modules (or Debian modules):

* Array::Utils or libarray-utils-perl
* IO::Socket::SSL or libio-socket-ssl-perl
* LWP::UserAgent or liblwp-useragent-perl
* List::MoreUtils or liblist-moreutils-perl
* Modern::Perl or libmodern-perl-perl
* Mojolicious or libmojolicious-perl
* Text::Autoformat or libtext-autoformat-perl
* File::ShareDir or libfile-sharedir-perl
* File::ShareDir::Install or libfile-sharedir-install-perl

The IO::Socket::SSL dependency means that you’ll need OpenSSL
development libraries installed as well: openssl-devel or equivalent,
depending on your package manager.

To install from the working directory (which will also install all the
dependencies) use cpan or cpanm.

Example:

```bash
cpanm .
```

## Installation

Use cpan or cpanm to install Game::HexDescribe.

Using `cpan`:

```shell
cpan Game::HexDescribe
```

Manual install:

```shell
perl Makefile.PL
make
make install
```

## Configuration

In the directory you want to run it from, you may create a config file
named `hex-describe.conf` like the following:

```perl
{
  # error, warn, info, or debug
  loglevel => 'debug',
  # undef means stderr, or a file name
  logfile => undef,
  # undef means the default directory, or a directory name
  contrib => 'share',
  # the URL where you run Text Mapper to generate maps (optional)
  text_mapper_url => 'http://localhost:3010',
  # the URL where you run Face Generator to generate faces (optional)
  face_generator_url => 'http://localhost:3020',
}
```

## Development

As a developer, morbo makes sure to restart the web app whenever a
file changes:

```bash
morbo --mode development --listen "http://*:3000" script/hex-describe
```

Alternatively:

```bash
script/hex-describe daemon --mode development --listen "http://*:3000"
```
