//
//  NSEOperation.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/10/19.
//

#import "NSEOperation.h"
#import "NSEOperationQueue.h"
#import "NSEOrderedSet.h"
#import "NSEDictionary.h"










@interface NSEOperation ()

@property (nonatomic) NSMutableOrderedSet<NSEOperationDelegate> *delegates;
@property (nonatomic) NSProgress *progress;
@property (nonatomic) NSOperationQueue *queue;

@end



@implementation NSEOperation

NSErrorDomain const NSEOperationErrorDomain = @"NSEOperation";

+ (instancetype)nseShared {
    static NSEOperation *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = self.new;
    });
    return shared;
}

+ (void)invokeBlock:(NSEBlock)block {
    if (block) {
        block();
    }
}

- (instancetype)init {
    self = super.init;
    
    self.isReady = YES;
    
    return self;
}

- (void)setIsCancelled:(BOOL)isCancelled {
    [self willChangeValueForKey:NSStringFromSelector(@selector(isCancelled))];
    _isCancelled = isCancelled;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isCancelled))];
}

- (void)setIsExecuting:(BOOL)isExecuting {
    [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
}

- (void)setIsFinished:(BOOL)isFinished {
    [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    _isFinished = isFinished;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
}

- (void)setIsAsynchronous:(BOOL)isAsynchronous {
    [self willChangeValueForKey:NSStringFromSelector(@selector(isAsynchronous))];
    _isAsynchronous = isAsynchronous;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isAsynchronous))];
}

- (void)setIsReady:(BOOL)isReady {
    [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    _isReady = isReady;
    [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
}

- (NSEOperation *)parent {
    return self.delegates[1][0];
}

- (NSMutableOrderedSet<NSEOperationDelegate> *)delegates {
    if (_delegates) {
    } else {
        _delegates = (id)NSMutableOrderedSet.nseWeakOrderedSet;
        _delegates.nseOperation.invocationQueue = NSOperationQueue.mainQueue;
        [_delegates addObject:self];
    }
    
    return _delegates;
}

- (NSProgress *)progress {
    if (_progress) {
    } else {
        _progress = NSProgress.new;
    }
    
    return _progress;
}

- (NSOperationQueue *)queue {
    if (_queue) {
    } else {
        _queue = NSOperationQueue.nseConcurrentOperationQueue;
    }
    
    return _queue;
}

- (void)start {
    if (self.isCancelled) {
        self.isFinished = YES;
        [self updateState:NSEOperationStateDidFinish];
    } else {
        self.isExecuting = YES;
        [self updateState:NSEOperationStateDidStart];
        if (self.isAsynchronous) {
            [NSThread detachNewThreadWithBlock:^{
                [self main];
            }];
        } else {
            [self main];
        }
    }
}

- (void)cancel {
    if (self.isCancelled || self.isFinished) {
    } else {
        self.isCancelled = YES;
        [self updateState:NSEOperationStateDidCancel];
    }
}

- (void)finish {
    if (self.isFinished || !self.isExecuting) {
    } else {
        self.isExecuting = NO;
        self.isFinished = YES;
        [self updateState:NSEOperationStateDidFinish];
    }
}

- (void)updateState:(NSEOperationState)state {
    self.state = state;
    
    [self.delegates nseOperationDidUpdateState:self];
    [self.delegates.nseOperation.invocationQueue.nseOperation addOperationWithBlock:self.stateBlock waitUntilFinished:YES];
    if (self.state == NSEOperationStateDidStart) {
        [self.delegates nseOperationDidStart:self];
    } else if (self.state == NSEOperationStateDidCancel) {
        [self.delegates nseOperationDidCancel:self];
    } else if (self.state == NSEOperationStateDidFinish) {
        [self.delegates nseOperationDidFinish:self];
        [self.delegates.nseOperation.invocationQueue.nseOperation addOperationWithBlock:self.completion waitUntilFinished:YES];
        
        self.completion = nil;
        self.stateBlock = nil;
        self.progressBlock = nil;
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    self.progress.completedUnitCount = completedUnitCount;
    
    [self.delegates nseOperationDidUpdateProgress:self];
    [self.delegates.nseOperation.invocationQueue.nseOperation addOperationWithBlock:self.progressBlock waitUntilFinished:YES];
}

- (void)addOperation:(NSEOperation *)operation {
    [operation.delegates addObject:self.delegates];
    [self.queue addOperation:operation];
}

@end
