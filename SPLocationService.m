//
//  SPLocationService.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPLocationService.h"

@interface SPLocationService ()

@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) void (^ completionHandler)(CLLocation * location);

@end

@implementation SPLocationService

#pragma mark -
#pragma mark - Class Properties
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize completionHandler = _completionHandler;

#pragma mark - 
#pragma mark - Generic Methods

+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedLocationService];
}


#pragma mark -
#pragma mark - Customed Methods

+(SPLocationService *)sharedLocationService{
    
    static SPLocationService * locationService = nil;
    
    if (!locationService) {
        
        locationService = [[super allocWithZone:nil] init];
    }
    
    return locationService;
}


-(void)updateLocationWithCompletion:(void (^)(CLLocation *))block{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.completionHandler = block;
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1;
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
        
    }else{
        
        NSLog(@"Location Service is Unavaalable");
    }
}


#pragma mark -
#pragma mark - CLLocationManager Delegate Methods


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    self.completionHandler([locations lastObject]);
    [_locationManager stopUpdatingLocation];
    
}

// Get locationManager error
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    // Check if there is error when trying to update
    if (error) {
        
        NSString * errorMessage = [NSString stringWithFormat:@"%@", [error description]];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Location Failure"
                                                             message:errorMessage
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Retry", nil];
        [alertView show];
        [_locationManager stopUpdatingLocation];
    }
}





@end
