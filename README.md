# Algorithm

## 单向链表
> 链表是一种链式存储的线性表，所有元素的内存地址不一定是连续的。可以办到需要多少就申请多少没存。
> 
> 这也是与动态数组最大的不同之处，动态数组申请的内存地址是连续的。


### 单向链表数据结构设计

##### ZJSingleNode数据结构

```
// 单向链表结点结构
@interface ZJSingleNode: NSObject {
@public
    id _element;// 值
    ZJSingleNode *_next;// 下一个节点
}
@end
```

##### ZJSingleLinkedList数据结构

```
@interface ZJSingleLinkedList () {
    int _size;// 链表大小
    ZJSingleNode *_first;// 链表头节点
}
@end
```

### 单向链表实现接口

```
- (int)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)add:(id)element;// 向最后面添加元素
- (void)add:(int)index element:(id)element;
- (id)remove:(int)index;
- (int)indexOf:(id)element;
- (BOOL)contains:(id)element;// 查找元素是否存在
- (id)get:(int)index;// 获得某个位置的元素
- (id)set:(int)index element:(id)element;// 覆盖某位置的元素

// 拿到index的node
- (ZJSingleNode *)node:(int)index {
    ZJSingleNode *node = _first;
    for (int i = 0; i<index; i++) {
        node = node->_next;
    }
    return node;
}
```

## 双向链表
> 双向链表在单向链表的基础上进行了优化，提升了链表的综合性能。在元素的添加删除上进行了时间复杂度的优化。


### 双向链表数据结构设计

##### ZJDoubleNode数据结构

```
@interface ZJDoubleNode: NSObject {
@public
    id _element;// 值
    ZJDoubleNode *_next;// 下一个节点
    ZJDoubleNode *_prev;// 上一个节点
}
@end
```

##### ZJDoubleLinkedList数据结构

```
@interface ZJDoubleLinkedList () {
    int _size;// 链表大小
    ZJDoubleNode *_first;// 链表头节点
    ZJDoubleNode *_last;// 链表尾节点
}
@end
```

### 双向链表实现接口

```
- (int)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)add:(id)element;// 向最后面添加元素
- (void)add:(int)index element:(id)element;
- (id)remove:(int)index;
- (int)indexOf:(id)element;
- (BOOL)contains:(id)element;// 查找元素是否存在
- (id)get:(int)index;// 获得某个位置的元素
- (id)set:(int)index element:(id)element;// 覆盖某位置的元素

// 拿到index的node：在查找元素上相对单向优化
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
```

## 二叉搜索树
> 简称BST
>
> * 任意一个节点的值都大于其左子树所有节点的值。
> * 任意一个节点的值都小于其右子树所有节点的值。
> * 左右子树也是一颗二叉搜索树。
> * 二叉搜索树大大提高搜索数据的效率。
> * 二叉搜索树的元素都必须具有可比较性。

### 二叉搜索树数据结构设计

##### ZJBSTNode数据结构

```
@interface ZJBSTNode : NSObject {
@public
    id _element;
    ZJBSTNode *_left;// 左节点
    ZJBSTNode *_right;// 右节点
    __weak ZJBSTNode *_parent;// 父节点
}
```

##### ZJBinarySearchTree数据结构

```
@interface ZJBinarySearchTree() {
    NSUInteger _size;// 树大小
    ZJBSTNode *_root;// 根节点
    MJBSTComparatorBlock _comparatorBlock;// 比较器
}
@end
```
### 二叉搜索树实现接口

```
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)add:(id)element;
- (void)remove:(id)element {
    /** 度==2 
     * 拿到前驱节点，
     * 用前驱的值覆盖需要删除的节点的值，
     * 再删除对应的前驱节点
     */
     
     // 度==1，node的父节点直接指向node的child节点
     
     // 度==0，叶子节点直接删除
}
```

```
// 获取节点
- (ZJBSTNode *)node:(id)element {
    ZJBSTNode *node = _root;
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
```

## AVL树
> 是一个平衡二叉搜索树
> * 平衡因子：某节点的左右子树高度差。
> * AVL树，平衡因子1，0，-1.
>
> AVL树失衡情况:
> * LL- 右旋转
> * RR- 左旋转
> * LR- RR（parent）左旋转，LL（grand）右旋转
> * RL- LL（parent）右旋转，RR（grand）左旋转，


##### ZJAVLNode数据结构

```
@interface ZJAVLNode : NSObject {
@public
    id _element;
    ZJAVLNode *_left;
    ZJAVLNode *_right;
    __weak ZJAVLNode *_parent;
    int _height;
}
@end
```

##### ZJAVLTree数据结构

```
@interface ZJAVLTree() {
    NSUInteger _size;
    ZJAVLNode *_root;
    MJBSTComparatorBlock _comparatorBlock;
}
@end
```
### AVL树实现接口

```
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)add:(id)element;
- (void)remove:(id)element;
```

### AVL树恢复平衡

```
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
 *
 * 注意需要维护：c，p, g的parent属性，高度属性（从低到高更新）
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
```







