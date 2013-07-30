EXEC = review
OBJ = main.o cmd.o utils.o

CC = gcc
CFLAGS = -O3 -Wall

V = @
Q = $(V:1=)
Q_CC = $(Q:@=@echo    '     CC       '$@;)
Q_LINK = $(Q:@=@echo    '     LD       '$@;)


review: $(OBJ)
	$(Q_LINK) $(CC) $(OBJ) -o $(EXEC)

.c.o:
	$(Q_CC) $(CC) -o $@ -c $(CFLAGS) $<

install: review
	@(cp $(EXEC) /usr/bin)

clean:
	@(rm -rf $(OBJ) $(EXEC))

redo: clean review
