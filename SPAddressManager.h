//
//  SPAddressManager.h
//  spara
//
//  Created by Adex on 10/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPServiceEmulator.h"

@class SPSearchService;
@class SPNearbyService;
@interface SPAddressManager : NSObject

@property (strong, nonatomic) SPSearchService * searchService;
@property (strong, nonatomic) SPNearbyService * nearbyService;

+(SPAddressManager *)defaultAddressManager;
-(void)executeServiceEmulator:(NSInteger) kEmulatorConstant;

@end
