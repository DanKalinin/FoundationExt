//
//  NSEStream.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEObjectOperation.h"
#import "NSETimeoutOperation.h"

@class NSEStream;
@class NSEStreamOpening;
@class NSEStreamOperation;
@class NSEInputStream;
@class NSEInputStreamOperation;
@class NSEOutputStream;
@class NSEOutputStreamOperation;

@protocol NSEStreamDelegate;
@protocol NSEStreamOpeningDelegate;
@protocol NSEInputStreamDelegate;
@protocol NSEOutputStreamDelegate;










@interface NSStream (NSE)

@property (readonly) NSEStreamOperation *nseOperation;

@end










@interface NSEStream : NSStream

@end










@protocol NSEStreamOpeningDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseStreamOpeningDidUpdateState:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidStart:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidCancel:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidFinish:(NSEStreamOpening *)opening;

- (void)nseStreamOpeningDidUpdateProgress:(NSEStreamOpening *)opening;

@end



@interface NSEStreamOpening : NSETimeoutOperation <NSEStreamOpeningDelegate>

@property (readonly) NSEStreamOperation *parent;
@property (readonly) NSMutableOrderedSet<NSEStreamOpeningDelegate> *delegates;

@end










@protocol NSEStreamDelegate <NSEObjectDelegate, NSEStreamOpeningDelegate>

@optional
- (void)nseStreamOpenCompleted:(NSStream *)stream;
- (void)nseStreamHasBytesAvailable:(NSStream *)stream;
- (void)nseStreamHasSpaceAvailable:(NSStream *)stream;
- (void)nseStreamErrorOccurred:(NSStream *)stream;
- (void)nseStreamEndEncountered:(NSStream *)stream;

@end



@interface NSEStreamOperation : NSEObjectOperation <NSEStreamDelegate, NSStreamDelegate>

@property (readonly) NSMutableOrderedSet<NSEStreamDelegate> *delegates;

@property (weak, readonly) NSStream *object;
@property (weak, readonly) NSEStreamOpening *opening;

- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout;
- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end










@interface NSInputStream (NSE)

@property (readonly) NSEInputStreamOperation *nseOperation;

@end










@interface NSEInputStream : NSInputStream

@end










@protocol NSEInputStreamDelegate <NSEStreamDelegate>

@optional
- (void)nseInputStreamOpenCompleted:(NSInputStream *)inputStream;
- (void)nseInputStreamHasBytesAvailable:(NSInputStream *)inputStream;
- (void)nseInputStreamErrorOccurred:(NSInputStream *)inputStream;
- (void)nseInputStreamEndEncountered:(NSInputStream *)inputStream;

@end



@interface NSEInputStreamOperation : NSEStreamOperation <NSEInputStreamDelegate>

@property (readonly) NSMutableOrderedSet<NSEInputStreamDelegate> *delegates;

@property (weak, readonly) NSInputStream *object;

@end










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
