//
//  RAppDelegate.m
//  Raining
//
//  Created by Asfanur Arafin on 27/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import "RAppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation RAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return YES;
}
							
 
@end
