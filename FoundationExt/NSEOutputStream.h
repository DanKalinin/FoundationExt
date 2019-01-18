//
//  NSEOutputStream.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEStream.h"

@class NSEOutputStream;
@class NSEOutputStreamOperation;

@protocol NSEOutputStreamDelegate;










@interface NSOutputStream (NSE)

@property (readonly) NSEOutputStreamOperation *nseOperation;

@end










@interface NSEOutputStream : NSOutputStream

@end










@protocol NSEOutputStreamDelegate <NSEStreamDelegate>

@optional
- (void)nseOutputStreamOpenCompleted:(NSOutputStream *)outputStream;
- (void)nseOutputStreamHasSpaceAvailable:(NSOutputStream *)outputStream;
- (void)nseOutputStreamErrorOccurred:(NSOutputStream *)outputStream;
- (void)nseOutputStreamEndEncountered:(NSOutputStream *)outputStream;

@end



@interface NSEOutputStreamOperation : NSEStreamOperation <NSEOutputStreamDelegate>

@property (readonly) NSMutableOrderedSet<NSEOutputStreamDelegate> *delegates;

@property (weak, readonly) NSOutputStream *object;

@end
