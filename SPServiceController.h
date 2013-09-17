//
//  SPServiceController.h
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SPServiceEmulator;
@interface SPServiceController : NSObject

+(SPServiceEmulator *)performEmurateOperation:(NSInteger)emulatorKey;

@end
