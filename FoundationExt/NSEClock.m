//
//  NSEClock.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSEClock.h"



@interface NSEClock ()

@property NSTimeInterval timeout;
@property NSUInteger repeats;

@end



@implementation NSEClock

@dynamic delegates;

+ (instancetype)nseShared {
    static NSEClock *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = self.new;
    });
    return shared;
}

- (instancetype)initWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats {
    self = super.init;
    
    self.timeout = timeout;
    self.repeats = repeats;
    
    return self;
}

- (void)main {
    self.progress.totalUnitCount = self.repeats;
    
    for (int64_t completedUnitCount = 0; completedUnitCount < self.repeats; completedUnitCount++) {
        [self updateProgress:completedUnitCount];
        
        [NSThread sleepForTimeInterval:self.timeout];
        
        if (self.isCancelled) {
            return;
        }
    }
    
    [self updateProgress:self.repeats];
    
    [self finish];
}

- (void)cancel {
    [super cancel];
    
    [self finish];
}

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseClockDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseClockDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseClockDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseClockDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseClockDidUpdateProgress:self];
}

- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats {
    NSEClock *operation = [self.class.alloc initWithTimeout:timeout repeats:repeats];
    [self addOperation:operation];
    return operation;
}

- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats completion:(NSEBlock)completion {
    NSEClock *operation = [self clockWithTimeout:timeout repeats:repeats];
    operation.completionBlock = completion;
    return operation;
}

@end
