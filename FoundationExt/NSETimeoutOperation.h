//
//  NSETimeoutOperation.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEOperation.h"
#import "NSEClock.h"

@class NSETimeoutOperation;

@protocol NSETimeoutOperationDelegate;



@protocol NSETimeoutOperationDelegate <NSEOperationDelegate>

@end



@interface NSETimeoutOperation : NSEOperation <NSETimeoutOperationDelegate, NSEClockDelegate>

@property (readonly) NSTimeInterval timeout;
@property (readonly) NSEClock *clock;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout;

@end
