#include <stdio.h>

int main(void)
{
    // while 循环

    // 计数循环
    // < <= == > >= !=
    int n = 5;
    while(n < 7)
    {
        printf("n = %d\n", n);
        n++;
    }

    printf("loop finished\n");

    // 无限循环
    /*while(1) { }*/


    // 一个真表达式的值为1 一个假表达式的值为0
    // 放得很宽, 0为假, 非0为真
    // 注意: while(a=0) 不会进入循环   while(a=1) 无限循环等价while(1)

    int a;
    while(a=0)
    {
        printf("assignment of a\n"); //不会看到
    }


    // for 循环
    // for(init; test; update) 其中init/update可以使用逗号表达式
    int  count;
    for(count = 1; count < 10; count++)
    {
        printf("count = %d\n", count);
    }

    // 无限循环
     /*for(;;) { }*/




    // do-while循环
    int b = 1;
    do{
        printf("b = %d\n", b);
        b++;
    } while(b < 2);

    return 0;
}
