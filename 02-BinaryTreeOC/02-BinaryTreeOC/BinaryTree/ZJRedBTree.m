//
//  ZJRedBTree.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/12/2.
//

/**
 * 节点元素个数x
 *
 * 根节点： 1 <= x <= m-1
 * 非根节点：ceiling[m/2] - 1 <= x <= m-1
 *
 * ****************************
 *
 * 元素个数与子节点个数相差1的关系
 *
 * 二叉搜索树的多代节点合并获得一个超级节点。
 *
 * 搜索：
 * 从节点内部先找，再去子树中找。
 *
 * 添加：
 * 考虑溢出情况，
 * 上溢解决：将上溢节点与父节点结合，子节点分成两个子节点。
 *
 * 删除：
 * 找到前驱/后继覆盖掉要删除的元素。真正删除元素都是发生在叶子结点当中。
 * 下溢解决：向临近的ceiling[m/2]节点借一个。旋转方式去借。
 *
 * 让B树长高的唯一方式就是根节点向上溢出。
 *
 *
 *
 */

/**
 * 红黑树性质：
 *
 * 1、节点是RED 或 BlACK
 * 2、根节点是BLACK
 * 3、叶子节点都是BLACK
 * 4、RED节点的子节点都是BLACK
 *      RED节点的parent都是BLACK
 *      从根节点到叶子节点的所有路径上不能有两个连续的RED节点
 * 5、从任一节点到叶子节点的所有路径都包含相同树木的BLACK节点
 *
 *
 * 添加：
 * * 默认添加的是红色节点
 * 修复性质4
 * * LL/RR/LR/RL
 * 上溢问题
 *
 */

#import "ZJRedBTree.h"

static BOOL RED = NO;
static BOOL BLACK = YES;

@interface ZJRBNode : NSObject {
@public
    id _element;
    ZJRBNode *_left;
    ZJRBNode *_right;
    __weak ZJRBNode *_parent;
    BOOL _color;
}
@end

@implementation ZJRBNode

+ (instancetype)nodeWithElement:(id)element parent:(ZJRBNode *)parent {
    ZJRBNode *node = [[self alloc] init];
    node->_element = element;
    node->_parent = parent;
    node->_color = RED;
    return  node;
}

- (BOOL)hasTwoChildren {
    return _left != nil && _right != nil;
}

- (BOOL)isLeaf {
    return _left == nil && _right == nil;
}

// 判断自己是左子树
- (BOOL)isLeftChild {
    return _parent != nil && self == _parent->_left;
}

// 判断自己是右子树
- (BOOL)isRightChild {
    return _parent != nil && self == _parent->_right;
}

// 返回兄弟节点
- (ZJRBNode *)sibing {
    if ([self isLeftChild]) {
        return self->_parent->_right;
    }
    
    if ([self isRightChild]) {
        return self->_parent->_left;
    }
    
    return nil;
}

// 染色
- (ZJRBNode *)colorNode:(ZJRBNode *)node color:(BOOL)color {
    if (node == nil) return node;
    node->_color = color;
    return node;
}

// 染红色
- (ZJRBNode *)red:(ZJRBNode *)node {
    return [self colorNode:node color:RED];
}

// 染黑色
- (ZJRBNode *)black:(ZJRBNode *)node {
    return [self colorNode:node color:BLACK];
}

// 判断节点是什么颜色
- (BOOL)colorOf:(ZJRBNode *)node {
    // 空节点一般默认为黑色
    return node == nil ? BLACK : node->_color;
}

// 判断节点是否为黑色
- (BOOL)isBlack:(ZJRBNode *)node {
    return [self colorOf:node] == BLACK;
}

// 判断节点是否为红色
- (BOOL)isRed:(ZJRBNode *)node {
    return [self colorOf:node] == RED;
}

@end


@interface ZJRedBTree() {
    NSUInteger _size;
    ZJRBNode *_root;
    MJBSTComparatorBlock _comparatorBlock;
}
@end

@implementation ZJRedBTree

+ (instancetype)tree {
    ZJRedBTree *bst = [[self alloc] init];
    return bst;
}

+ (instancetype)treeWithComparatorBlock:(MJBSTComparatorBlock)comparatorBlock {
    ZJRedBTree *bst = [[self alloc] init];
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
        _root = [ZJRBNode nodeWithElement:element parent:nil];
        _size++;
        
        [self afterAdd:_root];
        return;
    }
    
    ZJRBNode *parent = _root;
    ZJRBNode *node = _root;
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
    
    ZJRBNode *newNode = [ZJRBNode nodeWithElement:element parent:parent];
    if (cmp > 0) {
        parent->_right = newNode;
    } else {
        parent->_left = newNode;
    }
    _size++;
    
    [self afterAdd:newNode];
}

