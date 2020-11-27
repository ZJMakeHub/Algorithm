//
//  ZJDoubleLinkedList.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import "ZJDoubleLinkedList.h"

@interface ZJDoubleNode: NSObject {
@public
    id _element;
    ZJDoubleNode *_next;
    ZJDoubleNode *_prev;
}
@end

@implementation ZJDoubleNode

+ (instancetype)nodeWithElement:(id)element next:(ZJDoubleNode *)next prev:(ZJDoubleNode *)prev{
    ZJDoubleNode *node = [[self alloc] init];
    node->_element = element;
    node->_next = next;
    node->_prev = prev;
    return node;
}

@end

static int ELEMENT_NOT_FOUND = -1;

@interface ZJDoubleLinkedList () {
    int _size;
    ZJDoubleNode *_first;
    ZJDoubleNode *_last;
}
@end

@implementation ZJDoubleLinkedList

- (int)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    _size = 0;
    _first = nil;
    _last = nil;
}

- (void)add:(id)element {
    [self add:_size element:element];
}

- (id)get:(int)index {
    return [self node:index]->_element;
}

- (id)set:(int)index element:(id)element {
    ZJDoubleNode *node = [self node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}

- (void)add:(int)index element:(id)element {
    
    if (index == _size) { // 往最后添加元素
        ZJDoubleNode *oldLast = _last;
        _last = [ZJDoubleNode nodeWithElement:element next:nil prev:oldLast];
        if (oldLast == nil) { // index == 0, size == 0，添加的是第一个元素的情况
            _first = _last;
        } else {
            oldLast->_next = _last;
        }
        
    } else {
        // 通用情况
        ZJDoubleNode *next = [self node:index];
        ZJDoubleNode *prev = next->_prev;
        ZJDoubleNode *node = [ZJDoubleNode nodeWithElement:element next:next prev:prev];
        next->_prev = node;
        if (prev == nil) {// index == 0
            _first = node;
        } else {
            prev->_next = node;
        }
    }
    _size++;
}

- (id)remove:(int)index {
    
    // 通用情况
    ZJDoubleNode *node = [self node:index];
    ZJDoubleNode *prev = node->_prev;
    ZJDoubleNode *next = node->_next;
    
    if (prev == nil) {
        _first = next;
    } else {
        prev->_next = next;
    }
    
    if (next == nil) {
        _last = prev;
    } else {
        next->_prev = prev;
    }
    
    _size--;
    return node->_element;
}

- (int)indexOf:(id)element {
    if (element == nil) {
        ZJDoubleNode *node = _first;
        for (int i = 0; i<_size; i++) {
            if (node->_element == nil) return i;
            node = node->_next;
        }
    } else {
        ZJDoubleNode *node = _first;
        for (int i = 0; i<_size; i++) {
            if (node->_element == element) return i;
            node = node->_next;
        }
    }
    return ELEMENT_NOT_FOUND;
}

- (BOOL)contains:(id)element {
    return [self indexOf:element] != ELEMENT_NOT_FOUND;
}

- (NSMutableString *)toString {
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:[NSString stringWithFormat:@"size=%d，[",_size]];// 打印长度
    ZJDoubleNode *node = _first;
    for (int i = 0; i<_size; i++) {
        if (i != 0) {
            [string appendString:@"，"];
        }
        
        if (node->_prev != nil) {
            [string appendString:[NSString stringWithFormat:@"%@",node->_prev->_element]];
        }
        
        [string appendString:[NSString stringWithFormat:@"_%@_",node->_element]];
        
        if (node->_next != nil) {
            [string appendString:[NSString stringWithFormat:@"%@",node->_next->_element]];
        }
        
        node = node->_next;
    }
    [string appendString:@"]"];
    return string;
}


#pragma mark - private
// 拿到index的node
- (ZJDoubleNode *)node:(int)index {
    if (index < (_size >> 1)) {
        ZJDoubleNode *node = _first;
        for (int i = 0; i<index; i++) {
            node = node->_next;
        }
        return node;
    } else {
        ZJDoubleNode *node = _last;
        for (int i = _size-1; index < i; i--) {
            node = node->_prev;
        }
        return node;
    }
}

@end
