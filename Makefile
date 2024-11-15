
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
NO_COLOR = \033[0m

# Define the executable names
CLIENT = client
SERVER = server
LIBS =	libs 
CC = cc
CFLAGS = -Wall -Wextra -Werror -g #-fsanitize=address
POSTCC = -I $(INC_DIR) -L $(INC_DIR)/lib_ft -lft \
         -L $(INC_DIR)/ft_printf -lftprintf

CLIENT_DIR = ./client
SERVER_DIR = ./server
OBJ_DIR = ./obj
INC_DIR = ./inc

# Source files
CLIENT_SRC_FILES = $(shell find $(CLIENT_DIR) -name "*.c")
SERVER_SRC_FILES = $(shell find $(SERVER_DIR) -name "*.c")

# Object files
CLIENT_OBJ_FILES = $(CLIENT_SRC_FILES:$(CLIENT_DIR)/%.c=$(OBJ_DIR)/client_%.o)
SERVER_OBJ_FILES = $(SERVER_SRC_FILES:$(SERVER_DIR)/%.c=$(OBJ_DIR)/server_%.o)

# Create the obj directory if it doesn't exist
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Rule to compile .c files in client/ into .o files
$(OBJ_DIR)/client_%.o: $(CLIENT_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) -I $(INC_DIR) -I $(CLIENT_DIR) -c $< -o $@ || { echo -e "$(RED)Client compilation failed.$(NO_COLOR)"; exit 1; }

# Rule to compile .c files in server/ into .o files
$(OBJ_DIR)/server_%.o: $(SERVER_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) -I $(INC_DIR) -I $(SERVER_DIR) -c $< -o $@ || { echo -e "$(RED)Server compilation failed.$(NO_COLOR)"; exit 1; }

# Rule to create the client executable
$(CLIENT): $(CLIENT_OBJ_FILES) $(LIBS)
	@echo "$(YELLOW)Building $(CLIENT)...$(NO_COLOR)"
	@$(CC) $(CFLAGS) $(CLIENT_OBJ_FILES) $(POSTCC) -o $(CLIENT) || { echo -e "$(RED)Client linking failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Client compilation complete. Executable: $(CLIENT)$(NO_COLOR)"

# Rule to create the server executable
$(SERVER): $(SERVER_OBJ_FILES) $(LIBS)
	@echo "$(YELLOW)Building $(SERVER)...$(NO_COLOR)"
	@$(CC) $(CFLAGS) $(SERVER_OBJ_FILES) $(POSTCC) -o $(SERVER) || { echo -e "$(RED)Server linking failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Server compilation complete. Executable: $(SERVER)$(NO_COLOR)"

# Rule to build the included libraries
$(LIBS):
	@echo "$(YELLOW)Building libraries...$(NO_COLOR)"
	@make -C $(INC_DIR)/lib_ft > /dev/null 2>&1 || { echo -e "$(RED)Failed to build lib_ft$(NO_COLOR)"; exit 1; }
	@make -C $(INC_DIR)/ft_printf > /dev/null 2>&1 || { echo -e "$(RED)Failed to build ft_printf$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Libraries built successfully.$(NO_COLOR)"

# Build only the libraries
libs: $(LIBS)

# Build only the client
client: $(CLIENT)

# Build only the server
server: $(SERVER)

# Build both client and server
all: $(CLIENT) $(SERVER) $(LIBS)

# Clean object files
clean:
	@rm -rf $(OBJ_DIR)
	@make clean -C $(INC_DIR)/lib_ft > /dev/null 2>&1
	@make clean -C $(INC_DIR)/ft_printf > /dev/null 2>&1
	@echo "$(GREEN)Clean complete.$(NO_COLOR)"

# Full clean including executables
fclean: clean
	@rm -f $(CLIENT) $(SERVER)
	@make fclean -C $(INC_DIR)/lib_ft > /dev/null 2>&1
	@make fclean -C $(INC_DIR)/ft_printf > /dev/null 2>&1
	@echo "$(GREEN)Full clean complete.$(NO_COLOR)"

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re client server

