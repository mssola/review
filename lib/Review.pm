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
#

package Review;

use strict;

our $VERSION = '0.2';


sub new
{
    my ($klass) = @_;
    my $path = "$ENV{'HOME'}/.patches";
    bless { path => $path }, $klass;
}

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

sub create
{
    my ($self, $opts_r) = @_;
    my @opts = @$opts_r;

    if (@opts != 1) {
        print "usage: review apply <name>\n";
        exit(1);
    }
    my $path = $self->full_path(\$opts[0]);
    $self->generate_diff($path);
}

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

sub full_path
{
    my ($self, $rel) = @_;
    my $path = sprintf("%s/%s", $self->{path}, $$rel);
    if ($path !~ /.patch\Z/) {
        $path .= '.patch';
    }
    return \$path;
}

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
