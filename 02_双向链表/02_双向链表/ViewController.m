//
//  ViewController.m
//  02_双向链表
//
//  Created by zj on 2020/5/19.
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
    
    LinkedList *linkList = [[LinkedList alloc] init];
    [linkList addObjectAtLast:@(1)];
    [linkList addObjectAtLast:@(2)];
    [linkList addObjectAtLast:@(3)];
    [linkList addObjectAtLast:@(4)];
    [linkList addObjectAtLast:@(5)];
    [linkList addObject:@(6) atIndex:5];
    
    NSLog(@"%@",[linkList list_display]);
}


@end
