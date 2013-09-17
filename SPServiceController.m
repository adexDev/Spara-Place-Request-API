//
//  SPServiceController.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPServiceController.h"
#import "SPServiceEmulator.h"
#import "SPSearchService.h"
#import "SPNearbyService.h"

@implementation SPServiceController
#pragma mark -
#pragma mark - Class Properties


#pragma mark -
#pragma mark - Customed Methods

+(SPServiceEmulator *)performEmurateOperation:(NSInteger)emulatorKey{
    
    SPServiceEmulator * serviceEmulator;
    
    switch (emulatorKey) {
        case kServiceEmulatorSearch:
           serviceEmulator = [SPSearchService sharedSearchService];
            break;
        
        case kServiceEmulatorNearby:
            serviceEmulator = [SPNearbyService sharedNearbyService];
            break;
            
        default:
            break;
    }
    
    return serviceEmulator;
}

@end
