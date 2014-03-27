//
//  RWeatherClient.m
//  Raining
//
//  Created by Asfanur Arafin on 27/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import "RWeatherClient.h"


@implementation RWeatherClient

static NSString * const WorldWeatherOnlineAPIKey = @"h9n37cxeuxteqtrh2hfdxa4n";
static NSString * const WorldWeatherOnlineURLString = @"http://api.worldweatheronline.com/free/v1/";

+ (RWeatherClient *)sharedWeatherHTTPClient
{
    static RWeatherClient *_sharedWeatherHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WorldWeatherOnlineURLString]];
    });
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"num_of_days"] = @(number);
    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    parameters[@"format"] = @"json";
    parameters[@"key"] = WorldWeatherOnlineAPIKey;
    
    [self GET:@"weather.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
            [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
            [self.delegate weatherHTTPClient:self didFailWithError:error];
        }
    }];
}


@end
