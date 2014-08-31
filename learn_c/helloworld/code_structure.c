#include <stdio.h> //包含另一个文件

// 单行注释

/* 多行注释
 *
 * 细节
 * 1. #include指示
 *    C预处理指令,
 *       #include <stdio.h> 作用相当于在文件开头位置放入了stdio.h的完整内容
 *
 * 2. .h 头文件
 *    包含了建立最终可执行程序时便以其需要用到的信息: 定义常量/函数声明
 *    用于指引编译器把程序正确地组合在一起
 *
 * 3. main函数
 *    一个C程序总是从main函数开始执行
 *
 * 4. 函数原型
 *    一种声明形式, 用于告诉编译器您正在用一个特殊的函数
 *    建议要给要用的所有函数提供函数原型
 */

void test(void); //函数原型

int main(void) //函数名
{
    int num; //声明语句
    num = 1; //赋值语句

    int foo, bar; //多个声明
    foo = bar = 1;

    printf("Hello world!\n"); //函数调用

    test(); //函数调用
    return 0; // 返回语句
}

// 函数具体定义的地方
void test(void)
{
    printf("Just test it!\n");
}
