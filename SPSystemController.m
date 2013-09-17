//
//  SPSystemController.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPSystemController.h"
#import "SPLocationService.h"
#import "SPGeocodingService.h"
#import "SPAddressManager.h"
#import "SPSearchService.h"
#import "SPNearbyService.h"
#import "SPAddresses.h"


@interface SPSystemController (){
    
  SPAddressManager * addressManager;
    
}

@property (strong, nonatomic) SPLocationService * locationService;
@property (strong, nonatomic) void(^ addressCompletion)(NSDictionary * address);
@property (strong, nonatomic) void(^ completionHandler)(SPAddresses * address, NSError * error);

-(void)geocodeServiceAddress:(CLLocation *)location;
-(void)performQueryExecution;
-(void)performNearbyExecution;


@end

@implementation SPSystemController

#pragma mark -
#pragma mark - Class Properties 
@synthesize addressCompletion = _addressCompletion;
@synthesize locationService = _locationService;
@synthesize completionHandler = _completionHandler;
@synthesize query = _query;
@synthesize types = _types;

#pragma mark -
#pragma mark - Generic Methods
-(id)init{
    
    self = [super init];
    
    if (self) {
        
            }
    
    return self;
}
+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedSystemController];
}

#pragma mark - 
#pragma mark - Customed Methods

+(SPSystemController *)sharedSystemController{
    
    static SPSystemController * systemController = nil;
    if (!systemController) {
        
        systemController = [[super allocWithZone:nil] init];
    }
    
    return systemController;
}

-(void)startUpdatingLocation{
    
    self.locationService = [SPLocationService sharedLocationService];
                           [_locationService updateLocationWithCompletion:^(CLLocation * location){
        
                           [self geocodeServiceAddress:location];
                               
                           }];
    
}

-(void)geocodeServiceAddress:(CLLocation *)location{
    
  
        // Initialize the GeocodingService Class using the new location data
        SPGeocodingService * geocodingService = [[SPGeocodingService alloc] initWithLocation:location];
                                                [geocodingService placemarkAddress:^(NSDictionary * dictionary){
               
                                                 self.addressCompletion(dictionary);
            
                                                 }];
    
}

-(void)fetchCurrentAddress:(void (^)(NSDictionary *))block{
    
    self.addressCompletion = block;
    [self startUpdatingLocation];
    
}

-(void)performQueryExecution{
    
    [addressManager.searchService fetchRandomShopping:nil WithCompletionHandler:^(SPAddresses * address, NSError * error){
        
        if (error) {
            
            NSLog(@"Failed to get addresses in Address Manager For Search Service: %@", error.description);
            self.completionHandler(nil, error);
        }else{
            
            self.completionHandler(address, nil);
        }
        
    }];
    
}

-(void)performNearbyExecution{
    
    self.locationService = [SPLocationService sharedLocationService];
    [_locationService updateLocationWithCompletion:^(CLLocation * location){
        
        [addressManager.nearbyService fetchRandomShopping:location WithCompletionHandler:^(SPAddresses * address, NSError * error){
            
            if (error) {
                
                NSLog(@"Failed to get addresses in Address Manager For Nearby Service : %@", error.description);
                self.completionHandler(nil, error);
            }else{
                
                self.completionHandler(address, nil);
            }
        }];
        
    }];
    
   
}

-(void)businessServiceAddresses:(NSInteger ) kServiceEmulator withCompletion:(void (^)(SPAddresses *, NSError *))block{
    
    self.completionHandler = block;
    
    
    
    
    switch (kServiceEmulator) {
        case kServiceEmulatorSearch:{
            
            addressManager = [SPAddressManager defaultAddressManager];
            [addressManager executeServiceEmulator:kServiceEmulatorSearch];
            addressManager.searchService.query = self.query;
            addressManager.searchService.types = self.types;
            [self performQueryExecution];
            
        }
        break;
            
        case kServiceEmulatorNearby:{
            
            addressManager = [SPAddressManager defaultAddressManager];
            [addressManager executeServiceEmulator:kServiceEmulatorNearby];
            addressManager.nearbyService.types = self.types;
            [self performNearbyExecution];
        }
        break;
            
        default:
            break;
    }
    
}




@end
