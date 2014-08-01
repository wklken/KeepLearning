#include <stdio.h>

//  指针, pointer, 用来存储地址的变量
//  指针是一个其数值位地址的变量

void exchange(int * u, int * v);

int main(void)
{
    // & 取地址运算符, 后跟一个变量名, 给出变量名的地址
    int pooh = 24;
    printf("%d %p\n", pooh, &pooh);

    // 声明指针
    int *ptr;
    ptr = &pooh;

    printf("%p\n", ptr);

    // * 间接运算符, 后跟一个指针名或地址, 给出存储在被指向地址中的数值
    printf("%d\n", *ptr);


    // 指针声明
    int * pi;
    char * pc;
    float * pf, * pg;

    int x = 5;
    int y = 6;
    exchange(&x, &y);

    printf("after exchange: x=%d y=%d\n", x, y);

    return 0;
}


// 参数中表示传递指针
void exchange(int *u, int * v) {
    int temp;

    temp = *u;
    *u = *v;
    *v = temp;
}
