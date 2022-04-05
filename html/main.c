#include <stdio.h>
#include <stdlib.h>

#define STDIN_FILENO  0 /* Standard input.  */
#define STDOUT_FILENO 1 /* Standard output.  */
#define STDERR_FILENO 2 /* Standard error output.  */

#define HTML_START  \
	"<html>"    \
	"   <body>" \
	"       <h1>Hello World</h1>"

#define ARGUMENTS_END \
	"   </ul>"    \
	""

#define HTML_END     \
	"   </body>" \
	"</html>"    \
	""

int
main(int argc, char **argv)
{
	char   stdin_buffer[512];
	size_t stdin_buffer_len = 0;

	printf(HTML_START);
	printf("<h2>Arguments:</h2>");
	printf("<ul>");
	for (int i = 0; i < argc; i++) { printf("<li>%d: %s</li>", i, argv[i]); }
	printf("</ul>");
	printf("<h2>STDIN:</h2>");
	printf("<p>");
	fflush(stdout);
	while ((stdin_buffer_len = read(STDIN_FILENO, &stdin_buffer, 512)) > 0) {
		write(STDOUT_FILENO, &stdin_buffer, stdin_buffer_len);
	};
	printf("</p>");
	printf(HTML_END);
	exit(EXIT_SUCCESS);
}
