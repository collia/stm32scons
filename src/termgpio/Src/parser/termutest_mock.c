#include <stdio.h>
#include <string.h>
//#include "terminal.h"

#define TERM_MOCK_INPUT_BUFFER_SIZE 1024
#define TERM_MOCK_OUTPUT_BUFFER_SIZE 1024

static char input_buffer[TERM_MOCK_INPUT_BUFFER_SIZE] = {0};
static char output_buffer[TERM_MOCK_OUTPUT_BUFFER_SIZE] = {0};
static char* input_buffer_ptr = input_buffer;
static char* output_buffer_ptr = output_buffer;


char TERM_get_input_buf(char* buf, int max_size)
{
	int c = *input_buffer_ptr++;
	if((c == EOF) || (c == 0))
	{
		return 0;
	}
	else
	{
		buf[0] = c;
		return 1;
	}
}

void TERM_debug_print( const char *line)
{
    //int len = strlen(line);
	//printf("%s", line);
    strcpy(output_buffer_ptr, line);
    output_buffer_ptr += strlen(line);
}



void TERM_MOCK_init_input_buffer(const char* lines)
{
	strcpy(input_buffer, lines);
	input_buffer_ptr = input_buffer;
	output_buffer_ptr = output_buffer;
	printf("%s", input_buffer);
}


const char * TERM_MOCK_get_output_buffer()
{
    return output_buffer;
}