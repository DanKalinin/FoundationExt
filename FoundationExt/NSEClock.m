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
