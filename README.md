# mini_talk

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Compilation](#compilation)
- [Running the Programs](#running-the-programs)
- [Code Explanation](#code-explanation)
  - [Client Program](#client-program)
  - [Server Program](#server-program)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction
`mini_talk` is a project developed for the 42 school curriculum. The goal of this project is to create a simple communication program in C using UNIX signals. The project consists of two programs: a server and a client. The server receives messages from the client and displays them.

## Features
- **Server Program**: Receives and displays messages sent by the client.
- **Client Program**: Sends messages to the server.
- **Signal Handling**: Uses UNIX signals (`SIGUSR1` and `SIGUSR2`) for communication between the client and server.
- **Error Handling**: Robust error handling for signal transmission and reception.

## Requirements
- **Operating System**: Linux or macOS
- **Compiler**: GCC or Clang
- **Make**: Build automation tool

## Installation
1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yourusername/mini_talk.git
    cd mini_talk
    ```

2. **Build the Project**:
    ```sh
    make
    ```

## Usage
1. **Start the Server**:
    ```sh
    ./server
    ```

2. **Send a Message from the Client**:
    ```sh
    ./client <server_pid> "Your message here"
    ```

    Replace `<server_pid>` with the process ID of the running server.

## Project Structure
```
mini_talk/
├── inc/
│   ├── libft/
│   ├── ft_printf/
│   └── mini_talk.h
├── obj/
├── src/
│   ├── client/
│   │   └── client.c
│   ├── server/
│   │   └── server.c
│   └── libft/
│   └── ft_printf/
├── Makefile
└── README.md
```

- **inc/**: Header files and libraries.
- **obj/**: Compiled object files.
- **src/**: Source code for the client and server programs.
- **Makefile**: Build instructions.
- **README.md**: Project documentation.

## Compilation
To compile the project, simply run:
```sh
make
```
This will compile the libraries and the client and server programs.

## Running the Programs
1. **Start the Server**:
    ```sh
    ./server
    ```
    The server will print its process ID (PID). Note this PID as it will be used by the client to send messages.

2. **Send a Message from the Client**:
    ```sh
    ./client <server_pid> "Your message here"
    ```
    Replace `<server_pid>` with the PID of the running server.

Sure! Here's an updated version of the 

README.md

 that includes detailed explanations of your 

client.c

 and `server.c` functions:

```markdown
# mini_talk

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Compilation](#compilation)
- [Running the Programs](#running-the-programs)
- [Code Explanation](#code-explanation)
  - [Client Program](#client-program)
  - [Server Program](#server-program)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction
`mini_talk` is a project developed for the 42 school curriculum. The goal of this project is to create a simple communication program in C using UNIX signals. The project consists of two programs: a server and a client. The server receives messages from the client and displays them.

## Features
- **Server Program**: Receives and displays messages sent by the client.
- **Client Program**: Sends messages to the server.
- **Signal Handling**: Uses UNIX signals (`SIGUSR1` and `SIGUSR2`) for communication between the client and server.
- **Error Handling**: Robust error handling for signal transmission and reception.

## Requirements
- **Operating System**: Linux or macOS
- **Compiler**: GCC or Clang
- **Make**: Build automation tool

## Installation
1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yourusername/mini_talk.git
    cd mini_talk
    ```

2. **Build the Project**:
    ```sh
    make
    ```

## Usage
1. **Start the Server**:
    ```sh
    ./server
    ```

2. **Send a Message from the Client**:
    ```sh
    ./client <server_pid> "Your message here"
    ```

    Replace `<server_pid>` with the process ID of the running server.

## Project Structure
```
mini_talk/
├── inc/
│   ├── libft/
│   ├── ft_printf/
│   └── mini_talk.h
├── obj/
├── src/
│   ├── client/
│   │   └── client.c
│   ├── server/
│   │   └── server.c
│   └── libft/
│   └── ft_printf/
├── Makefile
└── README.md
```

- **inc/**: Header files and libraries.
- **obj/**: Compiled object files.
- **src/**: Source code for the client and server programs.
- **Makefile**: Build instructions.
- **README.md**: Project documentation.

## Compilation
To compile the project, simply run:
```sh
make
```
This will compile the libraries and the client and server programs.

## Running the Programs
1. **Start the Server**:
    ```sh
    ./server
    ```
    The server will print its process ID (PID). Note this PID as it will be used by the client to send messages.

2. **Send a Message from the Client**:
    ```sh
    ./client <server_pid> "Your message here"
    ```
    Replace `<server_pid>` with the PID of the running server.

## Code Explanation

### Client Program

The client program sends a message to the server using UNIX signals.

#### `smoke_signal` Function
```c
void smoke_signal(int pid, char *msg)
{
    int i;
    int j;
    int k;

    i = 0;
    while (msg[i])
    {
        j = 0;
        while (j < 8)
        {
            if (msg[i] & (1 << j))
                k = kill(pid, SIGUSR1);
            else
                k = kill(pid, SIGUSR2);
            if (k == -1)
            {
                ft_printf("Error: Invalid PID\n");
                exit(1);
            }
            j++;
            usleep(100);
        }
        i++;
    }
}
```
- **Purpose**: Sends each character of the message to the server bit by bit using `SIGUSR1` and `SIGUSR2` signals.
- **Parameters**:
  - `pid`: The process ID of the server.
  - `msg`: The message to be sent.
- **Logic**:
  - Iterates through each character of the message.
  - For each character, sends 8 bits to the server using `SIGUSR1` for `1` and `SIGUSR2` for `0`.
  - Uses `usleep` to add a small delay between signals.

#### `main` Function
```c
int main (int argc, char **argv)
{
    int pid;
    char *msg;

    if (argc != 3)
    {
        ft_printf("Error: Invalid number of arguments\n");
        return (1);
    }
    pid = ft_atoi(argv[1]);

    if (pid < 0)
    {
        ft_printf("Error: Invalid PID\n");
        return (1);
    }

    msg = argv[2];
    smoke_signal(pid, msg);
    return (0);
}
```
- **Purpose**: Validates the input arguments and calls the `smoke_signal` function to send the message.
- **Logic**:
  - Checks if the number of arguments is correct.
  - Converts the server PID from string to integer.
  - Validates the PID.
  - Calls the `smoke_signal` function with the PID and message.

### Server Program

The server program receives messages from the client and displays them.

#### `signal_handler` Function
```c
void signal_handler(int signum)
{
    static char	c;
    static int	i;

    if (signum == SIGUSR1)
        c |= (1 << i);
    i++;
    if (i == 8)
    {
        if (c == '\0')
        {
            ft_printf("\n");
            exit(0);
        }
        ft_printf("%c", c);
        i = 0;
        c = 0;
    }
}
```
- **Purpose**: Handles the signals sent by the client and reconstructs the message.
- **Parameters**:
  - `signum`: The signal number (`SIGUSR1` or `SIGUSR2`).
- **Logic**:
  - Uses a static character `c` and an index `i` to reconstruct each character bit by bit.
  - When 8 bits are received, prints the character.
  - If the character is `'\0'`, prints a newline and exits.

#### `main` Function
```c
int	main(void)
{
	struct sigaction	signal;
	pid_t				pid;

	pid = getpid();
	ft_printf("Server PID: %d\n", pid);

    signal.sa_handler = signal_handler;
	signal.sa_flags = 0;
	sigaction(SIGUSR1, &signal, NULL);
	sigaction(SIGUSR2, &signal, NULL);
    while (1)
    {
        pause();
    }
}
```
- **Purpose**: Sets up the signal handler and waits for signals from the client.
- **Logic**:
  - Prints the server PID.
  - Sets up the `signal_handler` function to handle `SIGUSR1` and `SIGUSR2`.
  - Enters an infinite loop, waiting for signals using `pause`.

## Contributing
Contributions are welcome! Please follow these steps to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## License
This project is licensed under the MIT License. See the 

LICENSE

 file for details.

## Acknowledgements
- [42 School](https://www.42.fr/) for the project inspiration and curriculum.
- [GNU Project](https://www.gnu.org/) for the GCC compiler.
- [UNIX](https://en.wikipedia.org/wiki/Unix) for the signal handling mechanisms.

---

