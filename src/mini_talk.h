/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mini_talk.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joao <joao@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/17 17:06:44 by joao              #+#    #+#             */
/*   Updated: 2024/11/17 21:04:55 by joao             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# ifndef MINI_TALK_H
# define MINI_TALK_H


# include "../inc/libft/libft.h"
# include "../inc/ft_printf/ft_printf.h"
# include <signal.h>
# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <sys/types.h>
# include <sys/wait.h>
# include <limits.h>
# include <fcntl.h>

# define MAX_PID 99999
# define MAX_MSG 99999


// client
void smoke_signal(int pid, char *msg);

// server
void signal_handler(int signum);

#endif
