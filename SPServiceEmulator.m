//
//  SPServiceEmulator.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPServiceEmulator.h"


@implementation SPServiceEmulator
#pragma mark -
#pragma mark - Class Propeties
@synthesize query = _query;
@synthesize types = _types;

#pragma mark - 
#pragma mark - Unimplemented Customed Methods


-(void)fetchRandomShopping:(CLLocation *) location WithCompletionHandler:(void (^)(SPAddresses *, NSError *))block{
    
    ;
}

-(void)performRequest:(NSURLRequest *)request{
    
    ;
}


@end
