%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
%}

%token	number

%%

Line : Expr { printf(" the value is %d\n", $1);}
     ;

Expr : Expr '+' Term { $$ = $1 + $3; } 
     | Expr '-' Term { $$ = $1 - $3; }
     | Term
     ;

Term : Term '*' Factor { $$ = $1 * $3; }  
     | Term '/' Factor { if ( $3==0) {
     			   printf("divided by ZERO\n");
     			   exit(1);
     			 } else  $$ = $1 / $3; 
     		       }
     | Factor
     ;
     
Factor : '(' Expr ')' { $$ = $2; }
       | number
       ;

%%

int yylex()
{
   int c;
   while ( ( c=getchar() ) == ' ' ) ;
   if ( isdigit(c) ) {
   	ungetc( c, stdin );
   	scanf("%d", &yylval); // value for token
   	return number;
   }
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
