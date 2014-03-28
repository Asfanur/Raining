//
//  RViewController.m
//  Raining
//
//  Created by Asfanur Arafin on 27/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import "RViewController.h"
#import "RRainView.h"
#import <CoreLocation/CoreLocation.h>
#import "RWeatherClient.h"

@interface RViewController ()<UICollisionBehaviorDelegate,CLLocationManagerDelegate,RWeatherClientDelegate>
@property (weak, nonatomic) IBOutlet RRainView *barrier;
@property(nonatomic, strong) NSTimer *generator;
@property(nonatomic, strong) UIDynamicAnimator *animator;
@property(nonatomic, strong) UIGravityBehavior *gravity;
@property(nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *weatherlebel;
@end

@implementation RViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self startRaining];
    [self.locationManager startUpdatingLocation];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [self stopRaining];
    [super viewDidDisappear:animated];
}

- (void)startRaining
{
    if(self.generator){
        [self.generator invalidate];
        self.generator = nil;
    }
    self.generator = [NSTimer scheduledTimerWithTimeInterval:(.07*(2/1.0)) target:self selector:@selector(addItem:) userInfo:@"rainDrop" repeats:YES];
}

- (void)addItem:(NSTimer *)timer
{
    int x = arc4random()%280;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rainDrop"]];
    imageView.center = CGPointMake(x+60,0.0);
    [self.view addSubview:imageView];
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] initWithItems:@[imageView]];
        _gravity.magnitude = .5;
        [_animator addBehavior:_gravity];
    } else {
        [_gravity addItem:imageView];
    }
    
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] initWithItems:@[imageView]];
        [_collision addBoundaryWithIdentifier:@"barrier" forPath:[self.barrier getBezierPathForView:self.view]];
        [_collision addBoundaryWithIdentifier:@"bottom" fromPoint:CGPointMake(self.view.frame.origin.x,self.view.frame.origin.y + self.view.frame.size.height) toPoint:CGPointMake(self.view.frame.origin.x + self.view.frame.size.width, self.view.frame.origin.y + self.view.frame.size.height)];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        _collision.collisionDelegate = self;
        [_animator addBehavior:_collision];
        
    } else {
        [_collision addItem:imageView];
    }
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    NSString *barrier = (NSString *)identifier;
    
    if ([barrier isEqualToString:@"barrier" ]) {
        UIImageView* view = (UIImageView*)item;
        [UIView animateWithDuration:.7 delay:0 options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             view.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [view removeFromSuperview];
                             [_collision removeItem:view];
                             [_gravity removeItem:view];
                         }];
        
    } else if ([barrier isEqualToString:@"bottom" ]){
        UIImageView* view = (UIImageView*)item;
        [UIView animateWithDuration:.7 delay:0 options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             view.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [view removeFromSuperview];
                             [_collision removeItem:view];
                             [_gravity removeItem:view];
                         }];
    }
}


-(void)stopRaining {
    
    [self.generator invalidate];
    self.generator = nil;
    for(UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *newLocation = [locations lastObject];
    if([newLocation.timestamp timeIntervalSinceNow] > 300)
        return;
    
    [self.locationManager stopUpdatingLocation];
    RWeatherClient *client = [RWeatherClient sharedWeatherHTTPClient];
    client.delegate = self;
    [client updateWeatherAtLocation:newLocation forNumberOfDays:1];
}

- (void)weatherHTTPClient:(RWeatherClient *)client didUpdateWithWeather:(id)weather
{
    NSDictionary *todaysWeather =(NSDictionary *) weather;
    self.weatherlebel.text = [[[todaysWeather valueForKeyPath:@"data.current_condition.weatherDesc.value"] objectAtIndex:0] objectAtIndex:0];
    
}

- (void)weatherHTTPClient:(RWeatherClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


@end
