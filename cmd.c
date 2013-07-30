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


char *path;


void init()
{
    char *home = getenv("HOME");
    path = (char *) malloc(strlen(home) + 9);
    sprintf(path, "%s/.patches", home);
}

void fade()
{
    free(path);
}

void create(int n, char **args)
{
    printf("Create\n");
}

void rm(int n, char **args)
{
    char *final;
    if (!n) {
        printf("Usage: review rm <name>\n");
        exit(1);
    }

    final = (char *) malloc(strlen(path) + strlen(args[2]) + 1);
    sprintf(final, "%s/%s", path, args[2]);
    if(remove(final) != 0)
        printf("Error deleting patch named `%s'\n", args[2]);
    free(final);
}

void list(int n, char **args)
{
    DIR *dir;
    struct dirent *dp;

    dir = opendir(path);
    if (!dir) {
        printf("The .patches directory does not exist.\n");
        exit(1);
    }
    while ((dp = readdir(dir)) != NULL) {
        if (dp->d_name[0] != '.' && ends_with(dp->d_name, ".patch"))
            printf("%s\n", dp->d_name);
    }
    closedir(dir);
}

void show(int n, char **args)
{
    printf("Show\n");
}

void apply(int n, char **args)
{
    printf("Apply\n");
}
