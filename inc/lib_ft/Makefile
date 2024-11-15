# Name of the library
NAME = libft.a

# Compiler
CC = cc

# Directory containing the source files
SRC_DIR = .

# Compiler flags
CFLAGS = -Wall -Wextra -Werror -g

# Source files to be compiled into objects
SRCS = $(find $(SRC_DIR) -name "*.c")

# Source files for the bonus part
BONUS_SRCS = ft_lstnew.c ft_lstadd_front.c ft_lstsize.c ft_lstlast.c \
	ft_lstadd_back.c ft_lstdelone.c ft_lstclear.c \
	ft_lstiter.c ft_lstmap.c

# Object files generated from source files
OBJS = $(SRCS:%.c=$(SRC_DIR)/%.o)
BONUS_OBJS = $(BONUS_SRCS:%.c=$(SRC_DIR)/%.o)

# Directory containing header files
INC_DIR = .

# Rule to compile individual source files into object files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to create the target library
$(NAME): $(OBJS)
	@ar rc $(NAME) $(OBJS)
	@ranlib $(NAME)

# Rule to build the library
all: $(NAME)

#Rule to build the bonus part
bonus: $(BONUS_OBJS)
	@ar rc $(NAME) $(BONUS_OBJS)
	@ranlib $(NAME)

# Rule to remove object files
clean:
	@rm -f $(OBJS) $(BONUS_OBJS)

# Rule to remove object files and the target library
fclean: clean
	@rm -f $(NAME) $(BONUS_OBJS)

# Rule to perform a full rebuild
re: fclean all

# Default target
.DEFAULT_GOAL := all

#PHONY
.PHONY: all bonus clean fclean re

# End of Makefile
