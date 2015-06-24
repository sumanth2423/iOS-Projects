//
//  ViewController.m
//  HW02
//
//  Created by Srinivas Pasupuleti on 6/16/15.
//  Copyright © 2015 Vasu Pasupuleti. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <MapKit/MKUserLocation.h>
#import <MapKit/MKPointAnnotation.h>
#import <MapKit/MKPinAnnotationView.h>

@interface ViewController ()
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation ViewController
CLGeocoder *geocoder;
CLPlacemark *placemark;
NSString *longitudeLabel;
NSString *latitudeLabel;
NSString *addressLabel;
CLGeocoder *newgeocoder;
CLPlacemark *newplacemark;
CLLocation *currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    newgeocoder = [[CLGeocoder alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // There is not a camera on this device, so don't show the camera button.
        NSMutableArray *toolbarItems = [self.showToolBar.items mutableCopy];
        [toolbarItems removeObjectAtIndex:2];
        [self.showToolBar setItems:toolbarItems animated:NO];
    }
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //user needs to press for 2 seconds
    [self.showMap addGestureRecognizer:lpgr];
    
    self.showMap.delegate = self;
    self.showMap.hidden = YES;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *addressString = [NSString stringWithFormat:@"%@,%@",[alertView textFieldAtIndex:0].text,[alertView textFieldAtIndex:1].text];
    
    [newgeocoder geocodeAddressString:(NSString *)addressString completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            newplacemark = [placemarks lastObject];
            addressLabel = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                            newplacemark.subThoroughfare, newplacemark.thoroughfare,
                            newplacemark.postalCode, newplacemark.locality,
                            newplacemark.administrativeArea,
                            newplacemark.country];
           // NSLog(@"location %@\n latitude %f longitude %f",addressLabel, newplacemark.location.coordinate.latitude, newplacemark.location.coordinate.longitude);
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newplacemark.location.coordinate, 800, 800);
            [self.showMap setRegion:[self.showMap regionThatFits:region] animated:YES];
            
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = newplacemark.location.coordinate;
            //TODO: get the placemark from the current co-ordinate
            
            point.title = [NSString stringWithFormat:@"%@ %@", [alertView textFieldAtIndex:0].text,[alertView textFieldAtIndex:1].text];
            
            [self.showMap addAnnotation:point];
            [self.showMap selectAnnotation:point animated:YES];
            
        } else {
            NSLog(@"%@", error.debugDescription);
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Error" message:@"Failed to Resolve Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];

        }
    } ];

}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.showMap];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.showMap convertPoint:touchPoint toCoordinateFromView:self.showMap];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = touchMapCoordinate;
    
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    [newgeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            newplacemark = [placemarks lastObject];
            addressLabel = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                            newplacemark.subThoroughfare, newplacemark.thoroughfare,
                            newplacemark.postalCode, newplacemark.locality,
                            newplacemark.administrativeArea,
                            newplacemark.country];
            point.title = [NSString stringWithFormat:@"%@ %@", newplacemark.subThoroughfare, newplacemark.thoroughfare];
            point.subtitle = [NSString stringWithFormat:@"%@ %@ %@ %@", newplacemark.locality,newplacemark.postalCode,newplacemark.administrativeArea,newplacemark.country];
            
            
            [self.showMap addAnnotation:point];
            [self.showMap selectAnnotation:point animated:YES];
            
        } else {
            NSLog(@"%@", error.debugDescription);
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Error" message:@"Failed to Resolve Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];

        }
    } ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showPhotoLibrary:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];

}
- (IBAction)showCamera:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate

