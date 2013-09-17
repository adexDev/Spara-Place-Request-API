//
//  SPServiceConnection.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPAddresses;
@interface SPServiceConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic) BOOL isConnecting ;

-(id)initWithRequest:(NSURLRequest *) request;
-(void)connectionWithCompletionHandler:(void (^)(SPAddresses * address, NSError * error))block;
-(void)cancelConnection;

@end
