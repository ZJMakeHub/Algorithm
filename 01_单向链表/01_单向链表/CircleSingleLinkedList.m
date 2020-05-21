//
//  CircleSingleLinkedList.m
//  01_单向链表----(单向循环链表)
//
//  Created by zj on 2020/5/21.
//  Copyright © 2020 zj. All rights reserved.
//

#import "CircleSingleLinkedList.h"

static int ELEMENT_NOT_FOUND = -1;


typedef void *AnyObject;

typedef struct node {
    AnyObject data;
    struct node *next;
} Node;

@interface CircleSingleLinkedList ()

/// 链表长度
@property (nonatomic, assign) NSInteger size;
/// 链表头节点
@property (nonatomic, assign) Node *head;

@end

@implementation CircleSingleLinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        Node *head = (Node *)malloc(sizeof(Node));
        self.head = head;
        self.size = 0;
    }
    return self;
}


/**
 * 清除所有元素
 */
- (void)clear {
    self.size = 0;
    self.head = NULL;
}

/**
 * 是否包含某个元素
 */
- (BOOL)containsObject:(id)object {
    Node *cur = _head;
    while (cur != NULL) {
        id data = (__bridge_transfer id)cur->data;
        if ([data isEqual:object]) {
            return YES;
        }
        cur = cur->next;
    }
    return NO;
}

/**
 * 添加元素到尾部
 */
- (void)addObjectAtLast:(id)object {
    [self addObject:object atIndex:self.size];
}

/**
 * 获取index位置的元素
 */
- (id)objectAtIndex:(NSInteger)index {
    return (__bridge_transfer id)([self NodeAtIndex:index]->data);
}

- (Node *)NodeAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.count) {
        @throw [NSException exceptionWithName:@"LinkedList is out of bounds" reason:@"Add failed. Illegal index." userInfo:nil];
        return nil;
    }
    Node *node = self.head;
    for (int i = 0; i<index; i++) {
        node = node->next;
    }
    return node;
}

/**
 * 在index位置插入一个元素
 */
- (void)addObject:(id)object atIndex:(NSInteger)index {
    
    if (index == 0) {
        Node *newHead = (Node *)malloc(sizeof(Node));
        newHead->next = _head;
        newHead->data = (__bridge_retained AnyObject)object;
        
        // 拿到最后一个节点
        Node *last = (self.size == 0) ? newHead : [self NodeAtIndex:(self.size - 1)];
        last->next = newHead;
        _head = newHead;
    } else {
        Node *prev = [self NodeAtIndex:(index-1)];
        Node *newHead = (Node *)malloc(sizeof(Node));
        newHead->data = (__bridge_retained AnyObject)object;
        newHead->next = prev->next;
        prev->next = newHead;
    }
    self.size++;
}


/**
 * 删除index位置的元素
 */
- (id)removeObjectAtIndex:(NSInteger)index {
    
    if (index < 0 || index >= self.count) {
        @throw [NSException exceptionWithName:@"LinkedList is out of bounds" reason:@"Add failed. Illegal index." userInfo:nil];
        return nil;
    }
    
    Node *node = _head;
    if (index == 0) {
        if (self.size == 1) {
            _head = NULL;
        } else {
            // 拿到最后一个节点
            Node *last = [self NodeAtIndex:(self.size - 1)];
            _head = _head->next;
            last->next = _head;
        }
    } else {
        Node *prev = [self NodeAtIndex:(index-1)];
        node = prev->next;
        prev->next = node->next;
    }
    self.size--;
    return (__bridge id _Nonnull)(node->data);
}

/**
 * 查看元素的索引
 */
- (int)indexOf:(id)object {
    Node *node = _head;
    for (int i = 0; i < self.size; i++) {
        if (node->data == NULL) return i;
        node = node->next;
    }
    return ELEMENT_NOT_FOUND;
}

/**
 * 是否为空
 */
- (BOOL)isEmpty {
    return self.count == 0;
}


- (NSInteger)count {
    return self.size;
}

// 打印链表
- (NSMutableString *)list_display {
    NSMutableString *mutStr = [[NSMutableString alloc] init];
    [mutStr appendFormat:@"%@ , [", [NSString stringWithFormat:@"size = %ld",self.size]];
    Node *node = _head;
    for (int i = 0; i<self.size; i++) {
        if (i != 0) {
            [mutStr appendString:@", "];
        }
        [mutStr appendFormat:@"%@", (__bridge NSString * _Nonnull)(node->data)];
        node = node->next;
    }
    [mutStr appendString:@"]"];
    return mutStr ;
}




@end
