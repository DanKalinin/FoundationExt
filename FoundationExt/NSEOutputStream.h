//
//  NSEOutputStream.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEStream.h"

@class NSEOutputStream;
@class NSEOutputStreamWriting;
@class NSEOutputStreamOperation;

@protocol NSEOutputStreamDelegate;
@protocol NSEOutputStreamWritingDelegate;










@interface NSOutputStream (NSE)

@property (readonly) NSEOutputStreamOperation *nseOperation;

@end










@interface NSEOutputStream : NSOutputStream

@end










@protocol NSEOutputStreamWritingDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseOutputStreamWritingDidUpdateState:(NSEOutputStreamWriting *)writing;
- (void)nseOutputStreamWritingDidStart:(NSEOutputStreamWriting *)writing;
- (void)nseOutputStreamWritingDidCancel:(NSEOutputStreamWriting *)writing;
- (void)nseOutputStreamWritingDidFinish:(NSEOutputStreamWriting *)writing;

- (void)nseOutputStreamWritingDidUpdateProgress:(NSEOutputStreamWriting *)writing;

@end



@interface NSEOutputStreamWriting : NSETimeoutOperation <NSEOutputStreamWritingDelegate>

@property (readonly) NSEOutputStreamOperation *parent;
@property (readonly) NSMutableOrderedSet<NSEOutputStreamWritingDelegate> *delegates;
@property (readonly) NSMutableData *data;

- (instancetype)initWithData:(NSMutableData *)data timeout:(NSTimeInterval)timeout;

@end










@protocol NSEOutputStreamDelegate <NSEStreamDelegate, NSEOutputStreamWritingDelegate>

@optional
- (void)nseOutputStreamOpenCompleted:(NSOutputStream *)outputStream;
- (void)nseOutputStreamHasSpaceAvailable:(NSOutputStream *)outputStream;
- (void)nseOutputStreamErrorOccurred:(NSOutputStream *)outputStream;
- (void)nseOutputStreamEndEncountered:(NSOutputStream *)outputStream;

@end



@interface NSEOutputStreamOperation : NSEStreamOperation <NSEOutputStreamDelegate>

@property (readonly) NSMutableOrderedSet<NSEOutputStreamDelegate> *delegates;

@property (weak, readonly) NSOutputStream *object;

- (NSEOutputStreamWriting *)writeData:(NSMutableData *)data timeout:(NSTimeInterval)timeout;
- (NSEOutputStreamWriting *)writeData:(NSMutableData *)data timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
