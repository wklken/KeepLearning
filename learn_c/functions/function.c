#include <stdio.h>

void hello(void);

void print_number(int n);

int power(int n, int p);

int main(void)
{
    hello();

    print_number(5);

    int  p = power(2, 3);
    printf("power(2,3) = %d\n", p);

    // 函数与数组

    return 0;
}

void hello(void)
{
    printf("hello\n");
}

void print_number(int n)
{
    printf("n = %d\n", n);
}

int power(int n, int p)
{
    int pow = 1;
    int i;
    for(i = 1; i <=p; i++)
    {
        pow *= n;
    }

    return pow;
}
