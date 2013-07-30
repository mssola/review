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


#ifndef REVIEW_H_
#define REVIEW_H_


char *path;


/*
 * cmd.c
 */

void init();
void create(int n, char **args);
void rm(int n, char **args);
void list(int n, char **args);
void show(int n, char **args);
void apply(int n, char **args);
void download(int n, char **args);


/*
 * utils.c
 */

char * full_path(const char *file);
int ends_with(const char *str, const char *suffix);
void create_diff(char *path);


#endif /* REVIEW_H_ */
