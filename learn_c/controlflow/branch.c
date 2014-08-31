#include <stdio.h>

/*
 * 分支处理
 *
 */

int main(void)
{

    // if else
    int a = 1;
    if (a == 1) {
        printf("a == 1\n");
    } else {
        printf("a != 1\n");
    }

    // && || !
    if (a==1 && 1) {
        printf("a == 1 and 1\n");
    }

    if (!(a != 1))
    {
        printf("not a != 1\n");
    }

    // 三元运算
    int x = (a == 1) ? 100 : 200;
    printf("x = %d\n", x);


    char ch = 'B';
    // switch
    switch (ch) {
        case 'A':
            printf("A\n");
            break;
        case 'B':
            printf("B\n");
        case 'C':
            printf("C\n");
            break;
        default:
            printf("Not match\n");
    }

    // break/continue/goto

    return 0;
}
