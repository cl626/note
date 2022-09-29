%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
%}

%%

S    : L { printf(" the value is %d\n", $1);}
     ;
L    : L  B {$$ = $1 * 2 + $2;}
     | B     
     ;
B    : '0' {$$ = 0;}
     | '1' {$$ = 1;}
     ;
%%

int yylex()
{
   int c;
   while ( ( c=getchar() ) == ' ' ) ;
   if ( c=='\n' ) return 0; // return EOF -- $
   return c;
}

int main()
{
   return yyparse();
}

void yyerror(char *s)
{
   printf("%s\n", s ); 
}

int yywrap()
{ return 1; }        		    
