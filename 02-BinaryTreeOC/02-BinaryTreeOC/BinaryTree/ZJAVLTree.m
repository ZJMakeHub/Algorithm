//
//  ZJAVLTree.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/27.
//

#import "ZJAVLTree.h"
#import "ZJQueue.h"

@interface ZJAVLNode : NSObject {
@public
    id _element;
    ZJAVLNode *_left;
    ZJAVLNode *_right;
    __weak ZJAVLNode *_parent;
    int _height;
}
@end

@implementation ZJAVLNode

+ (instancetype)nodeWithElement:(id)element parent:(ZJAVLNode *)parent {
    ZJAVLNode *node = [[self alloc] init];
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

- (int)balanceFactor {
    int leftHeight = _left == nil ? 0 : _left->_height;
    int rightHeight = _right == nil ? 0 : _right->_height;
    return leftHeight - rightHeight;// 左子树高度-右子树高度
}

- (void)updateHeight {
    int leftHeight = _left == nil ? 0 : _left->_height;
    int rightHeight = _right == nil ? 0 : _right->_height;
    _height = 1 + MAX(leftHeight, rightHeight);
}

// 最高的节点
- (ZJAVLNode *)tallerChild {
    int leftHeight = _left == nil ? 0 : _left->_height;
    int rightHeight = _right == nil ? 0 : _right->_height;
    if (leftHeight > rightHeight) {
        return _left;
    }
    if (leftHeight < rightHeight) {
        return _right;
    }
    return [self isLeftChild] ? _left : _right;
}

// 判断自己是左子树
- (BOOL)isLeftChild {
    return _parent != nil && self == _parent->_left;
}

// 判断自己是右子树
- (BOOL)isRightChild {
    return _parent != nil && self == _parent->_right;
}

@end



@interface ZJAVLTree() {
    NSUInteger _size;
    ZJAVLNode *_root;
    MJBSTComparatorBlock _comparatorBlock;
}
@end

@implementation ZJAVLTree

+ (instancetype)tree {
    ZJAVLTree *bst = [[self alloc] init];
    return bst;
}

+ (instancetype)treeWithComparatorBlock:(MJBSTComparatorBlock)comparatorBlock {
    ZJAVLTree *bst = [[self alloc] init];
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
        _root = [ZJAVLNode nodeWithElement:element parent:nil];
        _size++;
        
        [self afterAdd:_root];
        return;
    }
    
    ZJAVLNode *parent = _root;
    ZJAVLNode *node = _root;
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
    
    ZJAVLNode *newNode = [ZJAVLNode nodeWithElement:element parent:parent];
    if (cmp > 0) {
        parent->_right = newNode;
    } else {
        parent->_left = newNode;
    }
    _size++;
    
    [self afterAdd:newNode];
}

/**
 * 添加node之后的调整
 *
 * node 是新添加的节点
 *
 * LL，RR，LR，RL四种情况：通过parent找失衡因子
 */
- (void)afterAdd:(ZJAVLNode *)node {
    while ((node = node->_parent) != nil) {
        if ([self isBalance:node]) {
            // 更新高度
            [node updateHeight];
        } else {
            // 恢复平衡
            [self rebalance:node];
        }
    }
}

/**
 * 判断node是否平衡
 */
- (BOOL)isBalance:(ZJAVLNode *)node {
    return abs([node balanceFactor]) <= 1; // abs()求绝对值，<= 1代表平衡
}

/**
 * 恢复平衡
 *
 * grand: 高度最低的不平衡节点
 */
- (void)rebalance:(ZJAVLNode *)grand {
    ZJAVLNode *parent = [grand tallerChild];
    ZJAVLNode *node = [parent tallerChild];
    if ([parent isLeftChild]) {
        if ([node isLeftChild]) {// LL
            [self rotateRight:grand];
        } else {// LR
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    } else {
        if ([node isLeftChild]) {// RL
            [self rotateRight:parent];
            [self rotateLeft:grand];
        } else {// RR
            [self rotateLeft:grand];
        }
    }
}

/**
 * 左旋转操作
 */
- (void)rotateLeft:(ZJAVLNode *)grand {
    ZJAVLNode *parent = grand->_right;
    ZJAVLNode *child = parent->_left;
    grand->_right = child;
    parent->_left = grand;
    
    parent->_parent = grand->_parent;
    if ([grand isLeftChild]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightChild]) {
        grand->_parent->_right = parent;
    } else {
        _root = parent;
    }
    // 更新child的parent
    if (child != nil) {
        child->_parent = grand;
    }
    // 更新grand的parent
    grand->_parent = parent;
    
    // 更新高度
    [grand updateHeight];
    [parent updateHeight];
}

/**
 * 右旋转操作
 */
