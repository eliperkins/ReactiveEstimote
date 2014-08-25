//
//  ESTBeacon+RACExtensions.h
//  EstimoteTest
//
//  Created by Eli Perkins on 8/25/14.
//  Copyright (c) 2014 Eli Perkins. All rights reserved.
//

#import <EstimoteSDK/ESTBeacon.h>

@class RACSignal;
@class RACDelegateProxy;

// Convenience wrapper constants for Estimote SDK error codes
extern const NSInteger ESTErrorServerIssueCode;
extern const NSInteger ESTErrorSameValueCode;

@interface ESTBeacon (RACExtensions)

/// A delegate proxy which will be set as the receiver's delegate when any of the
/// methods in this category are used.
@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;

/// Creates a signal which connects to the beacon and completes
- (RACSignal *)rac_connect;

/// Creates a signal which disconnects from the beacon and completes
- (RACSignal *)rac_disconnect;

/// Writes a major value to the beacon and completes
- (RACSignal *)rac_writeMajor:(NSInteger)major;

/// Writes a minor value to the beacon and completes
- (RACSignal *)rac_writeMinor:(NSInteger)minor;

/// Writes a proximity UUID to the beacon and completes
- (RACSignal *)rac_writeProximityUUID:(NSUUID *)UUID;

@end
