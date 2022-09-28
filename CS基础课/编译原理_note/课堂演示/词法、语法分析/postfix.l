%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define ID   258
#define NUM  259
#define Endinput 0

char lexval[128];

int lookhead;
int syntax_error = 0;

/*  any C declaration  */
%}

letter    [a-zA-Z]

digit     [0-9]

number   {digit}+

id       {letter}({letter}|{digit})*

%%
[ \t]+      {/*do nothing , just skip */}
{number}|{id}    {  strcpy(lexval,yytext);
               return ID; 
            }
.|\n        { return yytext[0];}

%%

/*  Production(s) Set

  Lines-> '\n'

  Lines-> E '\n' Lines

  E-> T  E'

  E'-> + T  E'  |   //empty production
     | - T  E'
  T-> F  T'

  T'-> * F  T'  |   //empty production
     | / F  T'
  F-> ( E )

  F-> id

*/

void Lines();
void E();
void E_();
void T();
void T_();
void F();

int next_token()
{
      return yylex();
}


/*
when one error occurs, we do skip some inputs and set a error flag so that
all expression procedures can return at once just like they "have finished"
analyzing input 
*/


void error(char * msg)
{
	syntax_error = 1; // set error flag
	printf(msg);
}

void match( int t )
{    
     if ( syntax_error ) return ;
     if ( lookhead == t ) { 
	  //终结符叶子和输入符是否匹配（相同）
          lookhead = next_token(); 
     //若匹配则获取下一记号，即向前移动输入指针
	  } else error("\ninvalid input\n");  /* 否则，语法错误*/
}

void skip()
{
	while ( lookhead != '\n' )  lookhead=next_token();
	syntax_error = 0 ; // clear error flag
	/* pass all input untill '\n' */
}	

void Lines()
{
	  if ( lookhead==Endinput ) {printf("\n\nFinished!!!\n");return;}
	  while ( lookhead =='\n' ) { lookhead=next_token();}
	  /* skip empty input line */
	  E();  
	  if ( syntax_error ) skip();
	  else printf("\nOK\n");
     	  match('\n');
     	  Lines(); // infinite loop, untill press ctrl-D 
}	

void E()
{   
    if ( syntax_error ) return ;	
    if ( (lookhead=='(' ) || 
       (lookhead==ID)) {
      T();
      E_(); 
    } else error("\n E needs ( or ID or NUM \n");  
}

void E_ ()
{   if ( syntax_error ) return ;
    if (lookhead=='+') {
      match('+'); T();printf("+ ");  E_(); 
    } else if ( lookhead == '-' ) {
      match('-'); T(); printf("- ");E_();
    } 
    else if ( (lookhead=='\n' ) ||  (lookhead==')' )) { return; }
   else error("\n E_ needs + \n"); 
}
void T()
{   if ( syntax_error ) return ;
    if ((lookhead=='(' ) || 
       (lookhead==ID )) {
      F();
      T_(); 
    } else error("\n T needs ( or ID or NUM \n");  
}
void T_ ()
{   if ( syntax_error ) return ;
    if (lookhead=='*') {
      match('*'); F();printf("* ");  T_(); 
    } else if( lookhead == '/' ){
      match('/'); F(); printf("/ ");  T_();
    }
     else 
    if ( (lookhead=='+' ) || (lookhead=='\n') || 
         (lookhead==')')  || (lookhead=='-') ) { return; }
   else error("\n T_ needs * \n"); 
}
void F()
{   if ( syntax_error ) return ;
    if (lookhead=='(' ) {
       match( '(' ); E(); match( ')' );
    } else if (lookhead==ID) {
          match( ID );
          printf("%s ",lexval);
       }
       else error("\n F needs ( or ID or NUM \n");  
}

int main()
{
	printf("\n press Ctrl-D to exit\n");
	lookhead = next_token();
	Lines();
	return 0;
}
int yywrap()
{ return 1;}
