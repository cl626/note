%{
#include <stdlib.h>
#include <stdio.h>


#define NUM  259

#define Endinput 0

int lookhead;

int lexval;

int syntax_error = 0;

/*  any C declaration  */
%}

digit     [0-9]

number   {digit}+



%%
[ \t]+      {/*do nothing , just skip */}

{number}    {   
                lexval = atoi( yytext );
		return NUM;
             
            }

.|\n        { return yytext[0];}

%%

/********************************************************
  This is a Demo for Attributed Grammar with Top-Down analyzing & translating,

    The base attributed grammar is as follow:
     
       Lines-> '\n'
            |  E { print( E.val ) }'\n'  Lines
    
       E ->  E1 + T { E.val := E1.val + T.val }
           | E1 - T { E.val := E1.val - T.val }
           | T      { E.val := T.val }
           ;
           
       T ->  T1 * F { T.val := T1.val * T.val }
           | T1 / F { T.val := T1.val / T.val }
           | F      { T.val := F.val }
           ;    
      
       F -> num  { F.val := num.lex_val }
          | ( E ) { F.val := E.val }
          ;
          
 
   Note that, the above grammar has left-recursive productions which cannot be parsed with a top-down parser.
   
   So we have to rewrite those productions, eliminating their left-recursive, introduing some new symbols which 
   
   has a synthesized and a inherited attribute. The grammar then looks like this:
  
      Lines-> '\n'
            |  E { print( E.val ) } '\n' Lines 
   
      E -> T { U.i := T.val } 
           U { E.val := U.s }
           ;
           
      U -> + 
           T { U1.i := U.i + T.val } 
           U1 { U.s := U1.s }
           
         | -
           T { U1.i := U.i - T.val }
           U1 { U.s := U1.s }
         |  { U.s := U.i }
         ;
         
      T -> F { V.i := F.val }
           V { T.val := V.s }
           ;
           
      V -> * 
           F { V1.i := V.i * F.val }
           V1 { V.s := V1.s }
           
         | /
           F { V1.i := V.i / F.val }
           V1 { V.s := V1.s }
         | { V.s := V.i }
         ;
         
      F -> num  { F.val := num.lex_val }
         | ( E ) { F.val := E.val }
         ;

**********************************************/                  

void Lines();

int E();

int U(int U_i);

int T();

int V(int V_i);

int F();

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

/*************************************************
       Lines-> '\n'
            |  E { print(E.val) } '\n'  Lines 
**************************************************/            

         int E_val ; //synthesized attribute of Symbol E

	  if ( lookhead==Endinput ) {printf("\n\nFinished!!!\n");return;}
	  while ( lookhead =='\n' ) { lookhead=next_token();} /* skip empty input line */
	  
	  E_val = E();  
	  
	  if ( syntax_error ) skip(); 
          else printf("the value of the expression is %d\n", E_val);
	  
     	  match('\n'); 
	 	     	  
     	  Lines(); // infinite loop, untill press ctrl-D 
}	

int E()
{  
/***************************************************
      E -> T { U.i := T.val } 
           U { E.val := U.s }
           ;
 **************************************************/
 
    int T_val, U_i, U_s, E_val = -11111;
 
    if ( syntax_error ) return E_val; // if error, return directly with -11111	
    
    if ( (lookhead=='(' ) || 
       (lookhead==NUM )) {
      T_val = T();
      U_i = T_val;
      U_s = U(U_i);
      E_val =  U_s;
    } else error("\n expression needs ( or NUM \n");  
    
    return E_val; 
}

int U( int U_i )
{   
/******************************************************
      U -> + 
           T { U1.i := U.i + T.val } 
           U1 { U.s := U1.s }
           
         | -
           T { U1.i := U.i - T.val }
           U1 { U.s := U1.s }
         |  { U.s := U.i }
         ;
******************************************************/      
    int T_val, U1_i, U1_s, U_s = -11111;

    if ( syntax_error ) return U_s; // if error, return directly with -11111 
   
    if (lookhead=='+') {
      match('+'); 
      T_val = T();
      U1_i = U_i + T_val;
      U1_s = U( U1_i );
      U_s = U1_s; 
    } 
    else if ( lookhead == '-' ) {
      	  match('-'); 
      	  T_val = T();
      	  U1_i = U_i - T_val;
      	  U1_s = U( U1_i );
      	  U_s = U1_s;
    } 
    else if ( (lookhead=='\n' ) ||  (lookhead==')' )) { U_s = U_i; }
    else error("\n expression needs + or - \n"); 
   
    return U_s ;
}

int T()
{   
/******************************************************      
      
      T -> F { V.i := F.val }
           V { T.val := V.s }
           ;
*******************************************************/
    int F_val, V_i, V_s, T_val = -11111;
    
    if ( syntax_error ) return T_val; // if error, return directly with -11111 
    
    if ((lookhead=='(' ) || 
       (lookhead==NUM )) {
      F_val = F();
      V_i = F_val;
      V_s = V( V_i );
      T_val = V_s; 
    } else error("\n Expression needs ( or NUM \n");
    
    return T_val;
      
}

int V( int V_i )
{  
/******************************************************
      V -> * 
           F { V1.i := V.i * F.val }
           V1 { V.s := V1.s }
           
         | /
           F { V1.i := V.i / F.val }
           V1 { V.s := V1.s }
         | { V.s := V.i }
         ;
********************************************************/
    int F_val, V1_i, V1_s, V_s = -11111;

    if ( syntax_error ) return V_s; // if error, return directly with -11111
    
    if (lookhead=='*') {
      match('*'); 
      F_val = F();
      V1_i = V_i * F_val;
      V1_s = V( V1_i );
      V_s = V1_s; 
    } 
    else if( lookhead == '/' ){
      match('/'); 
      F_val = F();
      V1_i = V_i / F_val;
      V1_s = V( V1_i );
      V_s = V1_s;
    }
    else if ( (lookhead=='+' ) || (lookhead=='\n') || 
         (lookhead==')')  || (lookhead=='-') ) { V_s = V_i; }
    else error("\n expression needs * \n"); 
    
    return V_s;
    
}


int F()
{
/******************************************************
      F -> num  { F.val := num.lex_val }
         | ( E ) { F.val := E.val }
         ;
******************************************************/         

    int num_lex_val, E_val, F_val = -11111; 
    
    if ( syntax_error ) return F_val ; // if error, return directly with -11111
    
    if (lookhead=='(' ) {
       match( '(' ); 
       E_val = E(); 
       match( ')' );
       F_val = E_val;
    } 
    else if (lookhead==NUM) {
          num_lex_val = lexval; //NUM is a terminal with numeric value
          match( NUM ); 
          F_val = num_lex_val; 
       }
       else error("\n expression needs ( or NUM \n");  
       
       return F_val;
       
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
