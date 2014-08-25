//
//  ReactiveEstimoteTests.m
//  ReactiveEstimoteTests
//
//  Created by Eli Perkins on 08/25/2014.
//  Copyright (c) 2014 Eli Perkins. All rights reserved.
//

#import <ReactiveEstimote/ESTBeacon+RACExtensions.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

SpecBegin(ReactiveBeacon)

__block ESTBeacon *mockBeacon;

beforeEach(^{
    ESTBeacon *beacon = [[ESTBeacon alloc] init];
    mockBeacon = OCMPartialMock(beacon);
});

describe(@"-rac_connect", ^{
    it(@"should call -connect", ^{
        OCMStub([mockBeacon connect]).andDo(^(NSInvocation *invocation) {
            [mockBeacon.delegate beaconConnectionDidSucceeded:mockBeacon];
        });
        
        BOOL completed = [[mockBeacon rac_connect] asynchronouslyWaitUntilCompleted:NULL];
        
        OCMVerify([mockBeacon connect]);
        expect(completed).to.beTruthy();
    });
    
    it(@"should handle errors when connecting", ^{
        OCMStub([mockBeacon connect]).andDo(^(NSInvocation *invocation) {
            NSError *someError = [NSError errorWithDomain:@"com.estimote.error" code:401 userInfo:@{}];
            [mockBeacon.delegate beaconConnectionDidFail:mockBeacon withError:someError];
        });
        
        NSError *error;
        [[mockBeacon rac_connect] asynchronouslyWaitUntilCompleted:&error];
        
        expect(error).notTo.beNil();
    });
});

describe(@"-rac_disconnect", ^{
    it(@"should call -disconnect", ^{
        OCMStub([mockBeacon disconnect]).andDo(^(NSInvocation *invocation) {
            [mockBeacon.delegate beacon:mockBeacon didDisconnectWithError:nil];
        });
        
        BOOL completed = [[mockBeacon rac_disconnect] asynchronouslyWaitUntilCompleted:NULL];
        
        OCMVerify([mockBeacon disconnect]);
        expect(completed).to.beTruthy();
    });
});

describe(@"-rac_writeMajor:", ^{
    it(@"should call -writeMajor:completion:", ^{
        // We can't use OCMOCK_ANY here for the unsigned short primative that the Estimote SDK expects
        // Just passing 1 for our test case should be sufficient
        OCMStub([mockBeacon writeMajor:1 completion:OCMOCK_ANY]).andDo(^(NSInvocation *invocation) {
            ESTUnsignedShortCompletionBlock block;
            [invocation getArgument:&block atIndex:3];
            block(1, nil);
        });
        
        BOOL completed = [[mockBeacon rac_writeMajor:1] asynchronouslyWaitUntilCompleted:NULL];
        
        OCMVerify([mockBeacon writeMajor:1 completion:OCMOCK_ANY]);
        expect(completed).to.beTruthy();
    });
});

describe(@"-rac_writeMinor:", ^{
    it(@"should call -writeMinor:completion:", ^{
        OCMStub([mockBeacon writeMinor:1 completion:OCMOCK_ANY]).andDo(^(NSInvocation *invocation) {
            ESTUnsignedShortCompletionBlock block;
            [invocation getArgument:&block atIndex:3];
            block(1, nil);
        });
        
        BOOL completed = [[mockBeacon rac_writeMinor:1] asynchronouslyWaitUntilCompleted:NULL];
        
        OCMVerify([mockBeacon writeMinor:1 completion:OCMOCK_ANY]);
        expect(completed).to.beTruthy();
    });
});

describe(@"-rac_writeProximityUUID:", ^{
    it(@"should call -writeProximityUUID:completion:", ^{
        NSString *UUIDString = @"9299E108-B07A-4881-87A9-55BAEA6411AE";
        NSUUID *UUID = [[NSUUID alloc] initWithUUIDString:UUIDString];
        OCMStub([mockBeacon writeProximityUUID:OCMOCK_ANY completion:OCMOCK_ANY]).andDo(^(NSInvocation *invocation) {
            ESTStringCompletionBlock block;
            [invocation getArgument:&block atIndex:3];
            block(UUIDString, nil);
        });
        
        BOOL completed = [[mockBeacon rac_writeProximityUUID:UUID] asynchronouslyWaitUntilCompleted:NULL];
        
        OCMVerify([mockBeacon writeProximityUUID:OCMOCK_ANY completion:OCMOCK_ANY]);
        expect(completed).to.beTruthy();
    });
});

SpecEnd
