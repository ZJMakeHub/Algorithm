//
//  LinkedList.h
//  02_双向链表
//
//  Created by zj on 2020/5/19.
//  Copyright © 2020 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkedList<ObjectType> : NSObject

/**
 * 清除所有元素
 */
- (void)clear;

/**
 * 添加元素到尾部
 * @param object obj
 */
- (void)addObjectAtLast:(ObjectType)object;

/**
 * 在index位置插入一个元素
 * @param object E
 * @param index 1
 */
- (void)addObject:(ObjectType)object atIndex:(NSInteger)index;


/**
 * 删除index位置的元素
 * @param index 1
 * @return E
 */
- (ObjectType)removeObjectAtIndex:(NSInteger)index;

/**
 * 打印链表
 */
- (NSMutableString *)list_display;

@end

NS_ASSUME_NONNULL_END
