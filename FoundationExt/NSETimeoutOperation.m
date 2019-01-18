//
//  NSETimeoutOperation.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSETimeoutOperation.h"



@interface NSETimeoutOperation ()

@property NSTimeInterval timeout;
@property NSTimer *timer;

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
    self.timer = [NSTimer nseScheduledTimerWithTimeInterval:self.timeout repeats:NO];
    [self.timer.nseOperation.delegates addObject:self];
}

- (void)nseTimeoutOperationDidCancel:(NSETimeoutOperation *)operation {
    [self.timer invalidate];
}

- (void)nseTimeoutOperationDidFinish:(NSETimeoutOperation *)operation {
    [self.timer invalidate];
}

#pragma mark - NSETimerDelegate

- (void)nseTimerDidFire:(NSTimer *)timer {
    self.error = [NSError errorWithDomain:NSEOperationErrorDomain code:NSEOperationErrorTimeout userInfo:nil];
    [self cancel];
}

@end
