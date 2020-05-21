//
//  LinkedList.m
//  02_双向链表
//
//  Created by zj on 2020/5/19.
//  Copyright © 2020 zj. All rights reserved.
//

#import "LinkedList.h"

typedef void *AnyObject;

typedef struct node {
    AnyObject data;
    struct node *next;
    struct node *prev;
} Node;


@interface LinkedList ()

/// 链表头节点
@property (nonatomic, assign) Node *first;
/// 链表尾节点
@property (nonatomic, assign) Node *last;
/// 链表长度
@property (nonatomic, assign) NSInteger size;


@end


@implementation LinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        self.size = 0;
    }
    return self;
}

- (Node *)initWithData:(id)data next:(Node *)next prev:(Node *)prev {
    Node *node = (Node *)malloc(sizeof(Node));
    node->data = (__bridge AnyObject)(data);
    node->next = next;
    node->prev = prev;
    return node;
}

/**
 * 清除所有元素
 */
- (void)clear {
    self.size = 0;
    self.first = NULL;
    self.last = NULL;
}


/// 查找node
- (Node *)NodeAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.size) {
        @throw [NSException exceptionWithName:@"LinkedList is out of bounds" reason:@"Add failed. Illegal index." userInfo:nil];
        return nil;
    }
    if (index < (self.size >> 1)) { // 小于size的一半
        Node *node = _first;
        for (int i = 0; i<index; i++) {
            node = node->next;
        }
        return node;
    } else {
        Node *node = _last;
        for (NSInteger i = self.size-1; i>index; i--) {
            node = node->prev;
        }
        return node;
    }
}

/**
 * 在index位置插入一个元素
 */
- (void)addObject:(id)object atIndex:(NSInteger)index {
    
    if (self.size == index) {// 在最后添加元素
        Node *oldLast = self.last;
        self.last = [self initWithData:object next:NULL prev:oldLast];
        if (oldLast == NULL) {// 链表添加的第一个元素
            _first = _last;
        } else {
            oldLast->next = self.last;
        }
    } else {
        Node *next = [self NodeAtIndex:index];
        Node *prev = next->prev;
        Node *newNode = [self initWithData:object next:next prev:prev];
        next->prev = newNode;
        if (prev == NULL) {// index == 0头部添加
            self.first = newNode;
        } else { // 普通
            prev->next = newNode;
        }
    }
    
    self.size++;
}

/**
 * 删除index位置的元素
 */
- (id)removeObjectAtIndex:(NSInteger)index {
    
    Node *node = [self NodeAtIndex:index];
    Node *prev = node->prev;
    Node *next = node->next;
    
    if (prev == NULL) {
        _first = next;
    } else {
        prev->next = next;
    }
    if (next == NULL) {
        _last = prev;
    } else {
        next->prev = prev;
    }
    _size--;
    return (__bridge id)(node->data);
}

/**
 * 添加元素到尾部
 */
- (void)addObjectAtLast:(id)object {
    [self addObject:object atIndex:self.size];
}

// 打印链表
- (NSMutableString *)list_display {
    NSMutableString *mutStr = [[NSMutableString alloc] init];
    [mutStr appendFormat:@"%@ , [", [NSString stringWithFormat:@"size = %ld",self.size]];
    Node *node = _first;
    for (int i = 0; i<self.size; i++) {
        if (i != 0) {
            [mutStr appendString:@", "];
        }
        Node *prev = node->prev;
        Node *next = node->next;
        if (node->prev != NULL) {
            [mutStr appendFormat:@"%@", (__bridge NSString * _Nonnull)(prev->data)];
        } else {
            [mutStr appendFormat:@"NULL"];
        }
        
        [mutStr appendFormat:@"_%@_", (__bridge NSString * _Nonnull)(node->data)];
        
        if (node->next != NULL) {
            [mutStr appendFormat:@"%@", (__bridge NSString * _Nonnull)(next->data)];
        } else {
            [mutStr appendFormat:@"NULL"];
        }
        
        node = node->next;
    }
    [mutStr appendString:@"]"];
    return mutStr ;
}


@end
