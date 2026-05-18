#include <stdio.h>
#include <netdb.h>
#include <arpa/inet.h>

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Provide name as argument!\n");
        return 1;
    }

    char *name = argv[1];

    struct hostent *host;

    host = gethostbyname(name);

    if (host == NULL) {
        herror("gethostbyname");
        return 1;
    }

    printf("Official name: %s\n", host->h_name);

    char **addr = host->h_addr_list;

    while (*addr != NULL) {
        struct in_addr ip;

        ip.s_addr = *(in_addr_t *)(*addr);

        printf("IP: %s\n", inet_ntoa(ip));

        addr++;
    }

    return 0;
}
