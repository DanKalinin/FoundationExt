//
//  NSEClock.h
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEOperation.h"

@class NSEClock;

@protocol NSEClockDelegate;



@protocol NSEClockDelegate <NSEOperationDelegate>

@optional
- (void)nseClockDidFinish:(NSEClock *)clock;

@end



@interface NSEClock : NSEOperation <NSEClockDelegate>

@property (readonly) NSMutableOrderedSet<NSEClockDelegate> *delegates;
@property (readonly) NSTimeInterval timeout;
@property (readonly) NSUInteger repeats;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;

- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;
- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats completion:(NSEBlock)completion;

@end
