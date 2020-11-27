//
//  ZJQueue.h
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJQueue : NSObject

- (int)size;
- (BOOL)isEmpty;
- (void)enQueue:(id)element; //入队
- (id)deQueue; // 出队
- (id)front; // 获取队头元素
- (void)clear;

@end

NS_ASSUME_NONNULL_END
