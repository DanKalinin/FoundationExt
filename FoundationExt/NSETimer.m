//
//  NSETimer.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSETimer.h"










@implementation NSTimer (NSE)

@dynamic nseOperation;

+ (instancetype)nseScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval repeats:repeats block:^(NSTimer *timer) {
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

@end
