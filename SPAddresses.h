//
//  SPAddresses.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAddresses : NSObject

@property (strong, nonatomic) NSMutableArray * addresses;

-(void)performAddressOperation:(NSDictionary *) dictionary;
@end
