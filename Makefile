# Compilateur et options
CC = gcc
CFLAGS = -Wall -Wextra -g
TARGET = src/main
SRCS = src/main.c src/fichier.c src/equipement.c
OBJS = $(SRCS:.c=.o)

# Cible par défaut
all: $(TARGET)

# Compilation du programme
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compilation des fichiers .c en .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Nettoyage
clean:
	rm -f $(OBJS) $(TARGET)

# Reconstruire
rebuild: clean all

# Débogage
debug: all
	gdb ./$(TARGET)

# Installation
install: all
	./install.sh

.PHONY: all clean rebuild debug install
