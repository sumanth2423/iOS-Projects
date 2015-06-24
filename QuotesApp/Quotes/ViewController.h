//
//  ViewController.h
//  Quotes
//
//  Created by Srinivas Pasupuleti on 4/24/15.
//  Copyright (c) 2015 vasu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Data;

@interface ViewController : UIViewController
@property (strong, nonatomic) NSString *shoppingCart;
@property (strong, nonatomic) NSArray *shoppingList;
@property (strong, nonatomic) Data *myData;
@property (weak, nonatomic) IBOutlet UILabel *myQuoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *myQuoteButton;
@end

