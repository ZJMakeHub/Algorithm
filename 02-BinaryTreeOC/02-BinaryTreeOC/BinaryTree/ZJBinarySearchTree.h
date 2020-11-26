//
//  ZJBinarySearchTree.h
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import <Foundation/Foundation.h>
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN



typedef int (^MJBSTComparatorBlock)(id e1, id e2);

@interface ZJBinarySearchTree : NSObject <MJBinaryTreeInfo>

- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)add:(id)element;
- (void)remove:(id)element;

+ (instancetype)tree;
+ (instancetype)treeWithComparatorBlock:(_Nullable MJBSTComparatorBlock)comparatorBlock;

// 二叉搜索树遍历
- (void)preorderTraversal;
- (void)inorderTraversal;
- (void)postorderTraversal;

@end

NS_ASSUME_NONNULL_END
