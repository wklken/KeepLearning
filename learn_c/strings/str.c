#include <stdio.h>
#include <string.h>
/*
 * 字符串
 */

// 预定义常量
#define N "for test"
#define TEE 'T'

int main(void)
{
    // 直接声明
    char name[] = "hello";
    printf("name: %s\n", name);


    // 长度
    printf("len: %ld\n", strlen(name)); //5

    // 最后一个位置 \0, 空字符
    printf("last char %c\n", name[5]);

    // sizeof   40, byte
    printf("sizeof %d\n", sizeof(name));


    //====================================
    // 字符串函数

    // 1 操作


    // 2 字符检查


    // 3 类型转换
    // 其他类型 -> 字符串
    // 转换 -> 其他类型

    return 0;
}
