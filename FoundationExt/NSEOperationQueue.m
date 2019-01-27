//
//  NSEOperationQueue.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/27/19.
//

#import "NSEOperationQueue.h"










@implementation NSOperationQueue (NSE)

@dynamic nseOperation;

+ (instancetype)nseSerialOperationQueue {
    NSEOperationQueue *queue = NSEOperationQueue.new;
    
    queue.maxConcurrentOperationCount = 1;
    
    return queue;
}

+ (instancetype)nseConcurrentOperationQueue {
    NSEOperationQueue *queue = NSEOperationQueue.new;
    return queue;
}

- (Class)nseOperationClass {
    return NSEOperationQueueOperation.class;
}

@end










@interface NSEOperationQueue ()

@end



@implementation NSEOperationQueue

@end










@interface NSEOperationQueueOperation ()

@end



@implementation NSEOperationQueueOperation

@dynamic object;

- (void)addOperationWithBlock:(NSEBlock)block waitUntilFinished:(BOOL)wait {
    if (block) {
        NSOperationQueue *queue = NSOperationQueue.currentQueue;
        BOOL current = [self.object isEqual:queue];
        BOOL serial = (queue.maxConcurrentOperationCount == 1);
        BOOL invoke = (wait && current && serial);
        if (invoke) {
            block();
        } else {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:block];
            [self.object addOperations:@[operation] waitUntilFinished:wait];
        }
    }
}

@end
