//
//  ZJBSTNode.h
//  02-BinaryTreeOC
//
//  Created by zj on 2020/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBSTNode : NSObject {
@public
    id _element;
    ZJBSTNode *_left;
    ZJBSTNode *_right;
    __weak ZJBSTNode *_parent;
}

+ (instancetype)nodeWithElement:(id)element parent:(ZJBSTNode *)parent;
- (BOOL)hasTwoChildren;
- (BOOL)isLeaf;

@end

NS_ASSUME_NONNULL_END