// 添加的新节点均为红色...
- (void)afterAdd:(ZJRBNode *)node {
    ZJRBNode *parent = node->_parent;
    // 添加的是根节点 或者 上溢到达了根节点
    if (parent == nil) {
        [node black:node];
        return;
    }
    
    // 如果父节点是黑色，直接返回
    if ([parent isBlack:parent]) return;
    
    // 父节点变黑，祖父变红...
    // 叔父节点
    ZJRBNode *uncle = [parent sibing];
    // 祖父节点
    ZJRBNode *grand = [parent red:parent->_parent];
    
    // 叔父节点是否为红色判断B树是否上溢
    if ([uncle isRed:uncle]) { // 叔父节点是红色【B树节点上溢】
        // 只有黑色节点才能成为独立的B树节点
        [parent black:parent];
        [uncle black:uncle];
        // 递归处理，上溢情况，相当于给更上层B树节点新添加一个祖父节点。
        [self afterAdd:grand];
        return;
    }
    
    /// 旋转操作（心中要有旋转）
    /**
     * LL/RR 父节点染成黑色
     *
     * LR/RL node染成黑色
     */
    // 叔父节点不是红色
    if ([parent isLeftChild]) { // L
        if ([node isLeftChild]) { // LL
            [parent black:parent];
//            [grand red:grand];
//            [self rotateRight:grand];
        } else { // LR
            [node black:node];
//            [grand red:grand];
            [self rotateLeft:parent];
//            [self rotateRight:grand];
        }
        [self rotateRight:grand];
    } else { // R
        if ([node isLeftChild]) {// RL
            [node black:node];
//            [grand red:grand];
            [self rotateRight:parent];
//            [self rotateLeft:grand];
        } else { // RR
            [parent black:parent];
//            [grand red:grand];
//            [self rotateLeft:grand];
        }
        [self rotateLeft:grand];
    }
    
}

/// 真正被删除的是叶子节点
/**
 * 删除叶子节点RED，直接删除
 * 
 */
- (void)remove:(id)element {
    [self removeNode:[self node:element]];
}

- (void)removeNode:(ZJRBNode *)node {
    if (node == nil) return;
    
    _size--;
    
    // 度==2
    if ([node hasTwoChildren]) {
        // 拿到前驱节点
        ZJRBNode *p = [self predecessor:node];
        // 前驱节点值覆盖原节点的值
        node->_element = p->_element;
        // 替换，删除p
        node = p;
    }
    
    // 删除度==1或者度==0
    // 度==1的节点，要么是左，要么是右
    ZJRBNode *replacement = (node->_left != nil) ? (node->_left) : (node->_right);
    
    if (replacement != nil) { // 度== 1
        replacement->_parent = node->_parent;
        if (node->_parent == nil) { // node度=1 且 node=root
            _root = replacement;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replacement;
        } else if (node == node->_parent->_right) {
            node->_parent->_right = replacement;
        }
        
        [self afterRemove:node replacementNode:replacement];
    } else if (node->_parent == nil) { // 根节点
        _root = nil;
        [self afterRemove:node replacementNode:nil];
    } else { // node叶子节点 且 不是根节点
        if (node == node->_parent->_left) {
            node->_parent->_left = nil;
        } else {
            node->_parent->_right = nil;
        }
        [self afterRemove:node replacementNode:nil];
    }
}

- (void)afterRemove:(ZJRBNode *)node replacementNode:(ZJRBNode *)replacement {
    // 如果删除的节点是红色
    if ([node isRed:node]) return;
    
    // 用以取代删除节点的子节点是红色
    if ([replacement isRed:replacement]) {
        [replacement black:replacement];
        return;
    }
    
    
    
}

/**
 * 左旋转操作
 *
 * 注意需要维护：c，p, g的parent属性
 */
- (void)rotateLeft:(ZJRBNode *)grand {
    ZJRBNode *parent = grand->_right;
    ZJRBNode *child = parent->_left;
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
}

/**
 * 右旋转操作
 */
- (void)rotateRight:(ZJRBNode *)grand {
    ZJRBNode *parent = grand->_left;
    ZJRBNode *child = parent->_right;
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
}

// 获取节点
- (ZJRBNode *)node:(id)element {
    ZJRBNode *node = _root;
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

#pragma mark - 中序遍历中前驱节点
- (ZJRBNode *)predecessor:(ZJRBNode *)node {
    if (node == nil) return NULL;
    
    // 前驱节点在左子树上(left.right.right...)
    ZJRBNode *p = node->_left;
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

- (id)left:(ZJRBNode *)node {
    return node->_left;
}

- (id)right:(ZJRBNode *)node {
    return node->_right;
}

- (id)string:(ZJRBNode *)node {
    return node->_element;
}

@end
