//
//  CirleLinkedList.m
//  02_双向链表-----------(双向循环链表)
//
//  Created by zj on 2020/5/21.
//  Copyright © 2020 zj. All rights reserved.
//

#import "CirleLinkedList.h"

typedef void *AnyObject;

typedef struct node {
    AnyObject data;
    struct node *next;
    struct node *prev;
} Node;


@interface CirleLinkedList ()

/// 链表头节点
@property (nonatomic, assign) Node *first;
/// 链表尾节点
@property (nonatomic, assign) Node *last;
/// 链表长度
@property (nonatomic, assign) NSInteger size;


// 优化
/// 当前节点
@property (nonatomic, assign) Node *current;


@end

@implementation CirleLinkedList

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
        self.last = [self initWithData:object next:_first prev:oldLast];
        if (oldLast == NULL) {// 链表添加的第一个元素
            _first = _last;
            _first->next = _first;
            _first->prev = _first;
        } else {
            oldLast->next = self.last;
            _first->prev = _last;
        }
    } else {
        Node *next = [self NodeAtIndex:index];
        Node *prev = next->prev;
        Node *newNode = [self initWithData:object next:next prev:prev];
        next->prev = newNode;
        prev->next = newNode;
        
        if (index == 0) {// index == 0头部添加
            self.first = newNode;
        }
        
    }
    
    self.size++;
}

/**
 * 删除index位置的元素
 */
- (id)removeObjectAtIndex:(NSInteger)index {
    return [self removeObjectAtNode:[self NodeAtIndex:index]];
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


/**
 * 重制
 */
- (void)resetNode {
    self.current = _first;
}

/**
 * 下一个节点
 */
- (id)nextNode {
    if (_current == NULL) return NULL;
    
    _current = _current->next;
    return (__bridge id _Nonnull)(_current->data);
}

/**
 * 删除当前节点
 */
- (id)removeNode {
    if (_current == NULL) return NULL;
    
    Node *next = self.current->next;
    id data = [self removeObjectAtNode:self.current];
    if (_size == 0) {
        self.current = NULL;
    } else {
        self.current = next;
    }
    return data;
}

/**
 * 删除节点
 */
- (id)removeObjectAtNode:(Node *)node {
    if (self.size == 1) {
        _first = NULL;
        _last = NULL;
    } else {
        Node *prev = node->prev;
        Node *next = node->next;
        prev->next = next;
        next->prev = prev;
        if (node == _first) {
            _first = next;
        }
        if (node == _last) {
            _last = prev;
        }
    }
    _size--;
    return (__bridge id)(node->data);
}

/**
 * 是否为空
 */
- (BOOL)isEmpty {
     return self.size == 0;
}

@end
