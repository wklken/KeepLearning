// 简单列表类型

#ifndef LIST_H_
#define LIST_H_
#include <stdbool.h>

#define TSIZE 45 //存放片名的数组大小

struct film
{
    char title[TSIZE];
    int rating;
};

typedef struct film Item;

typedef struct node
{
    Item item;
    struct node * next;
} Node;


// List是Node指针
typedef Node * List;

void InitializeList(List * plist);

bool ListIsEmpty(const List * plist);

bool ListIsFull(const List * plist);

unsigned int ListItemCount(const List * plist);

bool AddItem(Item item, List * plist);

// 把一个函数作用域每个元素
void Traverse(const List * plist, void (* pfun)(Item item));

void EmptyTheList(List * plist);

#endif


