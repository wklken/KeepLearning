#include <stdio.h>

// 数组作为参数时, 传递第一个位置的指针
void print_array(int * ar, int size);
// or     void print_array(int ar[], int size);
// or     void print_array(const int ar[], int size); //保护数组内容

// int * a , 是指针, 存地址的


// 多维数组作为参数
void print_more(int (* pt)[2]);
// or     void print_more(int pt[][2]);

int main(void)
{
    // 数组的位置, 在未初始化之前, 数值是不定的!
    int uninit[5];
    uninit[2] = 1;
    print_array(uninit, 5);

    // 初始化
    //全部
    int powers[8] = {1,2,3,4,5,6,7,8};
    print_array(powers, 8);

    // 部分, 剩余元素被初始化为类型默认值
    int arr[6] = {1, 2, [5]=212};
    print_array(arr, 6);

    // 自动确认大小
    int autosize[] = {1, 2, 3};
    print_array(autosize, 3);

    //数组变量默认为第一个位置的地址(指针变量), 可以直接进行下标运算
    printf("%p %d\n", powers, *powers); // 地址, 值

    printf("%d %d\n", powers[2], *(powers + 2)); //指针指向的值
    printf("%d %d\n", &powers[2], powers + 2); //指针地址

    // 常量数组 const, 只读数组, 会把数组的每个元素当成常量来处理
    const int  days[7] = {1, 2, 3, 4, 5, 6, 7};

    // 计算大小sizeof
    int array_int[3] = {1, 2, 3};
    printf("sizeof(int[3]) = %lu, per size = %lu, count = %lu\n", sizeof(array_int), sizeof(array_int[0]), sizeof(array_int)/sizeof(array_int[0]));

    // 访问越界, 会得到错误的结果
    printf("error index array_int[3] = %d\n", array_int[3]);


    // 多维数组
    float rain[3][4];
    int a[2][3] = { {1,2, 3}, {4, 5, 6}};

    // 多维数组指针
    int b[2][3] = { {1,2, 3}, {4, 5, 6}};
    printf("b = %p, &b[0] = %p, &b[0][0] = %p\n", b, &b[0], &b[0][0]);
    printf("b+1 = %p, &b[1] = %p, &b[1][0] = %p\n", b+1, &b[1], &b[1][0]);


    // 指向多维数组的指针
    int (* pz)[2]; //指向一个包含两个int值的数组
    int zippo[4][2] = {(1,3), (5,7), (2,4), (6,8)};
    pz = zippo;

    int * pz[2]; // 两个指针组成的数组
    return 0;
}

void print_array(int * ar, int size) {
    printf("print array\n");
    for(int index = 0 ; index < size; index ++) {
        printf("%d\n", ar[index]);
    }
}
