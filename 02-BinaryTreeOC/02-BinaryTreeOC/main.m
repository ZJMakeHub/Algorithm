//
//  main.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import <Foundation/Foundation.h>

// LinkedList
#import "ZJSingleLinkedList.h"
#import "ZJDoubleLinkedList.h"
#import "ZJQueue.h"
// Tree
#import "MJBinaryTrees.h"
#import "ZJBinarySearchTree.h"
#import "ZJAVLTree.h"
#import "ZJRedBTree.h"


void RedBTTest() {
    int data[] = { 55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50};
    int len = sizeof(data) / sizeof(int);
    
    ZJRedBTree *avlt = [ZJRedBTree tree];
    for (int i = 0; i < len; i++) {
        [avlt add:@(data[i])];
    }
    [MJBinaryTrees println:avlt];
}

void AVLTTest() {
    int data[] = { 8, 12, 5, 3, 11, 36, 6, 20, 26};
    int len = sizeof(data) / sizeof(int);
    
    ZJAVLTree *avlt = [ZJAVLTree tree];
    for (int i = 0; i < len; i++) {
        [avlt add:@(data[i])];
    }
    [MJBinaryTrees println:avlt];
    printf("---------------------------------\n");
    [avlt add:@(10)];
    [MJBinaryTrees println:avlt];

}


void BSTTest() {
    int data[] = { 8, 12, 5, 3, 11, 36, 6, 20, 26};
    int len = sizeof(data) / sizeof(int);
    
    ZJBinarySearchTree *bst = [ZJBinarySearchTree tree];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    [MJBinaryTrees println:bst];
    printf("---------------------------------\n");
//    [bst levelOrderTraversal];
//    [bst remove:@(8)];
//    [MJBinaryTrees println:bst];
}


void SingleLinkedListTest() {
    ZJSingleLinkedList *list = [[ZJSingleLinkedList alloc] init];
    [list add:@(20)];
    [list add:0 element:@(10)];
    [list add:@(30)];
    [list add:[list size] element:@(40)];
    
    [list remove:1];
    
    NSLog(@"%@",[list toString]);
}

void DoubleLinkedListTest() {
    ZJDoubleLinkedList *list = [[ZJDoubleLinkedList alloc] init];
    [list add:@(20)];
    [list add:0 element:@(10)];
    [list add:@(30)];
    [list add:[list size] element:@(40)];
    
    [list remove:1];
    
    NSLog(@"%@",[list toString]);
}

void QueueTest() {
    ZJQueue *queue = [[ZJQueue alloc] init];
    [queue enQueue:@(11)];
    [queue enQueue:@(22)];
    [queue enQueue:@(33)];
    [queue enQueue:@(44)];
    [queue enQueue:@(66)];
    [queue enQueue:@(22)];
    [queue enQueue:@(99)];
    
    while (![queue isEmpty]) {
        NSLog(@"%@",[queue deQueue]);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        BSTTest();
//        SingleLinkedListTest();
//        DoubleLinkedListTest();
//        QueueTest();
//        AVLTTest();
        RedBTTest();
    }
    return 0;
}
