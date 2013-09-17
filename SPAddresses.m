//
//  SPAddresses.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPAddresses.h"

@implementation SPAddresses
#pragma mark -
#pragma mark - Class Properties
@synthesize addresses = _addresses;

#pragma mark - 
#pragma mark - Generic Methods

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.addresses = [NSMutableArray array];
    }
    
    return self;
}

-(void)performAddressOperation:(NSDictionary *)dictionary{
    
    NSArray * results = [dictionary valueForKey:@"results"];

    for (NSDictionary * serviceInformation in results) {
        
        [self.addresses addObject:serviceInformation];
    }
}
@end
