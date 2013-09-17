//
//  SPGeocodingService.m
//  spara
//
//  Created by amaCoder on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPGeocodingService.h"


@interface SPGeocodingService ()

@property (strong, nonatomic) CLPlacemark * placemark;
@property (strong, nonatomic) CLLocation * currentLocation;
@property (strong, nonatomic) void (^completionHandler)(CLPlacemark * placemark);
@property (strong, nonatomic) void (^completion)(NSDictionary * placemark);

-(void)dictionaryPlacemark;
-(void)dictionaryPlacemarkWithCompletion:(void (^)(CLPlacemark * placemark))block;

@end

// Configure this to typedef enum later
NSString * addressDictionary = @"addressDictionary";
NSString * country = @"country";
NSString * locality = @"locality";
NSString * location = @"location";
NSString * region = @"region";

@implementation SPGeocodingService

#pragma mark -
#pragma mark - Class Properties
@synthesize placemark = _placemark;
@synthesize currentLocation = _currentLocation;
@synthesize addressWithInformation = _addressWithInformation;
@synthesize completionHandler = _completionHandler;
@synthesize completion = _completion;

#pragma mark - 
#pragma mark - Generic Methods
-(id)initWithLocation:(CLLocation *)location{
    
    self = [super init];
    
    if (self) {
        
        self.currentLocation = location;
         
    }
    
    return self;
}



#pragma mark -
#pragma mark - Customed Methods

-(void)reverseGeocodingParser{
    
    __weak SPGeocodingService * weakSelf = self;
    
               CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
                            [geoCoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray * placeMarks, NSError * error){
                                
                                if (error) {
                                    
                                    NSString * errorMessage = [NSString stringWithFormat:@"%@", [error description]];
                                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Geocoding Failure"
                                                                                         message:errorMessage
                                                                                        delegate:self
                                                                               cancelButtonTitle:@"Cancel"
                                                                               otherButtonTitles:@"Retry", nil];
                                    [alertView show];
                                }else{
                                    
                                    weakSelf.completionHandler ([placeMarks lastObject]);
                                     
                                }
                                      
                                
                            }];
   
	
}


-(void)dictionaryPlacemark{
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	
                         [dictionary setValue:self.placemark.addressDictionary forKey:addressDictionary];
                         [dictionary setValue:self.placemark.country forKey:country];
                         [dictionary setValue:self.placemark.locality forKey:locality];
                         [dictionary setValue:self.placemark.location forKey:location];
                         [dictionary setValue:self.placemark.region forKey:region];
    self.completion(dictionary);
}

-(void)dictionaryPlacemarkWithCompletion:(void (^)(CLPlacemark * placemark))block{
    
    self.completionHandler = block;
    [self reverseGeocodingParser];
}

-(void)placemarkAddress:(void (^)(NSDictionary *))block{
    
    self.completion = block;
    [self dictionaryPlacemarkWithCompletion:^(CLPlacemark * place){
        
                 dispatch_async(dispatch_get_main_queue(), ^{
            
                 self.placemark = place;
                 [self dictionaryPlacemark];
                 });
    }];
    
}

@end
