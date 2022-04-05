#include <stdio.h>
#include <stdlib.h>

#define HTML                      \
    "<html>"                      \
    "   <body>"                   \
    "       <h1>Hello World</h1>" \
    "   </body>"                  \
    "</html>"                     \
    ""

int main(void) {
    printf(HTML);
    exit(EXIT_SUCCESS);
}
