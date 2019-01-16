//
//  NSETimeoutOperation.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/16/19.
//

#import "NSEOperation.h"
#import "NSEClock.h"

@class NSETimeoutOperation;

@protocol NSETimeoutOperationDelegate;



@protocol NSETimeoutOperationDelegate <NSEOperationDelegate>

@optional
- (void)nseTimeoutOperationDidUpdateState:(NSETimeoutOperation *)operation;
- (void)nseTimeoutOperationDidStart:(NSETimeoutOperation *)operation;
- (void)nseTimeoutOperationDidCancel:(NSETimeoutOperation *)operation;
- (void)nseTimeoutOperationDidFinish:(NSETimeoutOperation *)operation;

- (void)nseTimeoutOperationDidUpdateProgress:(NSETimeoutOperation *)operation;

@end



@interface NSETimeoutOperation : NSEOperation <NSETimeoutOperationDelegate, NSEClockDelegate>

@property (readonly) NSMutableOrderedSet<NSETimeoutOperationDelegate> *delegates;
@property (readonly) NSTimeInterval timeout;
@property (readonly) NSEClock *clock;

- (instancetype)initWithTimeout:(NSTimeInterval)timeout;

@end
