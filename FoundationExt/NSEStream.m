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

NSErrorDomain const NSEStreamErrorDomain = @"NSEStream";

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
    if (self.parent.object.streamStatus == NSStreamStatusNotOpen) {
        [self.parent.object scheduleInRunLoop:self.loop forMode:NSDefaultRunLoopMode];
        [self.parent.object open];
    } else {
        self.error = [NSError errorWithDomain:NSEStreamErrorDomain code:NSEStreamErrorOpen userInfo:nil];
        [self cancel];
    }
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
    NSEStreamOpening *opening = [self openWithTimeout:timeout];
    
    opening.completion = completion;
    
    return opening;
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
        
        self.opening.error = [NSError errorWithDomain:NSEStreamErrorDomain code:NSEStreamErrorAtEnd userInfo:nil];
        [self.opening cancel];
    }
}

@end
