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
#include "review.h"

#define MAJOR 0
#define MINOR 1


struct opts_t {
    char *key;
    void (*func)(int argc, char *argv[]);
};

int parse(int argc, char *argv[])
{
    int i;
    struct opts_t options[] = {
        { "apply", &apply }, { "create", &create }, { "list", &list },
        { "rm", &rm }, { "show", &show },
    };

    for (i = 0; i < 5; i++) {
        if (!strcmp(argv[1], options[i].key)) {
            init();
            options[i].func(argc, argv);
            free(path);
            return 1;
        }
    }
    printf("Unknown command `%s'.\n", argv[1]);
    return 0;
}

void usage(char should_exit)
{
    printf("usage: review [-v | --version] [-h | --help] <command> <args>\n");
    if (should_exit)
        exit(1);
}

void help()
{
    usage(0);
    printf("\nThe review commands are:\n");
    printf("   create\tCreate a new patch.\n");
    printf("   rm\t\tRemove an existing patch.\n");
    printf("   list\t\tList all the available patches.\n");
    printf("   show\t\tShow a patch.\n");
    printf("   apply\tApply a patch to a path.\n");
    exit(0);
}

int main(int argc, char *argv[])
{
    if (argc < 2 || argc > 4)
        usage(1);
    if (argv[1][0] == '-') {
        if (!strcmp(argv[1], "-v") || !strcmp(argv[1], "--version")) {
            printf("review version: %i.%i\n", MAJOR, MINOR);
            return 0;
        } else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
            help();
        usage(1);
    }
    if (!parse(argc - 2, argv))
        usage(1);
    return 0;
}
