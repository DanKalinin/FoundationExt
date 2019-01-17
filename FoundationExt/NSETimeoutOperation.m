//
//  NSETimeoutOperation.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSETimeoutOperation.h"



@interface NSETimeoutOperation ()

@property NSTimeInterval timeout;
@property NSEClock *clock;

@end



@implementation NSETimeoutOperation

@dynamic delegates;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout {
    self = super.init;
    
    self.timeout = timeout;
    
    return self;
}

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseTimeoutOperationDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseTimeoutOperationDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseTimeoutOperationDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseTimeoutOperationDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseTimeoutOperationDidUpdateProgress:self];
}

#pragma mark - NSETimeoutOperationDelegate

- (void)nseTimeoutOperationDidStart:(NSETimeoutOperation *)operation {
    self.clock = [NSEClock.nseShared clockWithTimeout:self.timeout repeats:1];
    [self.clock.delegates addObject:self];
}

#pragma mark - NSEClockDelegate

- (void)nseClockDidFinish:(NSEClock *)clock {
    if (self.isFinished) {
    } else {
        self.error = [NSError errorWithDomain:NSEOperationErrorDomain code:NSEOperationErrorTimeout userInfo:nil];
        [self finish];
    }
}

@end
