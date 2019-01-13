//
//  NSEOperation.h
//  Helpers
//
//  Created by Dan Kalinin on 1/10/19.
//

#import "NSEObject.h"

@class NSEOperation;

@protocol NSEOperationDelegate;










@protocol NSEOperationDelegate <NSEObject>

@optional
- (void)nseOperationDidUpdateState:(NSEOperation *)operation;
- (void)nseOperationDidStart:(NSEOperation *)operation;
- (void)nseOperationDidCancel:(NSEOperation *)operation;
- (void)nseOperationDidFinish:(NSEOperation *)operation;

- (void)nseOperationDidUpdateProgress:(NSEOperation *)operation;

@end



@interface NSEOperation : NSOperation <NSEOperationDelegate, NSProgressReporting>

extern NSErrorDomain const NSEOperationErrorDomain;

NS_ERROR_ENUM(NSEOperationErrorDomain) {
    NSEOperationErrorUnknown = 0
};

typedef NS_ENUM(NSUInteger, NSEOperationState) {
    NSEOperationStateDidInit = 0,
    NSEOperationStateDidStart = 1,
    NSEOperationStateDidCancel = 99,
    NSEOperationStateDidFinish = 100
};

@property NSEOperationState state;
@property NSError *error;
@property NSEOperation *operation;

@property (nonatomic) BOOL isCancelled;
@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) BOOL isAsynchronous;
@property (nonatomic) BOOL isReady;

@property (copy) NSEBlock stateBlock;
@property (copy) NSEBlock progressBlock;

@property (readonly) NSEOperation *parent;

@property (nonatomic, readonly) NSMutableOrderedSet<NSEOperationDelegate> *delegates;
@property (nonatomic, readonly) NSProgress *progress;
@property (nonatomic, readonly) NSOperationQueue *queue;
@property (nonatomic, readonly) NSNotificationCenter *center;
@property (nonatomic, readonly) NSRunLoop *loop;

- (void)finish;
- (void)updateState:(NSEOperationState)state;
- (void)updateProgress:(int64_t)completedUnitCount;
- (void)addOperation:(NSEOperation *)operation;

@end










@interface NSOperationQueue (NSE)

- (void)nseAddOperationWithBlock:(NSEBlock)block waitUntilFinished:(BOOL)wait;

@end
