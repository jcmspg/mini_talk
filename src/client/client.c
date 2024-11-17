/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joao <joao@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/17 17:03:02 by joao              #+#    #+#             */
/*   Updated: 2024/11/17 21:06:18 by joao             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "../mini_talk.h"

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



