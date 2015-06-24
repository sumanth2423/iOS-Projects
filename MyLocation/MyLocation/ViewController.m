//
//  ViewController.m
//  MyLocation
//
//  Created by Srinivas Pasupuleti on 5/27/15.
//  Copyright (c) 2015 Vasu Pasupuleti. All rights reserved.
//

#import "ViewController.h"

#define QUERY_PREFIX @"http://query.yahooapis.com/v1/public/yql?q="
#define QUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="


@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController
CLGeocoder *geocoder;
CLPlacemark *placemark;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    [self.addressLabel sizeToFit];
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    NSLog(@"Current Radio Access Technology: %@", telephonyInfo.currentRadioAccessTechnology);
    [NSNotificationCenter.defaultCenter addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification *note)
     {
         NSLog(@"New Radio Access Technology: %@", telephonyInfo.currentRadioAccessTechnology);
     }];
    
    
    NSURL *stockURL = [NSURL URLWithString:@"https://www.quandl.com/api/v1/datasets/WIKI/AAPL.json?auth_token=CzZc16Mp9L1NGYeycf3N&trim_start=2015-05-24"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:stockURL];
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSLog(@"----START-----");
    NSLog(@"dictionary %@",[dataDictionary objectForKey:@"data"]);
    NSLog(@"----END-----");

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
       NSLog(@"location pressed");
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    static CLLocation *prevLocation = nil;
    
    if (currentLocation != nil) {
        self.longitudeLabel.text = [NSString stringWithFormat:@"%-2.8f", currentLocation.coordinate.longitude];
        self.latitudeLabel.text = [NSString stringWithFormat:@"%-2.8f", currentLocation.coordinate.latitude];
    }
    
    // Stop Location Manager
    //[self.locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    prevLocation = currentLocation;
}

//// Location Manager Delegate Methods
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    NSLog(@"hello %@", [locations lastObject]);
//}

@end
