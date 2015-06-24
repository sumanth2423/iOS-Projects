//
//  ViewController.h
//  MyLocation
//
//  Created by Srinivas Pasupuleti on 5/27/15.
//  Copyright (c) 2015 Vasu Pasupuleti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)getCurrentLocation:(id)sender;

@end

