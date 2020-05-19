//
//  main.m
//  01_单向链表
//
//  Created by zj on 2020/5/18.
//  Copyright © 2020 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// 单向链表结构
typedef struct node {
    char *data;
    struct node *next;
} node_t;

// 打印链表
void list_display(node_t *head) {
    for (; head; head = head->next)
        printf("%s", head->data);
    printf("\n");
}

// 删除某个节点
void deleteNode(node_t *node) {
    node->data = node->next->data;
    node->next = node->next->next;
}

// 反转链表--递归
node_t* reverseList(node_t *head) {
    if (head == NULL || head->next == NULL) return head;
    
    node_t *newNode = reverseList(head->next);
    head->next->next = head;
    head->next = NULL;
    return newNode;
}

// 反转链表--while
node_t* reverseTwoList(node_t *head) {
    if (head == NULL || head->next == NULL) return head;
    
    node_t *newHead = NULL;
    while (head != NULL) {
        node_t *temp = head->next;
        head->next = newHead;
        newHead = head;
        head = temp;
    }
    return newHead;
}

// 判断链表是否有环，快慢指针
BOOL hasCycle(node_t *head) {
    if (head == NULL || head->next == NULL) return head;
    
    node_t *slow = head;
    node_t *fast = head->next;
    
    while (fast != NULL && fast->next != NULL) {
        if (fast == slow) return true;
        slow = slow->next;
        fast = fast->next->next;
    }
    return false;
}


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//
        node_t d = {"d", 0}, c = {"c", &d}, b = {"b", &c}, a = {"a", &b};
//        d.next = &a;
//        deleteNode(&c);
        
//        list_display(&a);
//        node_t *newNode = reverseList(&a);
//        list_display(newNode);
        
        
//        node_t *newNodeTwo = reverseTwoList(&a);
//        list_display(newNodeTwo);
        
//        NSLog(@"%d",hasCycle(&a));
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
