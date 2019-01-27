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
    if (self.parent.object.streamStatus == NSStreamStatusOpen) {
        self.progress.totalUnitCount = self.data.length;
        
        if (self.parent.object.hasSpaceAvailable) {
            [self.parent stream:self.parent.object handleEvent:NSStreamEventHasSpaceAvailable];
        }
    } else {
        self.error = [NSError errorWithDomain:NSEStreamErrorDomain code:NSEStreamErrorNotOpen userInfo:nil];
        [self cancel];
    }
}

- (void)nseOutputStreamWritingDidCancel:(NSEOutputStreamWriting *)writing {
    [self finish];
}

@end










@interface NSEOutputStreamOperation ()

@property (weak) NSEOutputStreamWriting *writing;

@end



@implementation NSEOutputStreamOperation

@dynamic delegates;
@dynamic object;

- (NSEOutputStreamWriting *)writeData:(NSMutableData *)data timeout:(NSTimeInterval)timeout {
    self.writing = [NSEOutputStreamWriting.alloc initWithData:data timeout:timeout].nseAutorelease;
    
    [self addOperation:self.writing];
    
    return self.writing;
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
        
        if (self.writing.isCancelled) {
        } else if (self.writing.data.length > 0) {
            NSInteger result = [aStream write:self.writing.data.bytes maxLength:self.writing.data.length];
            if (result > 0) {
                NSRange range = NSMakeRange(0, result);
                [self.writing.data replaceBytesInRange:range withBytes:NULL length:0];
                
                int64_t completedUnitCount = self.writing.progress.completedUnitCount + result;
                [self.writing updateProgress:completedUnitCount];
                
                if (self.writing.data.length == 0) {
                    [self.writing finish];
                }
            }
        }
    } else if (eventCode == NSStreamEventErrorOccurred) {
        [self.delegates nseOutputStreamErrorOccurred:aStream];
        
        self.writing.error = aStream.streamError;
        [self.writing cancel];
    } else if (eventCode == NSStreamEventEndEncountered) {
        [self.delegates nseOutputStreamEndEncountered:aStream];
        
        self.writing.error = [NSError errorWithDomain:NSEStreamErrorDomain code:NSEStreamErrorAtEnd userInfo:nil];
        [self.writing cancel];
    }
}

@end
