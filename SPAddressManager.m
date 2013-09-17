//
//  SPAddressManager.m
//  spara
//
//  Created by Adex on 10/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPAddressManager.h"
#import "SPServiceController.h"
#import "SPSearchService.h"
#import "SPNearbyService.h"
#import "SPAddresses.h"




@implementation SPAddressManager
@synthesize searchService = _searchService;
@synthesize nearbyService = _nearbyService;

+(id)allocWithZone:(NSZone *)zone{
    
    return [self defaultAddressManager];
}

+(SPAddressManager *)defaultAddressManager{
    
    static SPAddressManager * addressManager = nil;
    
    if (!addressManager) {
        
        addressManager = [[super allocWithZone:nil] init];
    }
    
    return addressManager;
}

-(void)executeServiceEmulator:(NSInteger) kEmulatorConstant{
    
    switch (kEmulatorConstant) {
        case kServiceEmulatorSearch :{
            
            self.searchService = (SPSearchService *) [SPServiceController performEmurateOperation:kServiceEmulatorSearch];
        }
        break;
        
        case kServiceEmulatorNearby :{
            
            self.nearbyService = (SPNearbyService *) [SPServiceController performEmurateOperation:kServiceEmulatorNearby];
        }
        break;
            
        default:
            break;
    }
}

@end
