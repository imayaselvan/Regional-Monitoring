//
//  AppDelegate.m
//  RegionChange
//
//  Created by imayaselvan r. on 14/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate
@synthesize checkedin;
@synthesize window = _window;
@synthesize viewController = _viewController,RegionNotification;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    checkedin=YES;
    RegionNotification = [[UILocalNotification alloc] init];
    cllocation = [[CLLocationManager alloc] init];
    [cllocation setDelegate:self];
    HomeLatLong =CLLocationCoordinate2DMake(8.110585,8.110585);
    MyHome = [[CLRegion alloc]
                            initCircularRegionWithCenter:HomeLatLong
                            radius:10
                            identifier:@"Imay"];
    [cllocation setDesiredAccuracy:kCLLocationAccuracyBest];
    [cllocation setDistanceFilter:kCLDistanceFilterNone];
    [cllocation startMonitoringForRegion:MyHome
                         desiredAccuracy:1.0 ];
   
    /*
    if (cllocation.locationServicesEnabled == NO) {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
        [servicesDisabledAlert release];
    }
*/
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler:
              ^{
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
                  
                  [cllocation startMonitoringForRegion:MyHome
                                       desiredAccuracy:kCLLocationAccuracyBest];
                  
                  

              }];

}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
   
    NSLog(@"didenterregion");
    RegionNotification.fireDate = [NSDate date];
    RegionNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    RegionNotification.alertBody = @"Notification triggered ";
    RegionNotification.alertAction = @"You Are Near To Imay's Home";
    [[UIApplication sharedApplication] scheduleLocalNotification:RegionNotification];
    [RegionNotification release];
    
}
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{

    NSLog(@"didexitregion");
    RegionNotification.fireDate = [NSDate date];
    RegionNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    RegionNotification.alertBody = @"Notification triggered ";
    RegionNotification.alertAction = @"You Are Away from  Imay's Home";
    [[UIApplication sharedApplication] scheduleLocalNotification:RegionNotification];
    [RegionNotification release];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
  
}

-(void) sendForgroundLocationToServer:(CLLocation *)location{
    
    
}

-(void) sendBackgroundLocationToServer:(CLLocation *)location
{
    // REMEMBER. We are running in the background if this is being executed.
    // We can't assume normal network access.
    // bgTask is defined as an instance variable of type UIBackgroundTaskIdentifier
    
    // Note that the expiration handler block simply ends the task. It is important that we always
    // end tasks that we have started.
    
    bgTask = [[UIApplication sharedApplication]
              beginBackgroundTaskWithExpirationHandler:
              ^{
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
              }];
    
    // ANY CODE WE PUT HERE IS OUR BACKGROUND TASK
    
    // For example, I can do a series of SYNCHRONOUS network methods (we're in the background, there is
    // no UI to block so synchronous is the correct approach here).
    
    // ...
    
    // AFTER ALL THE UPDATES, close the task
    
    /*
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = [NSDate date];
    localNotif.timeZone = [NSTimeZone systemTimeZone];
	
	// Notification details
    localNotif.alertBody = @"Location Updated in back server";
	// Set the action button
    localNotif.alertAction = @"View";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    if (bgTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;}*/
    
    
          
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
	NSLog(@"Recieved Notification %@",notif);
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"monitoringDidFailForRegion");
}
- (void)startMonitoringSignificantLocationChanges{
    
    NSLog(@"Start monitoring");
}
@end
