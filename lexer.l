%x COMMENT_MULTI_LINE INSIDE

%{
    #include "parser.tab.h"

    void yyerror(char const *s) {
      fprintf(stderr, "line %d: %s\n", yylineno, s);
    }
    extern char* yytext;
    // extern int line_number
%}
%option noyywrap    

%%

<INITIAL>"/*".              {BEGIN(INSIDE);}
<COMMENT_MULTI_LINE>"*/"    {BEGIN(INITIAL);}
<INTIAL><<EOF>>             {
                              yyerror("UNTERMINATED COMMENT!");
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
"<"                         return LESS_THAN;
"<="                        return LESS_OR_EQUAL;                     
">"                         return GREATER_THAN;
">="                        return GREATER_OR_EQUAL;
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
[\n]                        ;
.                           yyerror("Error in Syntax!");


