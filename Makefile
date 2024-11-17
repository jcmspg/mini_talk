# Define the executable names
CLIENT = client
SERVER = server
CC = cc
CFLAGS = -Wall -Wextra -Werror -g #-fsanitize=address
POSTCC = -L$(INC_DIR) -lcombined
CLIENT_DIR = ./src/client
SERVER_DIR = ./src/server
OBJ_DIR = ./obj
INC_DIR = ./inc

# Colors
YELLOW = \033[1;33m
GREEN = \033[1;32m
RED = \033[1;31m
BLUE = \033[1;34m
CYAN = \033[1;36m
NO_COLOR = \033[0m

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
	@echo "$(BLUE)Compiling client object files...$(NO_COLOR)"
	@$(CC) $(CFLAGS) -I $(INC_DIR) -I $(CLIENT_DIR) -c $< -o $@ || { echo -e "$(RED)Client compilation failed.$(NO_COLOR)"; exit 1; }

# Rule to compile .c files in server/ into .o files
$(OBJ_DIR)/server_%.o: $(SERVER_DIR)/%.c | $(OBJ_DIR)
	@echo "$(BLUE)Compiling server object files...$(NO_COLOR)"
	@$(CC) $(CFLAGS) -I $(INC_DIR) -I $(SERVER_DIR) -c $< -o $@ || { echo -e "$(RED)Server compilation failed.$(NO_COLOR)"; exit 1; }

# Rule to create the client executable
$(CLIENT): $(CLIENT_OBJ_FILES) libs
	@echo "$(BLUE)Building $(CLIENT)...$(NO_COLOR)"
	@$(CC) $(CFLAGS) $(CLIENT_OBJ_FILES) -o $(CLIENT) $(POSTCC) || { echo -e "$(RED)Client linking failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Client compilation complete. Executable: $(CYAN)$(CLIENT)$(NO_COLOR)"

# Rule to create the server executable
$(SERVER): $(SERVER_OBJ_FILES) libs
	@echo "$(BLUE)Building $(SERVER)...$(NO_COLOR)"
	@$(CC) $(CFLAGS) $(SERVER_OBJ_FILES) -o $(SERVER) $(POSTCC) || { echo -e "$(RED)Server linking failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Server compilation complete. Executable: $(CYAN)$(SERVER)$(NO_COLOR)"

# Rule to build the included libraries
libs:
	@echo "$(BLUE)Compiling libraries...$(NO_COLOR)"
	@make -C $(INC_DIR) all > /dev/null || { echo -e "$(RED)Libraries compilation failed.$(NO_COLOR)"; exit 1; }
	@echo "$(GREEN)Libraries compilation complete.$(NO_COLOR)"

# Build only the client
client: $(CLIENT)

# Build only the server
server: $(SERVER)

# Build both client and server:
all: libs $(CLIENT) $(SERVER)

# Clean object files
clean:
	@echo "$(BLUE)Cleaning object files...$(NO_COLOR)"
	@rm -rf $(OBJ_DIR)
	@make clean -C $(INC_DIR) > /dev/null
	@echo "$(GREEN)Clean complete.$(NO_COLOR)"

# Full clean including executables
fclean: clean
	@echo "$(BLUE)Cleaning executables...$(NO_COLOR)"
	@rm -f $(CLIENT) $(SERVER)
	@make fclean -C $(INC_DIR) > /dev/null
	@echo "$(GREEN)Full clean complete.$(NO_COLOR)"

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re client server libs
