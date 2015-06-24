//
//  Data.h
//  Quotes
//
//  Created by Srinivas Pasupuleti on 4/24/15.
//  Copyright (c) 2015 vasu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
@property(nonatomic,strong) NSArray *quotes;
@property(nonatomic,strong) NSArray *colors;
@property(nonatomic,strong) NSArray *chocolateBox;

-(int)randomQuote;
-(int)randomColor;
-(void)initrandomQuote;
-(void)initrandomColor;
@end
