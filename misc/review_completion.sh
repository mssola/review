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

__list()
{
    opts=`ls $HOME/.patches | grep ".patch$"`
    __revcomp "${opts}"
}

_review()
{
    local i c=1 command __git_dir
    opts="create rm list show apply"

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
    *) COMPREPLY=() ;;
    esac
}


complete -o default -o nospace -F _review review
