%{
#include <stdlib.h>
#include <stdio.h>
#include "typex.h"
#include "y.tab.h"

extern Sym yylval;


/*  any C declaration  */
%}

digit     [0-9]

intnumber     {digit}+

floatnumber   {intnumber}"."{intnumber}



%%
[ \t]+      {/*do nothing , just skip */}
{intnumber}       {   
                yylval.TYPE = INT; // 1 for int  
                yylval.i = atoi( yytext ); // convert yytext to an integer value
	        return number;
	    }

{floatnumber}     { 
	        yylval.TYPE = FLOAT; // 0 for int  
	        yylval.d = atof( yytext );// convert yytext to a double value
	        return number;
             
	     /* any C statement */
            }

.|\n        { return yytext[0];}

%%

int yywrap()
{ return 1;}

