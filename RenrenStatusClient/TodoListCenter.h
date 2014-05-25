//
//  TodoListCenter.h
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 5/25/14.
//  Copyright (c) 2014 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoListCenter : NSObject

+ (TodoListCenter *)sharedTodoListCenter;

- (void)addStatus:(NSString *)statusString;

- (void)removeAll;

- (void)removeStatusAtPos:(NSInteger)pos;

@end
