#
# This file is part of Review. This file is based on the work done in the
# git completion file. This file is available in here:
# https://git.kernel.org/cgit/git/git.git/tree/contrib/completion/git-completion.bash
#
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


# Do the completion work. Shamelessly taken from the git completion script.
__revcomp()
{
    local all c s=$'\n' IFS=' '$'\t'$'\n'
    local cur="${COMP_WORDS[COMP_CWORD]}"

    for c in $1; do
        case "$c$4" in
        --*=*) all="$all$c$4$s" ;;
        *.)    all="$all$c$4$s" ;;
        *)     all="$all$c$4 $s" ;;
        esac
    done
    IFS=$s
    COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
    return
}

# Complete by listing the patch files inside the directory of patches.
__list()
{
    opts=`ls $HOME/.patches | grep ".patch$"`
    __revcomp "${opts}"
}

# Main function for the completion of the review command.
_review()
{
    local c=1 command
    opts="create rm list show apply download"

    while [ $c -lt $COMP_CWORD ]; do
        command="${COMP_WORDS[c]}"
        c=$((++c))
    done

    if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
        case "${COMP_WORDS[COMP_CWORD]}" in
        --*)   __revcomp "--version --help" ;;
        *)     __revcomp "${opts}" ;;
        esac
        return
    fi

    case "$command" in
    create)     __list ;;
    rm)         __list ;;
    show)       __list ;;
    apply)      __list ;;
    download)   __list ;;
    *) COMPREPLY=() ;;
    esac
}


complete -o default -o nospace -F _review review
