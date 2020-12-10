//
//  ZJRedBTree.h
//  02-BinaryTreeOC
//
//  Created by zj on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN


typedef int (^MJBSTComparatorBlock)(id e1, id e2);

@interface ZJRedBTree : NSObject<MJBinaryTreeInfo>

- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)add:(id)element;
- (void)remove:(id)element;

+ (instancetype)tree;
+ (instancetype)treeWithComparatorBlock:(_Nullable MJBSTComparatorBlock)comparatorBlock;

@end

NS_ASSUME_NONNULL_END

