//
//  CirleLinkedList.h
//  02_双向链表
//
//  Created by zj on 2020/5/21.
//  Copyright © 2020 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CirleLinkedList<ObjectType> : NSObject
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



/**
 * 重制
 */
- (void)resetNode;

/**
 * 下一个节点
 */
- (ObjectType)nextNode;

/**
 * 删除当前节点
 */
- (ObjectType)removeNode;

/**
 * 是否为空
 */
- (BOOL)isEmpty;


@end

NS_ASSUME_NONNULL_END
