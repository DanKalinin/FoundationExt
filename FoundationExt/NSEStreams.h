//
//  NSEStreams.h
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEInputStream.h"
#import "NSEOutputStream.h"

@class NSEStreams;
@class NSEStreamsOpening;

@protocol NSEStreamsDelegate;
@protocol NSEStreamsOpeningDelegate;










@protocol NSEStreamsOpeningDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseStreamsOpeningDidUpdateState:(NSEStreamsOpening *)opening;
- (void)nseStreamsOpeningDidStart:(NSEStreamsOpening *)opening;
- (void)nseStreamsOpeningDidCancel:(NSEStreamsOpening *)opening;
- (void)nseStreamsOpeningDidFinish:(NSEStreamsOpening *)opening;

- (void)nseStreamsOpeningDidUpdateProgress:(NSEStreamsOpening *)opening;

@end



@interface NSEStreamsOpening : NSETimeoutOperation <NSEStreamsOpeningDelegate, NSEStreamOpeningDelegate>

@property (readonly) NSEStreams *parent;
@property (readonly) NSMutableOrderedSet<NSEStreamsOpeningDelegate> *delegates;
@property (readonly) NSEStreamOpening *inputStreamOpening;
@property (readonly) NSEStreamOpening *outputStreamOpening;

@end










@protocol NSEStreamsDelegate <NSEInputStreamDelegate, NSEOutputStreamDelegate>

@end



@interface NSEStreams : NSEOperation <NSEStreamsDelegate>

@property (readonly) NSInputStream *inputStream;
@property (readonly) NSOutputStream *outputStream;

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream;
- (instancetype)initToHostWithName:(NSString *)hostname port:(NSInteger)port;

- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout;
- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (void)close;

@end
