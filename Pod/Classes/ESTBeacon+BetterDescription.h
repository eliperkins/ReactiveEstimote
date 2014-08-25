//
//  ESTBeacon+BetterDescription.h
//  EstimoteTest
//
//  Created by Eli Perkins on 8/22/14.
//  Copyright (c) 2014 Eli Perkins. All rights reserved.
//

#import "ESTBeacon.h"

@interface ESTBeacon (BetterDescription)

/// A description which returns major, minor, UUID and distance
- (NSString *)description;

@end
