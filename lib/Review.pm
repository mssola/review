#
# This file is part of Review.
# Copyright (C) 2013-2014 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package Review;

use strict;

# Version string.
our $VERSION = '0.3';


# Public: Create a new Review instance.
sub new
{
    my ($klass) = @_;
    my $path = "$ENV{'HOME'}/.patches";
    bless { path => $path }, $klass;
}

# Public: Parse the given command and try to run it with the given commands.
#
# Two arguments are expected to be passed to this function. The first argument
# is a string containing the name of the command. The second argument is a
# reference to the options that have to be passed to the command.
#
# Returns 1 on success and 0 otherwise.
sub parse
{
    my ($self, $cmd, $opts_r) = @_;

    if (grep { $_ eq $cmd } qw( apply create download list rm show )) {
        $self->$cmd($opts_r);
        return 1;
    }
    print "Unknown command `$cmd'.\n";
    return 0;
}

# Public: Create the specified patch from the current directory.
sub create
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 1) {
        print "usage: review create <name>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    $self->generate_diff($path);
}

# Public: Remove the specified patch.
sub rm
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 1) {
        print "usage: review rm <name>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    if (unlink($$path) != 1) {
        print("Error deleting patch named `$opts[0]'.\n");
    }
}

# Public: List all the patches inside the $HOME/.patches directory.
sub list
{
    my ($self) = @_;

    opendir(my $patches, $self->{path}) or die $!;
    while (my $file = readdir($patches)) {
        next if ($file =~ m/^\./ || $file !~ /.patch\Z/);
        print "$file\n";
    }
    closedir($patches);
}

# Public: Show the contents of the specified patch. The contents will be shown
# by calling the set $EDITOR.
sub show
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 1) {
        print "usage: review show <name>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    my $editor = $ENV{'EDITOR'} || 'vi';
    system("$editor $$path");
}

# Public: Apply the contents of the specified patch to the current directory.
sub apply
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 1) {
        print "usage: review apply <name>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    system("patch -p1 < $$path");
}

# Public: Download a patch from the given URL and create it under the specified
# name. The first argument is the new name, and the second argument is the URL.
sub download
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 2) {
        print "usage: review download <name> <url>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    system("wget $opts[1] -O $$path");
}

# Private: Returns the full path from the given relative path.
sub full_path
{
    my ($self, $rel) = @_;
    my $path = sprintf("%s/%s", $self->{path}, $$rel);
    if ($path !~ /.patch\Z/) {
        $path .= '.patch';
    }
    return \$path;
}

# Private: It generates a diff file by taking the current SCM into account.
# Currently supported SCM are: Git, Mercurial and SVN.
sub generate_diff
{
    my ($self, $path) = @_;
    my @scms = qw( git hg svn );

    foreach my $i (@scms) {
        if (-d ".$i") {
            system("$i diff > $$path");
            last;
        }
    }
}
