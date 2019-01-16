//
//  NSETimeoutOperation.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSETimeoutOperation.h"



@interface NSETimeoutOperation ()

@property NSTimeInterval timeout;
@property NSEClock *clock;

@end



@implementation NSETimeoutOperation

- (instancetype)initWithTimeout:(NSTimeInterval)timeout {
    self = super.init;
    
    self.timeout = timeout;
    
    return self;
}

- (void)main {
    [super main];
    
    self.clock = [NSEClock.nseShared clockWithTimeout:self.timeout repeats:1];
    [self.clock.delegates addObject:self];
}

- (void)finish {
    if (self.isFinished) {
    } else {
        if (self.clock.isFinished) {
            if (self.clock.isCancelled) {
            } else {
                self.error = [NSError errorWithDomain:NSEOperationErrorDomain code:NSEOperationErrorTimeout userInfo:nil];
            }
        } else {
            if (self.clock.isCancelled) {
            } else {
                [self.clock cancel];
            }
        }
        
        [super finish];
    }
}

#pragma mark - NSEClockDelegate

- (void)nseClockDidFinish:(NSEClock *)clock {
    [self finish];
}

@end
