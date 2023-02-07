/* Trabalho extra de Compiladores - Edson */
/* Integrante: Josué Teixeira Santana - 202029012 */

%{
#include <ctype.h>
#include <string.h>
int tri_count = 0, dit_count = 0, word_count = 0;
const char *VOWELS = "aeiouAEIOU";
%}

%%
[[:blank:]]|\n     {}
[[:alpha:]]+ {
    word_count++;
    int i;
    int len = strlen(yytext);
    int tri_counted = 0;
    int dit_counted = 0;
    for (i = 0; i < len - 2; i++) {
        if (strchr(VOWELS, yytext[i]) && strchr(VOWELS, yytext[i + 1]) && strchr(VOWELS, yytext[i + 2])) {
            tri_count++;
            tri_counted = 1;
        }
    }
    if (!tri_counted) {
        for (i = 0; i < len - 1; i++) {
            if (strchr(VOWELS, yytext[i]) && strchr(VOWELS, yytext[i + 1])) {
                dit_count++;
                dit_counted = 1;
            }
        }
    }
}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    printf("%d %d %d\n", tri_count, dit_count, word_count);
    return 0;
}
