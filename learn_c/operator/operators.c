#include <stdio.h>

/*
 *
 * 运算符优先级
 * ()
 * - + ++ -- sizeof    一元运算
 * * / %
 * + -
 * < > <= >=
 * == !=
 * =
 */

int main(void)
{

    // = 赋值运算
    int a = 1;

    // + - * /
    int b = 1 + 1;
    int c = 100 - 20;
    int d = 2 * 3;
    float e = 12.0 / 3.0;

    printf("%d %d %d %d %f\n", a, b, c, d, e);

    // 优先级  ()  +-(一元)  */  +-(二元) =
    int f, g;
    f = g = 20; //右到左的结合
    printf("%d %d\n", f, g);

    // sizeof 以字节为单位返回其操作数的大小
    // 返回类型值 size_t, 无符号整数 typedef unsigned int size_t; or unsigned long int
    printf("%lu\n", sizeof(a));

    // 求模
    int result = 105 % 10;
    printf("%d\n", result);

    // ++ / --  注意当一个变量多次出现在参数里或者同一个表达式里, 不要用++/--
    int v1 = 1;
    int v2 = 1;
    int v3 = ++v1;
    int v4 = v2++; //先赋值, 再++
    printf("%d %d %d %d\n", v1, v2, v3, v4);

    // (type)类型转换
    // 规则
    // 1. 当出现在表达式里, 有符号和无符号char/short自动转为int, float -> double
    // 2. 包含两种数据类型的任何运算里, 两个值都被转成类型中较高级别的类型
    // 3. 级别 int < unsigned int < long < unsigned long < long long < unsigned long long < float < double < long double
    // 4. 赋值语句, 会转成被赋值变量的类型, 可能提升或降级

    int ivar = 1.7;
    int ivar2 = (int)1.7;
    printf("%d %d\n", ivar, ivar2);

    return 0;
}
