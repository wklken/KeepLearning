#include <stdio.h>
/*
 * 数据类型
 *
 * 1个字节byte = 8位bit
 */

int main()
{

    // int类型 - 基本
    int intvar;
    intvar = 0;

    int intvar1 = 1;

    int intvar2 = 2, intvar3 = 3;

    printf("%d\n", intvar);

    // short <= int <= long < long long
    // 目前一般情况
    // short(16bit) <= int(16/32bit) <= long(32bit) < long long(64bit)

    // int类型 -更多(short/long/unsigned修饰)
    // short, 可能占用比int类型更少的存储空间, 用于仅需小数值的场合
    short int sint;  //这几个等价
    short sint2;
    signed short int sint1; // signed关键字可忽略, 只是用来使数据类型更加明确

    // long, 可能占用比int类型更多的存储空间, 用于使用大数值的场合
    long int lint; // 这两个等价
    long lint1;

    // long long, C99引入, 可能占用比long更多的存储空间, 用于更大数值的场合
    long long int llint; // 这两个等价
    long long llint1;

    // unsigned, 无符号, 使用非负值的场合, 比有符号数有更大的范围
    unsigned int uint = 100000000;

    // e.g. 16位unsigned int, pow(2,16) -> (0, 65535)
    //      而 int -> (-32768, 32767)
    // 注意: 整数太大超出范围会溢出, 回到起始点, 编程时必须自己处理这个问题
    // 打印: unsigned int -> %u
    //       short -> %hd
    //       long -> %ld  %lx十六进制格式 %lo八进制格式
    //       long long -> %lld


    //======================================================================

    // char类型 - 用于存储字符, 技术上是整数类型 1char = 1byte = 8bit
    char c;
    c = 'A';

    char grade = 'B';
    char grade1 = 66; //等价, 但不建议使用这种形式

    printf("%c\n", c);

    // 注意关注可移植类型inttypes.h

    //======================================================================

    // 浮点数类型
    // float < double < long double
    // float 至少能表示6位有效数字, 通常32位存储, 8位指数及符号, 24位非指数及符号
    float fvar;
    fvar = 6.63e-5;

    float fvar1 = 32000.0;

    // double 范围更大的浮点数, 通常64位存储
    double dvar;
    long double ldvar;
    printf("%f %e\n", fvar, fvar);

    return 0;
}
