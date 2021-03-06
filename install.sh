#!/bin/bash
#
# This file is part of Review.
# Copyright (C) 2014-2015 Miquel Sabaté Solà <mikisabate@gmail.com>
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


set -e

# Change this variable in order to choose another path.
_path="/opt/review"

# Install everything!
sudo mkdir -p $_path
sudo mkdir -p $HOME/.patches
sudo cp "review" "$_path/review"
sudo cp -r "lib/" "$_path/lib"
cp "misc/review_completion.sh" "$HOME/.review_completion.sh"

# Final message.
cat <<HERE
All the files have been properly installed. Nonetheless, you have to set
the following lines in your .bashrc:

  export PATH=\$PATH:/opt/review
  source \$HOME/.review_completion.sh
HERE

