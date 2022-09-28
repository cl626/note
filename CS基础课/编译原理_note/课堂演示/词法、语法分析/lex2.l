%{
#include <stdlib.h>
#include <stdio.h>

/*  any C declaration  */
%}

string   (0|1)*01

%%

{string}    { 
	      printf("OK!  %s\n", yytext);
	     /* any C statement */
            }
.|\n        {}

%%

main()
{   yylex();
    return 0;
}
int yywrap()
{ return 1; }
