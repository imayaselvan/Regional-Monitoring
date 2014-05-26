//
//  AppDelegate.h
//  RegionChange
//
//  Created by imayaselvan r. on 14/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLAvailability.h>

#import <Foundation/Foundation.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *cllocation;
    UIBackgroundTaskIdentifier bgTask;
    CLLocationCoordinate2D HomeLatLong;
    CLRegion *MyHome;
    BOOL checkedin;

}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property(strong,nonatomic) UILocalNotification *RegionNotification ;
@property(nonatomic,nonatomic)BOOL checkedin;

@end
