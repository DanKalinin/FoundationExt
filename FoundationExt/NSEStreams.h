//
//  NSEStreams.h
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEStream.h"

@class NSEStreams;

@protocol NSEStreamsDelegate;











@protocol NSEStreamsDelegate <NSEInputStreamDelegate, NSEOutputStreamDelegate>

@end



@interface NSEStreams : NSEOperation <NSEStreamsDelegate>

@property (readonly) NSInputStream *inputStream;
@property (readonly) NSOutputStream *outputStream;

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream;
- (instancetype)initToHostWithName:(NSString *)hostname port:(NSInteger)port;

@end
