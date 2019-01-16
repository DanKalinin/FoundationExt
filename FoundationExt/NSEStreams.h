//
//  NSEStreams.h
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEStream.h"

@class NSEStreams;
@class NSEStreamsOpening;

@protocol NSEStreamsDelegate;
@protocol NSEStreamsOpeningDelegate;










@protocol NSEStreamsOpeningDelegate <NSEOperationDelegate>

@end



@interface NSEStreamsOpening : NSEOperation <NSEStreamsOpeningDelegate>

@property (readonly) NSTimeInterval timeout;

@end










@protocol NSEStreamsDelegate <NSEInputStreamDelegate, NSEOutputStreamDelegate>

@end



@interface NSEStreams : NSEOperation <NSEStreamsDelegate>

@property (readonly) NSInputStream *inputStream;
@property (readonly) NSOutputStream *outputStream;

@property (weak, readonly) NSEStreamsOpening *opening;

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream;
- (instancetype)initToHostWithName:(NSString *)hostname port:(NSInteger)port;

- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout;
- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
