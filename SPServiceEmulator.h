//
//  SPServiceEmulator.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SPAddresses;
@interface SPServiceEmulator : NSObject


@property (strong, nonatomic) NSString * query;
@property (strong, nonatomic) NSString * types;





-(void)fetchRandomShopping:(CLLocation *) location  WithCompletionHandler:(void (^)(SPAddresses * addresses, NSError * error))block;
-(void)performRequest:(NSURLRequest *) request;

@end
