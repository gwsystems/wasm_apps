#include <stdio.h>
#include <stdlib.h>

#define HTML_START                    \
	"<html>"                      \
	"   <body>"                   \
	"       <h1>Hello World</h1>" \
	"       <h2>Arguments:</h2>"  \
	"       <ul>"

#define HTML_END     \
	"   </ul>"   \
	"   </body>" \
	"</html>"    \
	""

int
main(int argc, char **argv)
{
	printf(HTML_START);
	for (int i = 0; i < argc; i++) { printf("<li>%d: %s</li>", i, argv[i]); }
	printf(HTML_END);
	exit(EXIT_SUCCESS);
}
