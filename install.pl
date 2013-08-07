#!/usr/bin/perl
#
# This file is part of Review.
# Copyright (C) 2013 Miquel Sabaté Solà <mikisabate@gmail.com>
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


# Path where the lib/Review.pm file should go.
my $site_perl = '/usr/share/perl5';
if (!grep($site_perl, @INC)) {
    $site_perl .= '/site_perl';
    if (!grep($site_perl, @INC)) {
        print "Don't know where to install!\n";
        exit(1);
    }
}

# Install.
system("sudo cp review /usr/bin/");
system("sudo cp lib/Review.pm $site_perl");
system("cp misc/review_completion.sh $ENV{HOME}/.review_completion.sh");
print "Add the following line in your bashrc: ";
print "source \$HOME/.review_completion.sh\n";
