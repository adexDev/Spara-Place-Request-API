//
//  SPNearbyService.m
//  spara
//
//  Created by Adex on 11/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPNearbyService.h"
#import "SPServiceConnection.h"

@interface SPNearbyService ()

@property (strong, nonatomic) void(^completionHandler) (SPAddresses * address, NSError * error );

@end

@implementation SPNearbyService

#pragma mark - 
#pragma mark - Class Properties

@synthesize completionHandler = _completionHandler;

#pragma mark - 
#pragma mark - Generic Methods

+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedNearbyService];
}

#pragma mark - 
#pragma mark - Customed Methods

+(SPNearbyService *)sharedNearbyService{
    
    static SPNearbyService * nearbyService = nil;
    
    if (!nearbyService) {
        
        nearbyService = [[super allocWithZone:nil] init];
    }
    
    return nearbyService;
}

-(void)fetchRandomShopping:(CLLocation *)location WithCompletionHandler:(void (^)(SPAddresses *, NSError *))block{
    
    self.completionHandler = block;
    float latitude = location.coordinate.latitude; 
    float longitude = location.coordinate.longitude; 
    NSString * string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/%@?location=%f,%f&radius=%i&sensor=%@&key=%@",
                         kParameterOutputJSON, latitude, longitude, kParameterRadius, kParameterSensor, kParameterDeveloperTokenKey];
    
    NSURL * url = [NSURL URLWithString:string];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [self performRequest:request];
    
    
}

-(void)performRequest:(NSURLRequest *)request{
    
    SPServiceConnection * connection = [[SPServiceConnection alloc] initWithRequest:request];
    [connection connectionWithCompletionHandler:^(SPAddresses * address, NSError * error){
        
        if (self.completionHandler && !error) {
            
            self.completionHandler (address, nil);
            
        }else{
            
            self.completionHandler (nil, error);
            NSLog(@"Treat the error in SPSearchService : %@", error.description);
        }
    }];
}












@end
