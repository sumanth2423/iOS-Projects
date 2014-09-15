//
//  ToDoItem.h
//  ToDoList
//
//  Created by Srinivas Pasupuleti on 9/13/14.
//  Copyright (c) 2014 Srinivas Pasupuleti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
