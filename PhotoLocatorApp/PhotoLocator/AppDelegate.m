//
//  AppDelegate.m
//  HW02
//
//  Created by Srinivas Pasupuleti on 6/16/15.
//  Copyright © 2015 Vasu Pasupuleti. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    NSLog(@"entered background");
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) { //Check if our iOS version supports multitasking I.E iOS 4
        if ([[UIDevice currentDevice] isMultitaskingSupported]) { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance
            
            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            void (^simpleBlock)(void) = ^{
                NSLog(@"shutdown!!");
                [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                
            };
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: simpleBlock];
            //Background tasks require you to use asyncrous tasks
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //Perform your tasks that your application requires
                
                       NSLog(@"\n\nRunning in the background!\n\n");
                
                //[application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                //background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
    }

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
