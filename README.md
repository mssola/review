# Review

This is a little utility that is meant to keep some order on your patches.
I keep all my patches inside the $HOME/.patches directory and then I use
this utility to work with them. In order to do this, this application allows
the user to perform the following operations:

## Create

Create a new patch from a working directory. That is, the current directory
is expected to be handled by an SCM (git, mercurial and svn supported).
After doing some hard work, you just type:

    $ review create awesome

By entering this command, now you have the awesome.patch file inside the
directory of patches. Note that the ".patch" has been added automatically.
All the other commands will require this extension.

## Remove

Remove a patch from the central directory. Example:

    $ review rm awesome.patch

## List

List all the patches available in the central directory. Example:

    $ review list

## Show

Show the specified patch. This patch will then be displayed by taking the
$EDITOR environment variable into account. If this environment variable
is not set, then review will pick "vi" (available by default in all
distributions). Example:

    $ review show awesome.patch

## Apply

Apply the specified patch to the current working directory. Example:

    $ review apply awesome.patch

## Download

Download a patch from an url and save it to the directory of patches with
a specified name. Example:

    $ review download awesome http://awesome.com/aws/patch

# Install

In order to install this utility type the following:

    $ ./install.pl

This will install the review executable file in the /usr/bin/ directory.
This installer makes use of the "sudo" command. This repo also brings a
completion file for the Bash shell. This file will be automatically installed
in:

    $HOME/.review_completion.sh

So to get completion working, add the following in your .bashrc file:

    source $HOME/.review_completion.sh


# Legal stuff

Copyright (C) 2013-2014 Miquel Sabaté Solà

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
