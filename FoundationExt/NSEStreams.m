//
//  NSEStreams.m
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEStreams.h"









@interface NSEStreams ()

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@end



@implementation NSEStreams

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream {
    self = super.init;
    
    self.inputStream = inputStream;
    self.outputStream = outputStream;
    
    return self;
}

- (instancetype)initToHostWithName:(NSString *)hostname port:(NSInteger)port {
    NSInputStream *inputStream = nil;
    NSOutputStream *outputStream = nil;
    [NSStream getStreamsToHostWithName:hostname port:port inputStream:&inputStream outputStream:&outputStream];
    
    self = [self initWithInputStream:inputStream outputStream:outputStream];
    return self;
}

@end
