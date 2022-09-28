%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>

%}


%%
Start : N  L {printf("\n\n");}
      ;
N     : {$$ = 0;/*initially, nested level is 0.*/}
      ;
L : S
  | L ',' M  S
  ;
M : {$$ = ($-2);}
  ;
S : '(' K L ')' 
  | 'a' {printf(" a @level %d \n", ($0));}
K : {$$ = ($-1) + 1;}
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
