//
//  ESTBeacon+RACExtensions.m
//  EstimoteTest
//
//  Created by Eli Perkins on 8/25/14.
//  Copyright (c) 2014 Eli Perkins. All rights reserved.
//

#import "ESTBeacon+RACExtensions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <objc/runtime.h>
#import "RACDelegateProxy.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "NSObject+RACDescription.h"

const NSInteger ESTErrorServerIssueCode = 410;
const NSInteger ESTErrorSameValueCode = 411;

@implementation ESTBeacon (RACExtensions)

static void RACUseDelegateProxy(ESTBeacon *self) {
    if (self.delegate == self.rac_delegateProxy) return;
    
    self.rac_delegateProxy.rac_proxiedDelegate = self.delegate;
    self.delegate = (id)self.rac_delegateProxy;
}

- (RACDelegateProxy *)rac_delegateProxy {
    RACDelegateProxy *proxy = objc_getAssociatedObject(self, _cmd);
    if (proxy == nil) {
        proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(ESTBeaconDelegate)];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return proxy;
}

- (RACSignal *)rac_connect {
    @weakify(self);
    RACSignal *signal = [[RACSignal
        defer:^RACSignal *{
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                RACSignal *successSignal = [[[self.rac_delegateProxy
                    signalForSelector:@selector(beaconConnectionDidSucceeded:)]
                    reduceEach:^(ESTBeacon *beacon){
                        return beacon;
                    }]
                    take:1];
                
                RACDisposable *disposable = [successSignal subscribe:subscriber];
                
                RACSignal *errorSignal = [[self.rac_delegateProxy
                    signalForSelector:@selector(beaconConnectionDidFail:withError:)]
                    reduceEach:^(ESTBeacon *beacon, NSError *error) {
                        return error;
                    }];
                
                RACDisposable *errorDisposable = [errorSignal subscribeNext:^(NSError *error) {
                    [subscriber sendError:error];
                }];
                
                [self connect];
                
                return [RACDisposable disposableWithBlock:^{
                    [disposable dispose];
                    [errorDisposable dispose];
                    // Unfortunately, calling disconnect here doesn't quite fit in with the usage
                    // right yet. Need to figure out a way to multicast this signal and maintain the
                    // connection in a better way
                    // [self disconnect];
                }];
            }];
        }]
        setNameWithFormat:@"-rac_connect"];

    RACUseDelegateProxy(self);
    
    return signal;
}

- (RACSignal *)rac_disconnect {
    @weakify(self);
    RACSignal *signal = [[RACSignal
        defer:^RACSignal *{
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [[self.rac_delegateProxy
                    signalForSelector:@selector(beacon:didDisconnectWithError:)]
                    subscribeNext:^(RACTuple *args) {
                        if (args.second) {
                            [subscriber sendError:args.second];
                        } else {
                            [subscriber sendCompleted];
                        }
                    }];
                
                [self disconnect];
                
                return nil;
            }];
        }]
        setNameWithFormat:@"-rac_disconnect"];

    RACUseDelegateProxy(self);
    
    return signal;

}

- (RACSignal *)rac_writeMajor:(NSInteger)major {
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self writeMajor:major completion:^(unsigned short value, NSError *error) {
            if (error) {
                if (error.code == ESTErrorSameValueCode) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            } else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }] setNameWithFormat:@"-rac_writeMajor: %d", major];
}

- (RACSignal *)rac_writeMinor:(NSInteger)minor {
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self writeMinor:minor completion:^(unsigned short value, NSError *error) {
            if (error) {
                if (error.code == ESTErrorSameValueCode) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            } else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }] setNameWithFormat:@"-rac_writeMinor: %d", minor];
}

- (RACSignal *)rac_writeProximityUUID:(NSUUID *)UUID {
    @weakify(self);
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self writeProximityUUID:UUID.UUIDString completion:^(NSString *value, NSError *error) {
            if (error) {
                if (error.code == ESTErrorSameValueCode) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            } else {
                [subscriber sendCompleted];
            }
        }];
        
        return nil;
    }] setNameWithFormat:@"-rac_writeProximityUUID: %@", UUID.UUIDString];
}

@end
