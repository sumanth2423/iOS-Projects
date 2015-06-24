//
//  ViewController.h
//  HW02
//
//  Created by Srinivas Pasupuleti on 6/16/15.
//  Copyright © 2015 Vasu Pasupuleti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKMapView.h>


@interface ViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate, MKMapViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *showToolBar;

@property (weak, nonatomic) IBOutlet UIImageView *showPic;
@property (weak, nonatomic) IBOutlet MKMapView *showMap;
@property (weak, nonatomic) IBOutlet UITextView *introLabel;

@end

