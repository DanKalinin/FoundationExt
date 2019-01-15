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

#pragma mark - NSStreamDelegate

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    if (eventCode == NSStreamEventOpenCompleted) {
        [self.delegates nseStreamOpenCompleted:aStream];
    } else if (eventCode == NSStreamEventHasBytesAvailable) {
        [self.delegates nseStreamHasBytesAvailable:aStream];
    } else if (eventCode == NSStreamEventHasSpaceAvailable) {
        [self.delegates nseStreamHasSpaceAvailable:aStream];
    } else if (eventCode == NSStreamEventErrorOccurred) {
        [self.delegates nseStreamErrorOccurred:aStream];
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
