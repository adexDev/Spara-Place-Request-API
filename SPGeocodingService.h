//
//  SPGeocodingService.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPGeocodingService : NSObject


@property (strong, nonatomic) NSDictionary * addressWithInformation;

-(id)initWithLocation:(CLLocation *) location;
-(void)reverseGeocodingParser;
-(void)placemarkAddress:(void (^)(NSDictionary * dictionary))block;

@end
