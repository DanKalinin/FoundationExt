//
//  NSEThread.h
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/27/19.
//

#import "NSEObjectOperation.h"

@class NSEThread;
@class NSEThreadOperation;

@protocol NSEThreadDelegate;










@interface NSThread (NSE)

@property (readonly) NSEThreadOperation *nseOperation;

@end










@interface NSEThread : NSThread

@end










@protocol NSEThreadDelegate <NSEObjectDelegate>

@end



@interface NSEThreadOperation : NSEObjectOperation <NSEThreadDelegate>

@property (weak, readonly) NSThread *object;

@property NSError *lastError;

@end
