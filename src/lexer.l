%x COMMENT_MULTI 

%{
    #include "parser.tab.h"

    int yyerror(char const *s) {
      fprintf(stderr, "line %d: %s\n", yylineno, s);
      return 0;
    }

    extern int line_number;  
    extern char* yytext;
%}
%option noyywrap    

%%

<INITIAL>"/*"               {BEGIN(COMMENT_MULTI);}
<COMMENT_MULTI>"*/"         {BEGIN(INITIAL);}
<COMMENT_MULTI>.            ;
<COMMENT_MULTI>\n           ;
<COMMENT_MULTI><<EOF>>      {
                              printf("UNTERMINATED COMMENT AT line %d!\n", line_number);
                              yyterminate();
                            }
"if"                        return IF;
"else"                      return ELSE;
"int"                       return INT;
"return"                    return RETURN;
"void"                      return VOID;
"while"                     return WHILE;
"+"                         return PLUS;
"-"                         return MINUS;
"*"                         return MULTIPLY;
"/"                         return DIVIDE;
"<="                        return LESS_OR_EQUAL;
"<"                         return LESS_THAN;                     
">="                        return GREATER_OR_EQUAL;
">"                         return GREATER_THAN;
"=="                        return EQUALS;
"!="                        return NOT_EQUALS;
"="                         return ASSIGNMENT;
";"                         return EOL;
","                         return COMMA;
"{"                         return LEFT_PARANTHESIS;
"}"                         return RIGHT_PARANTHESIS;
"("                         return LEFT_BRACKET;
")"                         return RIGHT_BRACKET;
"["                         return LEFT_SQR_BRACKET;
"]"                         return RIGHT_SQR_BRACKET;
[a-zA-Z][a-zA-Z]*           return ID;
[0-9][0-9]*                 return NUM;
[ \t\r]+                    ;
[\n]                        {line_number++;}
[a-zA-Z0-9]+                yyerror("Identifier must consist only alphabetical characters!");
.                           yyerror("Error in Syntax!");


