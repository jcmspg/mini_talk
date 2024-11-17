
# Name of the combined library
NAME = libcombined.a

# Compiler
CC = cc

# Compiler flags
CFLAGS = -Wall -Wextra -Werror

# Directories
LIBFT_DIR = libft
FT_PRINTF_DIR = ft_printf

# Libraries
LIBFT = $(LIBFT_DIR)/libft.a
FT_PRINTF = $(FT_PRINTF_DIR)/libftprintf.a

# Rule to build libft
$(LIBFT):
	@echo "$(YELLOW)Building lib_ft...$(NO_COLOR)"
	@make -C $(LIBFT_DIR) || { echo -e "$(RED)lib_ft compilation failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)lib_ft compilation complete.$(NO_COLOR)"

# Rule to build ft_printf
$(FT_PRINTF): $(LIBFT)
	@echo "$(YELLOW)Building ft_printf...$(NO_COLOR)"
	@make -C $(FT_PRINTF_DIR) || { echo -e "$(RED)ft_printf compilation failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)ft_printf compilation complete.$(NO_COLOR)"

# Rule to create the combined library
$(NAME): $(LIBFT) $(FT_PRINTF)
	@echo "$(YELLOW)Creating combined library...$(NO_COLOR)"
	@cp $(LIBFT) $(NAME)
	@ar -rc $(NAME) $(FT_PRINTF_DIR)/*.o
	@ranlib $(NAME)
	@echo "$(GREEN)Combined library created: $(NAME)$(NO_COLOR)"

# Rule to build the combined library
all: $(NAME)

# Rule to clean object files
clean:
	@make clean -C $(LIBFT_DIR)
	@make clean -C $(FT_PRINTF_DIR)

# Rule to clean object files and the library
fclean: clean
	@rm -f $(NAME)
	@make fclean -C $(LIBFT_DIR)
	@make fclean -C $(FT_PRINTF_DIR)

# Rule to rebuild everything
re: fclean all

.PHONY: all clean fclean re
