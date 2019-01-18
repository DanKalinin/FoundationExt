//
//  NSEInputStream.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEInputStream.h"










@implementation NSInputStream (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSEInputStreamOperation.class;
}

@end










@interface NSEInputStream ()

@end



@implementation NSEInputStream

@end










@interface NSEInputStreamReading ()

@property NSUInteger length;
@property NSMutableData *data;

@end



@implementation NSEInputStreamReading

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithLength:(NSUInteger)length timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.length = length;
    
    return self;
}

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseInputStreamReadingDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseInputStreamReadingDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseInputStreamReadingDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseInputStreamReadingDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseInputStreamReadingDidUpdateProgress:self];
}

#pragma mark - NSEInputStreamReadingDelegate

- (void)nseInputStreamReadingDidStart:(NSEInputStreamReading *)reading {
    if (self.parent.object.streamStatus == NSStreamStatusOpen) {
        self.parent.reading = self;
        
        self.progress.totalUnitCount = self.length;
        
        if (self.parent.object.hasBytesAvailable) {
            [self.parent stream:self.parent.object handleEvent:NSStreamEventHasBytesAvailable];
        }
    } else {
        self.error = [NSError errorWithDomain:NSEStreamErrorDomain code:NSEStreamErrorNotOpen userInfo:nil];
        [self cancel];
    }
}

@end










@interface NSEInputStreamOperation ()

@end



@implementation NSEInputStreamOperation

@dynamic delegates;
@dynamic object;

- (NSEInputStreamReading *)readDataOfLength:(NSUInteger)length timeout:(NSTimeInterval)timeout {
    NSEInputStreamReading *reading = [NSEInputStreamReading.alloc initWithLength:length timeout:timeout];
    
    [self addOperation:reading];
    
    return reading;
}

- (NSEInputStreamReading *)readDataOfLength:(NSUInteger)length timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSEInputStreamReading *reading = [self readDataOfLength:length timeout:timeout];
    
    reading.completion = completion;
    
    return reading;
}

#pragma mark - NSStreamDelegate

- (void)stream:(NSInputStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    [super stream:aStream handleEvent:eventCode];
    
    if (eventCode == NSStreamEventOpenCompleted) {
        [self.delegates nseInputStreamOpenCompleted:aStream];
    } else if (eventCode == NSStreamEventHasBytesAvailable) {
        [self.delegates nseInputStreamHasBytesAvailable:aStream];
    } else if (eventCode == NSStreamEventErrorOccurred) {
        [self.delegates nseInputStreamErrorOccurred:aStream];
    } else if (eventCode == NSStreamEventEndEncountered) {
        [self.delegates nseInputStreamEndEncountered:aStream];
    }
}

@end
