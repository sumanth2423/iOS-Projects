//
//  YQL.h
//  MyLocation
//
//  Created by Srinivas Pasupuleti on 5/31/15.
//  Copyright (c) 2015 Vasu Pasupuleti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQL : NSObject

- (NSDictionary *)query:(NSString *)statement;

@end

