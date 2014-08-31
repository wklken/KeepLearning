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

    // 指针的6种操作
    // 1. 赋值
    int urn[5] = {100, 200, 300, 400, 500};

    int * ptr1, *ptr2, * ptr3;

    ptr1 = urn;
    ptr2 = &urn[2];

    printf("prt1 = %p, *ptr = %d, &ptr1 = %p\n", ptr1, *ptr1, &ptr1);

    // 2. 加法 +n   则地址实际上 +sizeof(element)*n    减法同
    ptr3 = ptr1 + 4;
    printf("ptr1+4 = %p, *(ptr1+4) = %d\n", ptr3, *ptr3); //500

    // 3. 自增
    ptr1++;
    printf("prt1++ = %p, *(ptr1++) = %d\n", ptr1, *ptr1);


    ptr1--;

    // 指针相减, 得到元素之间的距离n 代表n个int的大小
    int count = ptr3 - ptr1;
    printf("count = %d\n", count);

    return 0;
}


// 参数中表示传递指针
void exchange(int *u, int * v) {
    int temp;

    temp = *u;
    *u = *v;
    *v = temp;
}
