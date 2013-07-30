/*
 * This file is part of Review.
 * Copyright (C) 2013 Miquel Sabaté Solà <mikisabate@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#include <string.h>
#include "cmd.h"


int ends_with(const char *str, const char *suffix)
{
    if (!str || !suffix)
        return 0;
    size_t str_l = strlen(str);
    size_t suffix_l = strlen(suffix);
    if (suffix_l > str_l)
        return 0;
    return !strncmp(str + str_l - suffix_l, suffix, suffix_l);
}
