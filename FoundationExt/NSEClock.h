//
//  NSEClock.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSEOperation.h"



@protocol NSEClockDelegate <NSEOperationDelegate>

@end



@interface NSEClock : NSEOperation <NSEClockDelegate>

@property (readonly) NSTimeInterval timeout;
@property (readonly) NSUInteger repeats;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;

- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats;
- (instancetype)clockWithTimeout:(NSTimeInterval)timeout repeats:(NSUInteger)repeats completion:(NSEBlock)completion;

@end
