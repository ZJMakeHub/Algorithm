//
//  ZJBinarySearchTree.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import "ZJBinarySearchTree.h"

@interface ZJBSTNode : NSObject {
@public
    id _element;
    ZJBSTNode *_left;
    ZJBSTNode *_right;
    __weak ZJBSTNode *_parent;
}
@end

@implementation ZJBSTNode

+ (instancetype)nodeWithElement:(id)element parent:(ZJBSTNode *)parent {
    ZJBSTNode *node = [[self alloc] init];
    node->_element = element;
    node->_parent = parent;
    return  node;
}

@end

@interface ZJBinarySearchTree() {
    NSUInteger _size;
    ZJBSTNode *_root;
    MJBSTComparatorBlock _comparatorBlock;
}
@end

@implementation ZJBinarySearchTree

+ (instancetype)tree {
    ZJBinarySearchTree *bst = [[self alloc] init];
    return bst;
}

+ (instancetype)treeWithComparatorBlock:(MJBSTComparatorBlock)comparatorBlock {
    ZJBinarySearchTree *bst = [[self alloc] init];
    bst->_comparatorBlock = comparatorBlock;
    return bst;;
}

- (NSUInteger)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)add:(id)element {
    if (!element) return;
    
    // 判断根节点
    if (!_root) {
        // 直接添加到根节点
        _root = [ZJBSTNode nodeWithElement:element parent:nil];
        _size++;
        return;
    }
    
    ZJBSTNode *parent = _root;
    ZJBSTNode *node = _root;
    int cmp = 0;
    while (node) { // 当node==nil时退出循环
        cmp = [self _compare:element e2:node->_element];
        // 保存父节点
        parent = node;
        
        if (cmp > 0) {
            node = node->_right;
        } else if (cmp < 0) {
            node = node->_left;
        } else { // 添加的是值相同时，直接覆盖
            node->_element = element;
            return;
        }
    }
    
    ZJBSTNode *newNode = [ZJBSTNode nodeWithElement:element parent:parent];
    if (cmp > 0) {
        parent->_right = newNode;
    } else {
        parent->_left = newNode;
    }
    _size++;
}

- (void)remove:(id)element {
    
}

#pragma mark - 遍历
// 前序遍历: 根节点，左子树，右子树
- (void)preorderTraversal {
    [self preorderTraversal:_root];
}
- (void)preorderTraversal:(ZJBSTNode *)node {
    if (!node) return;
    
    NSLog(@"%@",node->_element);
    [self preorderTraversal:node->_left];
    [self preorderTraversal:node->_right];
}

// 中序遍历：左子树，根，右子树
- (void)inorderTraversal {
    [self inorderTraversal:_root];
}
- (void)inorderTraversal:(ZJBSTNode *)node {
    if (!node) return;
    
    [self inorderTraversal:node->_left];
    NSLog(@"%@",node->_element);
    [self inorderTraversal:node->_right];
}

// 后序遍历：左子树，右子树，根
- (void)postorderTraversal {
    [self postorderTraversal:_root];
}
- (void)postorderTraversal:(ZJBSTNode *)node {
    if (!node) return;
    
    [self postorderTraversal:node->_left];
    [self postorderTraversal:node->_right];
    NSLog(@"%@",node->_element);
}

// 层序遍历：一层一层遍历
- (void)levelOrderTraversal {
    if (!_root) return;
    
    
}

#pragma mark - 比较方法
- (int)_compare:(id)e1 e2:(id)e2 {
    return _comparatorBlock ? _comparatorBlock(e1, e2) : [e1 compare:e2];
}

#pragma mark - MJBinaryTreeInfo
- (id)root {
    return _root;
}

- (id)left:(ZJBSTNode *)node {
    return node->_left;
}

- (id)right:(ZJBSTNode *)node {
    return node->_right;
}

- (id)string:(ZJBSTNode *)node {
    return node->_element;
}

@end
