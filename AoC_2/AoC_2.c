#include <stdio.h>
#include <stdlib.h>

#define A 65
#define B 66
#define C 67
#define X 88
#define Y 89
#define Z 90

char fight[3][3] = {0};
char winAgainst[3] = {0};
char drawAgainst[3] = {0};
char looseAgainst[3] = {0};

int calculate_line_score(char enemy, char you)
{
    int score = 0;
    score += (you == X) ? 1 : (you == Y) ? 2
                          : (you == Z)   ? 3
                                         : 0;
    score += fight[enemy - A][you - X];

    return score;
}

char determine_new_move(char enemy, char move)
{
    return move == X ? looseAgainst[enemy - A] : move == Y ? drawAgainst[enemy - A]
                                             : move == Z   ? winAgainst[enemy - A]
                                                           : 0;
}

int main(void)
{
    FILE *fp;
    char *line;
    size_t len = 0;
    ssize_t read;
    int total1, total2 = 0;

    fight[A - A][X - X] = 3;
    fight[A - A][Y - X] = 6;
    fight[A - A][Z - X] = 0;
    fight[B - A][X - X] = 0;
    fight[B - A][Y - X] = 3;
    fight[B - A][Z - X] = 6;
    fight[C - A][X - X] = 6;
    fight[C - A][Y - X] = 0;
    fight[C - A][Z - X] = 3;
    winAgainst[A - A] = Y;
    winAgainst[B - A] = Z;
    winAgainst[C - A] = X;
    drawAgainst[A - A] = X;
    drawAgainst[B - A] = Y;
    drawAgainst[C - A] = Z;
    looseAgainst[A - A] = Z;
    looseAgainst[B - A] = X;
    looseAgainst[C - A] = Y;

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