- (void) processPhotoCoordsfromLibrary:(NSDictionary*) info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.showPic.image= image;
    
    @try {
        
        NSURL *photoUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        //Block the Asset's Library Calls
        ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset) {
            if (asset) {
                id c = [asset valueForProperty:ALAssetPropertyLocation];
                if (c)
                {
                    CLLocation *cl = (CLLocation *) c;
                    CLLocationCoordinate2D coord = [cl coordinate];
                 //   NSLog(@"%f %f",coord.latitude, coord.longitude);
                    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
                    [self.showMap setRegion:[self.showMap regionThatFits:region] animated:YES];
                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                    point.coordinate = coord;
                   
                    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
                    
                    [newgeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
                        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
                        if (error == nil && [placemarks count] > 0) {
                            newplacemark = [placemarks lastObject];
                            addressLabel = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                            newplacemark.subThoroughfare, newplacemark.thoroughfare,
                                            newplacemark.postalCode, newplacemark.locality,
                                            newplacemark.administrativeArea,
                                            newplacemark.country];
                            point.title = [NSString stringWithFormat:@"%@ %@", newplacemark.subThoroughfare, newplacemark.thoroughfare];
                            point.subtitle = [NSString stringWithFormat:@"%@ %@ %@ %@", newplacemark.locality,newplacemark.postalCode,newplacemark.administrativeArea,newplacemark.country];
                            
                            
                            [self.showMap addAnnotation:point];
                            [self.showMap selectAnnotation:point animated:YES];

                        } else {
                            NSLog(@"%@", error.debugDescription);
                            //TODO: show alert failed to resolve location
                        }
                    } ];
                    
                    
                }
                else
                {
                    NSLog(@"location unavailable");
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Location" message:@"Please enter City and State Name (USA)." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
                    [alert textFieldAtIndex:1].secureTextEntry = NO; //Will disable secure text entry for second textfield.
                    [alert textFieldAtIndex:0].placeholder = @"City Name"; //Will replace "Username"
                    [alert textFieldAtIndex:1].placeholder = @"State Name"; //Will replace "Password"
                    [alert show];
                    

                }
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error){
            UIAlertView *perr =
            [[UIAlertView alloc] initWithTitle:@"location"
                                       message:error.localizedDescription
                                      delegate:nil
                             cancelButtonTitle:@"Ok"
                             otherButtonTitles:nil,
             nil];
            [perr show];
            
        };
        
        ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary assetForURL:photoUrl
                       resultBlock:resultsBlock
                      failureBlock:failureBlock];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception=%@",[exception reason]);
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Failed to Resolve Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];

    }
}


- (void) processPhotoCoordsfromCamera:(NSDictionary*) info
{
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
  self.showPic.image= image;
    
 
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 800, 800);
  [self.showMap setRegion:[self.showMap regionThatFits:region] animated:YES];
  
  
  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
  point.coordinate = currentLocation.coordinate;
  
  [newgeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
    if (error == nil && [placemarks count] > 0) {
      newplacemark = [placemarks lastObject];
      addressLabel = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                      newplacemark.subThoroughfare, newplacemark.thoroughfare,
                      newplacemark.postalCode, newplacemark.locality,
                      newplacemark.administrativeArea,
                      newplacemark.country];
      point.title = [NSString stringWithFormat:@"%@ %@", newplacemark.subThoroughfare, newplacemark.thoroughfare];
      point.subtitle = [NSString stringWithFormat:@"%@ %@ %@ %@", newplacemark.locality,newplacemark.postalCode,newplacemark.administrativeArea,newplacemark.country];
      
      
      [self.showMap addAnnotation:point];
      [self.showMap selectAnnotation:point animated:YES];
      
    } else {
      NSLog(@"%@", error.debugDescription);
      UIAlertView *errorAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Error" message:@"Failed to Resolve Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [errorAlert show];

    }
  } ];


    
    
}

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if([picker sourceType] == UIImagePickerControllerSourceTypeCamera)
    {
        [self processPhotoCoordsfromCamera:info];
    }
    else
    {
        [self processPhotoCoordsfromLibrary:info];
    }
    
    self.showMap.hidden = NO;
    self.introLabel.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
   // NSLog(@"didUpdateToLocation: %@", newLocation);
    currentLocation = newLocation;
    static CLLocation *prevLocation = nil;

    
    if (currentLocation != nil) {
        longitudeLabel = [NSString stringWithFormat:@"%-2.8f", currentLocation.coordinate.longitude];
        latitudeLabel = [NSString stringWithFormat:@"%-2.8f", currentLocation.coordinate.latitude];
    }
    
    // Stop Location Manager
    [self.locationManager stopUpdatingLocation];
    
   // NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            addressLabel = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                      placemark.subThoroughfare, placemark.thoroughfare,
                                      placemark.postalCode, placemark.locality,
                                      placemark.administrativeArea,
                                      placemark.country];
        } else {
            
            NSLog(@"%@", error.debugDescription);
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Error" message:@"Failed to Resolve Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
        }
    } ];
    
    prevLocation = currentLocation;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
        static NSString* shopAnnotationIdentifier = @"ShopAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.showMap dequeueReusableAnnotationViewWithIdentifier:shopAnnotationIdentifier ];
        if (!pinView) {
            // If an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:shopAnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
           // UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
           // customPinView.rightCalloutAccessoryView = rightButton;
            
            
            return customPinView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }



@end
