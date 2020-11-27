//
//  ZJDoubleLinkedList.h
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJDoubleLinkedList : NSObject

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

// 打印链表
- (NSMutableString *)toString;

@end

NS_ASSUME_NONNULL_END
