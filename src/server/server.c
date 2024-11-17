/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joamiran <joamiran@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/17 17:25:36 by joao              #+#    #+#             */
/*   Updated: 2024/11/17 21:00:53 by joao             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../mini_talk.h"

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
