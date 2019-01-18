//
//  NSEInputStream.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/18/19.
//

#import "NSEStream.h"

@class NSEInputStream;
@class NSEInputStreamReading;
@class NSEInputStreamOperation;

@protocol NSEInputStreamDelegate;
@protocol NSEInputStreamReadingDelegate;










@interface NSInputStream (NSE)

@property (readonly) NSEInputStreamOperation *nseOperation;

@end










@interface NSEInputStream : NSInputStream

@end










@protocol NSEInputStreamReadingDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseInputStreamReadingDidUpdateState:(NSEInputStreamReading *)reading;
- (void)nseInputStreamReadingDidStart:(NSEInputStreamReading *)reading;
- (void)nseInputStreamReadingDidCancel:(NSEInputStreamReading *)reading;
- (void)nseInputStreamReadingDidFinish:(NSEInputStreamReading *)reading;

- (void)nseInputStreamReadingDidUpdateProgress:(NSEInputStreamReading *)reading;

@end



@interface NSEInputStreamReading : NSETimeoutOperation <NSEInputStreamReadingDelegate>

@property (readonly) NSEInputStreamOperation *parent;
@property (readonly) NSMutableOrderedSet<NSEInputStreamReadingDelegate> *delegates;
@property (readonly) NSUInteger length;

- (instancetype)initWithLength:(NSUInteger)length timeout:(NSTimeInterval)timeout;

@end










@protocol NSEInputStreamDelegate <NSEStreamDelegate, NSEInputStreamReadingDelegate>

@optional
- (void)nseInputStreamOpenCompleted:(NSInputStream *)inputStream;
- (void)nseInputStreamHasBytesAvailable:(NSInputStream *)inputStream;
- (void)nseInputStreamErrorOccurred:(NSInputStream *)inputStream;
- (void)nseInputStreamEndEncountered:(NSInputStream *)inputStream;

@end



@interface NSEInputStreamOperation : NSEStreamOperation <NSEInputStreamDelegate>

@property (readonly) NSMutableOrderedSet<NSEInputStreamDelegate> *delegates;

@property (weak, readonly) NSInputStream *object;
@property (weak, readonly) NSEInputStreamReading *reading;

- (NSEInputStreamReading *)readDataOfLength:(NSUInteger)length timeout:(NSTimeInterval)timeout;
- (NSEInputStreamReading *)readDataOfLength:(NSUInteger)length timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
