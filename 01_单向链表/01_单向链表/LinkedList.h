//
//  LinkedList.h
//  01_单向链表
//
//  Created by zj on 2020/5/18.
//  Copyright © 2020 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface LinkedList<ObjectType> : NSObject

///count
@property (nonatomic,assign) NSInteger count;

#pragma mark - 暴露方法
/**
 * 清除所有元素
 */
- (void)clear;

/**
 * 是否为空
 * @return bool
 */
- (BOOL)isEmpty;

/**
 * 是否包含某个元素
 * @return BOOL
 */
- (BOOL)containsObject:(ObjectType)object;

/**
 * 添加元素到尾部
 * @param object obj
 */
- (void)addObjectAtLast:(ObjectType)object;

/**
 * 获取index位置的元素
 * @param index 1
 * @return E
 */
- (ObjectType)objectAtIndex:(NSInteger)index;

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
 * 查看元素的索引
 * @param object e
 * @return 1
 */
- (int)indexOf:(ObjectType)object;

/**
 * 打印链表
 */
- (NSMutableString *)list_display;

@end

NS_ASSUME_NONNULL_END
