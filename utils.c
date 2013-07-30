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


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include "review.h"


char * full_path(const char *file)
{
    char *final = (char *) malloc(strlen(path) + strlen(file) + 1);
    sprintf(final, "%s/%s", path, file);
    return final;
}

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

char * scm_command(const char *path)
{
    DIR *dir;
    char *res;
    char *scms[] = { "git", "hg", "svn" };
    char aux[4];
    int i;

    aux[0] = '.';
    for (i = 0; i < 3; i++) {
        strcpy(aux + 1, scms[i]);
        dir = opendir(aux);
        if (dir) {
            closedir(dir);
            res = (char *) malloc(strlen(path) + 16);
            sprintf(res, "%s diff > %s", scms[i], path);
            return res;
        }
    }
    return NULL;
}

void create_diff(char *path)
{
    char *scm;

    if (!ends_with(path, ".patch")) {
        path = (char *) realloc(path, strlen(path) + 6);
        sprintf(path, "%s.patch", path);
    }
    scm = scm_command(path);
    if (scm) {
        system(scm);
        free(scm);
        printf("Created a patch here: %s\n", path);
    }
    free(path);
}
