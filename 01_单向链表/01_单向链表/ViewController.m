//
//  ViewController.m
//  01_单向链表
//
//  Created by zj on 2020/5/18.
//  Copyright © 2020 zj. All rights reserved.
//

#import "ViewController.h"

#import "LinkedList.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LinkedList *list1 = [[LinkedList alloc] init];
    [list1 addObjectAtLast:@(10)];
    [list1 addObjectAtLast:@(20)];
    [list1 addObject:@(30) atIndex:2];
    [list1 removeObjectAtIndex:1];
    NSLog(@"%@",[list1 list_display]);
}



@end