- (void)rotateRight:(ZJAVLNode *)grand {
    ZJAVLNode *parent = grand->_left;
    ZJAVLNode *child = parent->_right;
    grand->_left = child;
    parent->_right = grand;
    
    parent->_parent = grand->_parent;
    if ([grand isLeftChild]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightChild]) {
        grand->_parent->_right = parent;
    } else {
        _root = parent;
    }
    
    if (child != nil) {
        child->_parent = grand;
    }
    grand->_parent = parent;
    
    [grand updateHeight];
    [parent updateHeight];
}


/**
 * 叶子节点直接删除
 *
 * 度==1节点，子节点替代原节点的位置
 *
 * 度==2节点，前驱节点值覆盖原节点的值，再删除对应的前驱节点
 */
- (void)remove:(id)element {
    [self removeNode:[self node:element]];
}

// 删除节点
- (void)removeNode:(ZJAVLNode *)node {
    if (node == nil) return;
    
    _size--;
    
    // 度==2
    if ([node hasTwoChildren]) {
        // 拿到前驱节点
        ZJAVLNode *p = [self predecessor:node];
        // 前驱节点值覆盖原节点的值
        node->_element = p->_element;
        // 替换，删除p
        node = p;
    }
    
    // 删除度==1或者度==0
    // 度==1的节点，要么是左，要么是右
    ZJAVLNode *replacement = (node->_left != nil) ? (node->_left) : (node->_right);
    
    if (replacement != nil) { // 度== 1
        replacement->_parent = node->_parent;
        if (node->_parent == nil) { // node度=1 且 node=root
            _root = replacement;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replacement;
        } else if (node == node->_parent->_right) {
            node->_parent->_right = replacement;
        }
    } else if (node->_parent == nil) { // 根节点
        _root = nil;
    } else { // node叶子节点 且 不是根节点
        if (node == node->_parent->_left) {
            node->_parent->_left = nil;
        } else {
            node->_parent->_right = nil;
        }
    }
    
}

// 获取节点
- (ZJAVLNode *)node:(id)element {
    ZJAVLNode *node = _root;
    while (node != nil) {
        int cmp = [self _compare:element e2:node->_element];
        if (cmp == 0) {
            return node;
        }
        if (cmp > 0) {
            node = node->_right;
        } else {
            node = node->_left;
        }
    }
    return nil;
}

#pragma mark - 遍历
// 前序遍历: 根节点，左子树，右子树
- (void)preorderTraversal {
    [self preorderTraversal:_root];
}
- (void)preorderTraversal:(ZJAVLNode *)node {
    if (!node) return;
    
    NSLog(@"%@",node->_element);
    [self preorderTraversal:node->_left];
    [self preorderTraversal:node->_right];
}

// 中序遍历：左子树，根，右子树
- (void)inorderTraversal {
    [self inorderTraversal:_root];
}
- (void)inorderTraversal:(ZJAVLNode *)node {
    if (!node) return;
    
    [self inorderTraversal:node->_left];
    NSLog(@"%@",node->_element);
    [self inorderTraversal:node->_right];
}

// 后序遍历：左子树，右子树，根
- (void)postorderTraversal {
    [self postorderTraversal:_root];
}
- (void)postorderTraversal:(ZJAVLNode *)node {
    if (!node) return;
    
    [self postorderTraversal:node->_left];
    [self postorderTraversal:node->_right];
    NSLog(@"%@",node->_element);
}

// 层序遍历：从上至下一层一层遍历
- (void)levelOrderTraversal {
    if (!_root) return;
    
    ZJQueue *queue = [[ZJQueue alloc] init];
    [queue enQueue:_root];
    
    while (![queue isEmpty]) {
        ZJAVLNode *node = [queue deQueue];
        NSLog(@"%@",node->_element);
        
        if (node->_left != nil) {
            [queue enQueue:node->_left];
        }
        
        if (node->_right != nil) {
            [queue enQueue:node->_right];
        }
    }
}

#pragma mark - 中序遍历中前驱节点
- (ZJAVLNode *)predecessor:(ZJAVLNode *)node {
    if (node == nil) return NULL;
    
    // 前驱节点在左子树上(left.right.right...)
    ZJAVLNode *p = node->_left;
    if (p != nil) {
        while (p->_right != nil) {
            p = p->_right;
        }
        return p;
    }
    
    // 前驱节点在祖节点上
    while ((node->_parent != nil) && (node = node->_parent->_left)) {
        node = node->_parent;
    }
    
    return node->_parent;
}


#pragma mark - 比较方法
- (int)_compare:(id)e1 e2:(id)e2 {
    return _comparatorBlock ? _comparatorBlock(e1, e2) : [e1 compare:e2];
}

#pragma mark - MJBinaryTreeInfo
- (id)root {
    return _root;
}

- (id)left:(ZJAVLNode *)node {
    return node->_left;
}

- (id)right:(ZJAVLNode *)node {
    return node->_right;
}

- (id)string:(ZJAVLNode *)node {
    return node->_element;
}

@end
