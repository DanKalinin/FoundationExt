//
//  NSEStream.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEStream.h"










@implementation NSStream (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSEStreamOperation.class;
}

@end










@interface NSEStream ()

@end



@implementation NSEStream

@end










@interface NSEStreamOpening ()

@end



@implementation NSEStreamOpening

@dynamic parent;
@dynamic delegates;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseStreamOpeningDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseStreamOpeningDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseStreamOpeningDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseStreamOpeningDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseStreamOpeningDidUpdateProgress:self];
}

#pragma mark - NSEStreamOpeningDelegate

- (void)nseStreamOpeningDidStart:(NSEStreamOpening *)opening {
    [self.parent.object scheduleInRunLoop:NSRunLoop.currentRunLoop forMode:NSDefaultRunLoopMode];
    [self.parent.object open];
}

- (void)nseStreamOpeningDidCancel:(NSEStreamOpening *)opening {
    [self.parent.object close];
    [self finish];
}

@end










@interface NSEStreamOperation ()

@property (weak) NSEStreamOpening *opening;

@end



@implementation NSEStreamOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(NSStream *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout {
    self.opening = [NSEStreamOpening.alloc initWithTimeout:timeout].nseAutorelease;
    [self addOperation:self.opening];
    return self.opening;
}

- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSEStreamOpening *operation = [self openWithTimeout:timeout];
    operation.completion = completion;
    return operation;
}

#pragma mark - NSStreamDelegate

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    if (eventCode == NSStreamEventOpenCompleted) {
        [self.delegates nseStreamOpenCompleted:aStream];
        
        [self.opening finish];
    } else if (eventCode == NSStreamEventHasBytesAvailable) {
        [self.delegates nseStreamHasBytesAvailable:aStream];
    } else if (eventCode == NSStreamEventHasSpaceAvailable) {
        [self.delegates nseStreamHasSpaceAvailable:aStream];
    } else if (eventCode == NSStreamEventErrorOccurred) {
        [self.delegates nseStreamErrorOccurred:aStream];
        
        self.opening.error = self.object.streamError;
        [self.opening cancel];
    } else if (eventCode == NSStreamEventEndEncountered) {
        [self.delegates nseStreamEndEncountered:aStream];
    }
}

@end










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










@interface NSEInputStreamOperation ()

@end



@implementation NSEInputStreamOperation

@dynamic delegates;
@dynamic object;

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










@implementation NSOutputStream (NSE)

@dynamic nseOperation;

@end










@interface NSEOutputStream ()

@end



@implementation NSEOutputStream

@end










@interface NSEOutputStreamOperation ()

@end



@implementation NSEOutputStreamOperation

@dynamic delegates;
@dynamic object;

#pragma mark - NSStreamDelegate

- (void)stream:(NSOutputStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    [super stream:aStream handleEvent:eventCode];
    
    if (eventCode == NSStreamEventOpenCompleted) {
        [self.delegates nseOutputStreamOpenCompleted:aStream];
    } else if (eventCode == NSStreamEventHasSpaceAvailable) {
        [self.delegates nseOutputStreamHasSpaceAvailable:aStream];
    } else if (eventCode == NSStreamEventErrorOccurred) {
        [self.delegates nseOutputStreamErrorOccurred:aStream];
    } else if (eventCode == NSStreamEventEndEncountered) {
        [self.delegates nseOutputStreamEndEncountered:aStream];
    }
}

@end
