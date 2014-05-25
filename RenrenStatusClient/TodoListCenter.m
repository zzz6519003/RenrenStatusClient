//
//  TodoListCenter.m
//  RenrenStatusClient
//
//  Created by Snowmanzzz on 5/25/14.
//  Copyright (c) 2014 zzz. All rights reserved.
//

#import "TodoListCenter.h"

@interface TodoListCenter ()


@end

@implementation TodoListCenter

+ (TodoListCenter *)sharedTodoListCenter {
    static TodoListCenter *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TodoListCenter alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        _statusArray = [@[] mutableCopy];
    }
    return _statusArray;
}

- (void)addStatus:(NSString *)statusString {
    [self.statusArray addObject:statusString];
}

- (void)removeAll {
    [self.statusArray removeAllObjects];
}

- (void)removeStatusAtPos:(NSInteger)pos {
    //TODO
}

@end
