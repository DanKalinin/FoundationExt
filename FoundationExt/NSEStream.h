//
//  NSEStream.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEObjectOperation.h"
#import "NSETimeoutOperation.h"

@class NSEStream;
@class NSEStreamOpening;
@class NSEStreamOperation;

@protocol NSEStreamDelegate;
@protocol NSEStreamOpeningDelegate;










@interface NSStream (NSE)

@property (readonly) NSEStreamOperation *nseOperation;

@end










@interface NSEStream : NSStream

extern NSErrorDomain const NSEStreamErrorDomain;

NS_ERROR_ENUM(NSEStreamErrorDomain) {
    NSEStreamErrorUnknown = 0,
    NSEStreamErrorNotOpen = 1,
    NSEStreamErrorOpen = 2,
    NSEStreamErrorAtEnd = 3
};

@end










@protocol NSEStreamOpeningDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseStreamOpeningDidUpdateState:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidStart:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidCancel:(NSEStreamOpening *)opening;
- (void)nseStreamOpeningDidFinish:(NSEStreamOpening *)opening;

- (void)nseStreamOpeningDidUpdateProgress:(NSEStreamOpening *)opening;

@end



@interface NSEStreamOpening : NSETimeoutOperation <NSEStreamOpeningDelegate>

@property (readonly) NSEStreamOperation *parent;
@property (readonly) NSMutableOrderedSet<NSEStreamOpeningDelegate> *delegates;

@end










@protocol NSEStreamDelegate <NSEObjectDelegate, NSEStreamOpeningDelegate>

@optional
- (void)nseStreamOpenCompleted:(NSStream *)stream;
- (void)nseStreamHasBytesAvailable:(NSStream *)stream;
- (void)nseStreamHasSpaceAvailable:(NSStream *)stream;
- (void)nseStreamErrorOccurred:(NSStream *)stream;
- (void)nseStreamEndEncountered:(NSStream *)stream;

@end



@interface NSEStreamOperation : NSEObjectOperation <NSEStreamDelegate, NSStreamDelegate>

@property (weak) NSEStreamOpening *opening;

@property (readonly) NSMutableOrderedSet<NSEStreamDelegate> *delegates;

@property (weak, readonly) NSStream *object;

- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout;
- (NSEStreamOpening *)openWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
