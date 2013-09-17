//
//  SPSystemController.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPAddresses;
@interface SPSystemController : NSObject

@property (strong, nonatomic) NSString * query;
@property (strong, nonatomic) NSString * types;


+(SPSystemController *)sharedSystemController;
-(void)startUpdatingLocation;
-(void)fetchCurrentAddress:(void(^)(NSDictionary * address))block;
-(void)businessServiceAddresses:(NSInteger ) kServiceEmulator withCompletion:(void (^)(SPAddresses * address, NSError * error))block;

@end
