//
//  RWeatherClient.h
//  Raining
//
//  Created by Asfanur Arafin on 27/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@class RWeatherClient;

@protocol RWeatherClientDelegate <NSObject>
@optional
-(void)weatherHTTPClient:(RWeatherClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHTTPClient:(RWeatherClient *)client didFailWithError:(NSError *)error;
@end


@interface RWeatherClient : AFHTTPSessionManager

@property (nonatomic, weak) id<RWeatherClientDelegate>delegate;

+ (RWeatherClient *)sharedWeatherHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number;

@end

