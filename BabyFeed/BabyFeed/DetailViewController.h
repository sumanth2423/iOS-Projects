//
//  DetailViewController.h
//  BabyFeed
//
//  Created by Srinivas Pasupuleti on 7/9/15.
//  Copyright © 2015 Vasu Pasupuleti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

