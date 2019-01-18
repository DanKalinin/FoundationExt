//
//  NSEOutputStream.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEOutputStream.h"










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
