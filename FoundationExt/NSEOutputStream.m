//
//  NSEOutputStream.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEOutputStream.h"










@implementation NSOutputStream (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSEOutputStreamOperation.class;
}

@end










@interface NSEOutputStream ()

@end



@implementation NSEOutputStream

@end










@interface NSEOutputStreamWriting ()

@property NSMutableData *data;

@end



@implementation NSEOutputStreamWriting

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithData:(NSMutableData *)data timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.data = data;
    
    return self;
}

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseOutputStreamWritingDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseOutputStreamWritingDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseOutputStreamWritingDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseOutputStreamWritingDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseOutputStreamWritingDidUpdateProgress:self];
}

#pragma mark - NSEOutputStreamWritingDelegate

- (void)nseOutputStreamWritingDidStart:(NSEOutputStreamWriting *)writing {
    
}

@end










@interface NSEOutputStreamOperation ()

@end



@implementation NSEOutputStreamOperation

@dynamic delegates;
@dynamic object;

- (NSEOutputStreamWriting *)writeData:(NSMutableData *)data timeout:(NSTimeInterval)timeout {
    NSEOutputStreamWriting *writing = [NSEOutputStreamWriting.alloc initWithData:data timeout:timeout];
    
    [self addOperation:writing];
    
    return writing;
}

- (NSEOutputStreamWriting *)writeData:(NSMutableData *)data timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSEOutputStreamWriting *writing = [self writeData:data timeout:timeout];
    
    writing.completion = completion;
    
    return writing;
}

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
