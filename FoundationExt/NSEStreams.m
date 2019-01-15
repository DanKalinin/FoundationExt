//
//  NSEStreams.m
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEStreams.h"









@interface NSEStreamsOpening ()

@end



@implementation NSEStreamsOpening

@end










@interface NSEStreams ()

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@property (weak) NSEStreamsOpening *opening;

@end



@implementation NSEStreams

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream {
    self = super.init;
    
    self.inputStream = inputStream;
    self.outputStream = outputStream;
    
    [inputStream.nseOperation.delegates addObject:self.delegates];
    [outputStream.nseOperation.delegates addObject:self.delegates];
    
    return self;
}

- (instancetype)initToHostWithName:(NSString *)hostname port:(NSInteger)port {
    NSInputStream *inputStream = nil;
    NSOutputStream *outputStream = nil;
    [NSStream getStreamsToHostWithName:hostname port:port inputStream:&inputStream outputStream:&outputStream];
    
    self = [self initWithInputStream:inputStream outputStream:outputStream];
    return self;
}

- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout {
    self.opening = NSEStreamsOpening.new.nseAutorelease;
    [self addOperation:self.opening];
    return self.opening;
}

-(NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSEStreamsOpening *operation = [self openWithTimeout:timeout];
    operation.completionBlock = completion;
    return operation;
}

@end
