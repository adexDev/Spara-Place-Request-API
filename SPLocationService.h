//
//  SPLocationService.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLocationService : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation * currentLocation;

+(SPLocationService *)sharedLocationService;
-(void)updateLocationWithCompletion:(void(^)(CLLocation * location))block;
@end
