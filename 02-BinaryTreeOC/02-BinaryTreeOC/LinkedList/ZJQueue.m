//
//  ZJQueue.m
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/26.
//

#import "ZJQueue.h"
#import "ZJDoubleLinkedList.h"

@interface ZJQueue () {
    ZJDoubleLinkedList *_list;
}
@end

@implementation ZJQueue

- (instancetype)init {
    if (self = [super init]) {
        _list = [[ZJDoubleLinkedList alloc] init];
    }
    return self;
}

- (int)size {
    return [_list size];
}

- (BOOL)isEmpty {
    return [_list isEmpty];
}

- (void)enQueue:(id)element {
    [_list add:element];
}

- (id)deQueue {
    return [_list remove:0];
}

- (id)front {
    return [_list get:0];
}

- (void)clear {
    
}


@end
