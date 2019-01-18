//
//  NSEStreams.m
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/15/19.
//

#import "NSEStreams.h"









@interface NSEStreamsOpening ()

@property NSEStreamOpening *inputStreamOpening;
@property NSEStreamOpening *outputStreamOpening;

@end



@implementation NSEStreamsOpening

@dynamic parent;
@dynamic delegates;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseStreamsOpeningDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseStreamsOpeningDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseStreamsOpeningDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseStreamsOpeningDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseStreamsOpeningDidUpdateProgress:self];
}

#pragma mark - NSEStreamsOpeningDelegate

- (void)nseStreamsOpeningDidStart:(NSEStreamsOpening *)opening {
    self.inputStreamOpening = [self.parent.inputStream.nseOperation openWithTimeout:self.timeout];
    [self.inputStreamOpening.delegates addObject:self];
    
    self.outputStreamOpening = [self.parent.outputStream.nseOperation openWithTimeout:self.timeout];
    [self.outputStreamOpening.delegates addObject:self];
}

- (void)nseStreamsOpeningDidCancel:(NSEStreamsOpening *)opening {
    [self.inputStreamOpening cancel];
    [self.outputStreamOpening cancel];
}

#pragma mark - NSEStreamOpeningDelegate

- (void)nseStreamOpeningDidFinish:(NSEStreamOpening *)opening {
    if (opening.error) {
        self.error = opening.error;
        [self cancel];
    }
    
    if (self.inputStreamOpening.isFinished && self.outputStreamOpening.isFinished) {
        [self finish];
    }
}

@end










@interface NSEStreams ()

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@end



@implementation NSEStreams

- (instancetype)initWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream {
    self = super.init;
    
    self.inputStream = inputStream;
    [inputStream.nseOperation.delegates addObject:self.delegates];
    
    self.outputStream = outputStream;
    [outputStream.nseOperation.delegates addObject:self.delegates];
    
    self.queue.maxConcurrentOperationCount = 1;
    
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
    NSEStreamsOpening *opening = [NSEStreamsOpening.alloc initWithTimeout:timeout];
    
    [self addOperation:opening];
    
    return opening;
}

- (NSEStreamsOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSEStreamsOpening *opening = [self openWithTimeout:timeout];
    
    opening.completion = completion;
    
    return opening;
}

- (void)close {
    [self.inputStream close];
    [self.outputStream close];
}

@end
