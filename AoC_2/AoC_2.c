#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define A 65
#define B 66
#define C 67
#define X 88
#define Y 89
#define Z 90

char winAgainst(char val)
{
    return val == A ? Y : val == B ? Z
                      : val == C   ? X
                                   : 0;
}

char drawAgainst(char val)
{
    return val == A ? X : val == B ? Y
                      : val == C   ? Z
                                   : 0;
}

char looseAgainst(char val)
{
    return val == A ? Z : val == B ? X
                      : val == C   ? Y
                                   : 0;
}

int calculate_line_score(char enemy, char you)
{
    int score = 0;

    if (you == X)
    {
        score += 1;
        score += ((you - enemy) == (X - A)) ? 3 : ((you - enemy) == (X - B)) ? 0
                                              : ((you - enemy) == (X - C))   ? 6
                                                                             : 0;
    }
    else if (you == Y)
    {
        score += 2;
        score += ((you - enemy) == (Y - A)) ? 6 : ((you - enemy) == (Y - B)) ? 3
                                              : ((you - enemy) == (Y - C))   ? 0
                                                                             : 0;
    }
    else if (you == Z)
    {
        score += 3;
        score += ((you - enemy) == (Z - A)) ? 0 : ((you - enemy) == (Z - B)) ? 6
                                              : ((you - enemy) == (Z - C))   ? 3
                                                                             : 0;
    }

    return score;
}

char determine_new_move(char enemy, char move)
{
    return move == X ? looseAgainst(enemy) : move == Y ? drawAgainst(enemy)
                                         : move == Z   ? winAgainst(enemy)
                                                       : 0;
}

int main(void)
{
    FILE *fp;
    char *line;
    size_t len = 0;
    ssize_t read;
    int total1, total2 = 0;

    fp = fopen("./input", "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    while ((read = getline(&line, &len, fp)) != -1)
    {
        total1 += calculate_line_score(line[0], line[2]);
        total2 += calculate_line_score(line[0], determine_new_move(line[0], line[2]));
    }

    printf("Score total_1: %d -- Score total_2: %d\n", total1, total2);

    fclose(fp);
    if (line)
        free(line);
    exit(EXIT_SUCCESS);
}
