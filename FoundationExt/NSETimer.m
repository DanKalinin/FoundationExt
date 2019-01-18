//
//  NSETimer.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSETimer.h"










@implementation NSTimer (NSE)

@dynamic nseOperation;

- (instancetype)nseInitWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval userInfo:(id)userInfo repeats:(BOOL)repeats {
    NSTimer *timer = [self initWithFireDate:date interval:interval target:self.nseOperation selector:@selector(fire:) userInfo:userInfo repeats:repeats];
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

@dynamic object;

- (void)fire:(NSTimer *)timer {
    
}

@end
