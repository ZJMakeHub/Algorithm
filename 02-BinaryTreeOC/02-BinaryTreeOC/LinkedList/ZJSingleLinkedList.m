//
//  ZJSingleLinkedList.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//
#import "ZJSingleLinkedList.h"

@interface ZJSingleNode: NSObject {
@public
    id _element;
    ZJSingleNode *_next;
}
@end

@implementation ZJSingleNode

+ (instancetype)nodeWithElement:(id)element next:(ZJSingleNode *)next {
    ZJSingleNode *node = [[self alloc] init];
    node->_element = element;
    node->_next = next;
    return node;
}

@end

static int ELEMENT_NOT_FOUND = -1;

@interface ZJSingleLinkedList () {
    int _size;
    ZJSingleNode *_first;
}
@end


@implementation ZJSingleLinkedList

- (int)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    _size = 0;
    _first = nil;
}

- (void)add:(id)element {
    [self add:_size element:element];
}

- (id)get:(int)index {
    return [self node:index]->_element;
}

- (id)set:(int)index element:(id)element {
    ZJSingleNode *node = [self node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}

- (void)add:(int)index element:(id)element {
    
    if (index == 0) { // 特殊情况，在头部添加，边界情况
        _first = [ZJSingleNode nodeWithElement:element next:_first];
    } else {
        // 拿到index前面的元素
        ZJSingleNode *prev = [self node:index-1];
        // 之前A->B->C，现在A->B->D->C
        prev->_next = [ZJSingleNode nodeWithElement:element next:prev->_next];
    }
    _size++;
}

- (id)remove:(int)index {
    ZJSingleNode *node = _first;
    if (index == 0) {
        _first = _first->_next;
    } else {
        ZJSingleNode *prev = [self node:index-1];
        node = prev->_next;
        prev->_next = node->_next;
    }
    _size--;
    return node->_element;
}

- (int)indexOf:(id)element {
    if (element == nil) {
        ZJSingleNode *node = _first;
        for (int i = 0; i<_size; i++) {
            if (node->_element == nil) return i;
            node = node->_next;
        }
    } else {
        ZJSingleNode *node = _first;
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
    ZJSingleNode *node = _first;
    for (int i = 0; i<_size; i++) {
        if (i != 0) {
            [string appendString:@"，"];
        }
        [string appendString:[NSString stringWithFormat:@"%@",node->_element]];
        node = node->_next;
    }
    [string appendString:@"]"];
    return string;
}


#pragma mark - private
// 拿到index的node
- (ZJSingleNode *)node:(int)index {
    ZJSingleNode *node = _first;
    for (int i = 0; i<index; i++) {
        node = node->_next;
    }
    return node;
}

@end
