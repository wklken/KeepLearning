#include <stdio.h>

// 数组作为参数时, 传递第一个位置的指针
void print_array(int * ar, int size);
// or     void print_array(int ar[], int size);
// or     void print_array(const int ar[], int size); //保护数组内容

int main(void)
{
    // 数组的位置, 在未初始化之前, 数值是不定的 , 
    int uninit[5];
    print_array(uninit, 5);

    // 初始化
    //全部
    int powers[8] = {1,2,3,4,5,6,7,8};
    print_array(powers, 8);

    // 部分, 剩余元素被初始化为类型默认值
    int arr[6] = {1, 2, [5]=212};
    print_array(arr, 6);

    //数组变量默认为第一个位置的地址(指针变量), 可以直接进行下标运算
    printf("%p %d\n", powers, *powers);
    printf("%d %d\n", powers[2], *(powers + 2)); //指针指向的值
    printf("%d %d\n", &powers[2], powers + 2); //指针地址


    // 多维数组
    int a[2][3] = { {1,2, 3}, {4, 5, 6}};

    return 0;
}

void print_array(int * ar, int size) {
    printf("print array\n");
    for(int index = 0 ; index < size; index ++) {
        printf("%d\n", ar[index]);
    }
}
