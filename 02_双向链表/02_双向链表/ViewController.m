//
//  ViewController.m
//  02_双向链表
//
//  Created by zj on 2020/5/19.
//  Copyright © 2020 zj. All rights reserved.
//

#import "ViewController.h"
#import "LinkedList.h"
#import "CirleLinkedList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CirleLinkedList *linkList = [[CirleLinkedList alloc] init];
    [linkList addObjectAtLast:@(1)];
    [linkList addObjectAtLast:@(2)];
    [linkList addObjectAtLast:@(3)];
    [linkList addObjectAtLast:@(4)];
    [linkList addObjectAtLast:@(5)];
    [linkList addObject:@(6) atIndex:5];
    
    NSLog(@"%@",[linkList list_display]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self josephus];
}

// 哟瑟夫问题
- (void)josephus {
    CirleLinkedList *linkList = [[CirleLinkedList alloc] init];
    for (int i = 1; i<=8; i++) {
        [linkList addObjectAtLast:@(i)];
    }
    NSLog(@"%@",[linkList list_display]);
    [linkList resetNode];
    while (![linkList isEmpty]) {
        [linkList nextNode];
        [linkList nextNode];
        NSLog(@"%@",[linkList removeNode]);
    }
}



@end
