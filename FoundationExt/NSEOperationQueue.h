//
//  NSEOperationQueue.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/27/19.
//

#import "NSEObjectOperation.h"

@class NSEOperationQueue;
@class NSEOperationQueueOperation;

@protocol NSEOperationQueueDelegate;










@interface NSOperationQueue (NSE)

@property (readonly) NSEOperationQueueOperation *nseOperation;

+ (instancetype)nseSerialOperationQueue;
+ (instancetype)nseConcurrentOperationQueue;

@end










@interface NSEOperationQueue : NSOperationQueue

@end










@protocol NSEOperationQueueDelegate <NSEObjectDelegate>

@end



@interface NSEOperationQueueOperation : NSEObjectOperation <NSEOperationQueueDelegate>

@property (weak, readonly) NSOperationQueue *object;

- (void)addOperationWithBlock:(NSEBlock)block waitUntilFinished:(BOOL)wait;

@end
