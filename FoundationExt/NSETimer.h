//
//  NSETimer.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEObjectOperation.h"

@class NSETimer;
@class NSETimerOperation;

@protocol NSETimerDelegate;










@interface NSTimer (NSE)

@property (readonly) NSETimerOperation *nseOperation;

+ (instancetype)nseScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats;

@end










@interface NSETimer : NSTimer

@end










@protocol NSETimerDelegate <NSEObjectDelegate>

@optional
- (void)nseTimerDidFire:(NSTimer *)timer;

@end



@interface NSETimerOperation : NSEObjectOperation <NSETimerDelegate>

@property (readonly) NSMutableOrderedSet<NSETimerDelegate> *delegates;

@property (weak, readonly) NSTimer *object;

@end
