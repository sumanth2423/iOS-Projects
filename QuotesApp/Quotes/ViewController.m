//
//  ViewController.m
//  Quotes
//
//  Created by Srinivas Pasupuleti on 4/24/15.
//  Copyright (c) 2015 vasu.com. All rights reserved.
//

#import "ViewController.h"
#import "Data.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.shoppingList = [[NSArray alloc]initWithObjects:@"toothpaste", @"bread", @"eggs",nil];
    // Add your code below!
    NSLog(@"%@",[self.shoppingList objectAtIndex:2]);
    
    self.shoppingCart =[self.shoppingList objectAtIndex:2];
    self.myData = [[Data alloc]init];
    [self.myData initrandomQuote];
    [self.myData initrandomColor];
    
    self.myQuoteLabel.text = [self.myData.quotes objectAtIndex:[self.myData randomQuote]];
    int color = [self.myData randomColor];
    self.view.backgroundColor = [self.myData.colors objectAtIndex:color];
    self.myQuoteButton.tintColor = [self.myData.colors objectAtIndex:color];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newQuote:(id)sender {
    int quote = [self.myData randomQuote];
    int color = [self.myData randomColor];
    self.myQuoteLabel.text = [self.myData.quotes objectAtIndex:quote];
    self.view.backgroundColor = [self.myData.colors objectAtIndex:color];
    self.myQuoteButton.tintColor = [self.myData.colors objectAtIndex:color];

}

@end
