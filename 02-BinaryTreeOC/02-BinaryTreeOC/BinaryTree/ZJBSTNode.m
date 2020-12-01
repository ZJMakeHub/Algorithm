//
//  ZJBSTNode.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/27.
//

#import "ZJBSTNode.h"

@implementation ZJBSTNode

+ (instancetype)nodeWithElement:(id)element parent:(ZJBSTNode *)parent {
    ZJBSTNode *node = [[self alloc] init];
    node->_element = element;
    node->_parent = parent;
    return  node;
}

- (BOOL)hasTwoChildren {
    return _left != nil && _right != nil;
}

- (BOOL)isLeaf {
    return _left == nil && _right == nil;
}

@end
