//
//  NSEClock.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSEOperation.h"

@class NSEClock;

@protocol NSEClockDelegate;



@protocol NSEClockDelegate <NSEOperationDelegate>

@optional
- (void)nseClockDidUpdateState:(NSEClock *)clock;
- (void)nseClockDidStart:(NSEClock *)clock;
- (void)nseClockDidCancel:(NSEClock *)clock;
- (void)nseClockDidFinish:(NSEClock *)clock;

- (void)nseClockDidUpdateProgress:(NSEClock *)clock;

@end



@interface NSEClock : NSEOperation <NSEClockDelegate>

@property (readonly) NSMutableOrderedSet<NSEClockDelegate> *delegates;
@property (readonly) NSTimeInterval timeout;
@property (readonly) NSUInteger repeats;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;

- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;
- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats completion:(NSEBlock)completion;

@end
