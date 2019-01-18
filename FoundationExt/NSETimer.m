//
//  NSETimer.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSETimer.h"










@implementation NSTimer (NSE)

@dynamic nseOperation;

+ (NSTimer *)nseScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats {
    NSTimer *timer = [NSETimer scheduledTimerWithTimeInterval:interval repeats:repeats block:^(NSTimer *timer) {
        [timer.nseOperation.delegates nseTimerDidFire:timer];
    }];
    return timer;
}

- (Class)nseOperationClass {
    return NSETimerOperation.class;
}

@end










@interface NSETimer ()

@end



@implementation NSETimer

@end










@interface NSETimerOperation ()

@end



@implementation NSETimerOperation

@dynamic delegates;
@dynamic object;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseTimerDidUpdateState:self.object];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseTimerDidStart:self.object];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseTimerDidCancel:self.object];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseTimerDidFinish:self.object];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseTimerDidUpdateProgress:self.object];
}

@end
