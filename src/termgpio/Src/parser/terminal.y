%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str)
{
	fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
	return 1;
}

main()
{
    char input[40] = "heat on\ntarget temperature 30\n";

    /*Copy string into new buffer and Switch buffers*/
    yy_scan_string (input);
    yyparse();
}

char *heater="default";

%}

%token TOKHEATER TOKHEAT TOKTARGET TOKTEMPERATURE

%union 
{
	int number;
	char *string;
}

%token <number> STATE
%token <number> NUMBER
%token <string> WORD

%%

commands:
	| commands command
	;


command:
	heat_switch | target_set | heater_select

heat_switch:
	TOKHEAT STATE 
	{
		if($2)
			printf("\tHeater '%s' turned on\n", heater);
		else
			printf("\tHeat '%s' turned off\n", heater);
	}
	;

target_set:
	TOKTARGET TOKTEMPERATURE NUMBER
	{
		printf("\tHeater '%s' temperature set to %d\n",heater, $3);
	}
	;

heater_select:
	TOKHEATER WORD
	{
		printf("\tSelected heater '%s'\n",$2);
		heater=$2;
	}
	;
