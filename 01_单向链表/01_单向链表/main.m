//
//  main.m
//  01_单向链表
//
//  Created by zj on 2020/5/18.
//  Copyright © 2020 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//typedef struct node {
//    char *data;
//    struct node *next;
//} node_t;
//
//void list_display(node_t *head) {
//    for (; head; head = head->next)
//        printf("%s", head->data);
//    printf("\n");
//}


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
//        node_t d = {"d", 0}, c = {"c", &d}, b = {"b", &c}, a = {"a", &b};
//        list_display(&a);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
