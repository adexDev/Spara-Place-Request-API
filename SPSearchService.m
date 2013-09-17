//
//  SPSearchService.m
//  spara
//
//  Created by Adex on 10/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPSearchService.h"
#import "SPServiceConnection.h"

@interface SPSearchService ()

@property (strong, nonatomic) void(^completionHandler)(SPAddresses * address, NSError * error);

@end

@implementation SPSearchService
#pragma mark - 
#pragma mark - Class Properties
@synthesize completionHandler = _completionHandler;


+(id)allocWithZone:(NSZone *)zone{
    
    return [self sharedSearchService];
}

+(SPSearchService *)sharedSearchService{
    
    static SPSearchService * searchService = nil;
    
    if (!searchService) {
        
        searchService = [[super allocWithZone:nil] init];
    }
    
    return searchService;
}

-(void)fetchRandomShopping:(NSString *)storeIdentifier WithCompletionHandler:(void (^)(SPAddresses *, NSError *))block{
    
    self.completionHandler = block;
    
    NSString * string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/%@?query=%@&sensor=true&type=%@&key=%@",kParameterOutputJSON, self.query,self.types, kParameterDeveloperTokenKey];
    
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
