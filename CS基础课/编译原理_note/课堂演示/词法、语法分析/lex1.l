%{
#include <stdlib.h>
#include <stdio.h>

int int_count = 0;
int float_count = 0;
int int_sum = 0;
double float_sum = 0.0;
/* Any C declaration */
%}

digit     [0-9]
number   {digit}+
fnum     ({number}"."{number}?)|({number}?"."{number})
%%
{number}    { int n = atoi(yytext);
              int_sum += n;
              int_count++;
            }
{fnum}      { 
              double d = atof( yytext );
              float_sum += d;
              float_count++;
            }
.|\n       {}


%%
main()
{
    printf("\n\n Press Ctrl-D to end input \n\n");
    yylex();
    printf("\n Total INTs : %d , SUM = %d \n", int_count, int_sum );
    printf("\n Total Floats:  %d , SUM = %lf \n\n", float_count, float_sum);
    return 0;
}
int yywrap()
{ return 1; }
