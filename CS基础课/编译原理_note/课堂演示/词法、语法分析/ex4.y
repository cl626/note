%{
   /* definition */
   #include <stdio.h>
   #include <ctype.h>
%}

%token	number

%%

Line : Expr  { printf(" \n\n the postfix expresssion output!\n");}
     ;

Expr : Expr '+' Term { printf (" + "); } 
     | Expr '-' Term { printf (" - "); }
     | Term 
     ;

Term : Term '*' Factor { printf (" * ");  }  
     | Term '/' Factor { 
     			 printf (" / "); ; 
     		       }
     | Factor 
     ;
     
Factor : '(' Expr ')' 
       | number { printf (" %d ", $1); }
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
