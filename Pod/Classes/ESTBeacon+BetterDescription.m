//
//  ESTBeacon+BetterDescription.m
//  EstimoteTest
//
//  Created by Eli Perkins on 8/22/14.
//  Copyright (c) 2014 Eli Perkins. All rights reserved.
//

#import "ESTBeacon+BetterDescription.h"

@implementation ESTBeacon (BetterDescription)

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>: %@ major: %@, minor: %@, RSSI: %ld, distance: %@", NSStringFromClass(self.class), self, self.proximityUUID.UUIDString, self.major, self.minor, (long)self.rssi, self.distance];
}

@end
