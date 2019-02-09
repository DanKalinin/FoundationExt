//
//  NSERPC.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSEStreams.h"
#import "NSESequence.h"

@class NSERPCIO;
@class NSERPCI;
@class NSERPCO;
@class NSERPC;

@protocol NSERPCIODelegate;
@protocol NSERPCIDelegate;
@protocol NSERPCODelegate;
@protocol NSERPCDelegate;










@protocol NSERPCIODelegate <NSETimeoutOperationDelegate>

@end



@interface NSERPCIO : NSETimeoutOperation <NSERPCIODelegate>

typedef NS_ENUM(NSUInteger, NSERPCIOType) {
    NSERPCIOTypeSignal,
    NSERPCIOTypeCall,
    NSERPCIOTypeReturn
};

@property NSERPCIOType type;
@property int64_t serial;
@property int64_t responseSerial;
@property id message;
@property id response;
@property NSError *responseError;

@property (readonly) NSERPC *parent;

@end










@protocol NSERPCIDelegate <NSERPCIODelegate>

@optional
- (void)nseRPCIDidUpdateState:(NSERPCI *)rpcI;
- (void)nseRPCIDidStart:(NSERPCI *)rpcI;
- (void)nseRPCIDidCancel:(NSERPCI *)rpcI;
- (void)nseRPCIDidFinish:(NSERPCI *)rpcI;

- (void)nseRPCIDidUpdateProgress:(NSERPCI *)rpcI;

@end



@interface NSERPCI : NSERPCIO <NSERPCIDelegate, NSEInputStreamReadingDelegate>

@property (readonly) NSMutableOrderedSet<NSERPCIDelegate> *delegates;

@end










@protocol NSERPCODelegate <NSERPCIODelegate>

@optional
- (void)nseRPCODidUpdateState:(NSERPCO *)rpcO;
- (void)nseRPCODidStart:(NSERPCO *)rpcO;
- (void)nseRPCODidCancel:(NSERPCO *)rpcO;
- (void)nseRPCODidFinish:(NSERPCO *)rpcO;

- (void)nseRPCODidUpdateProgress:(NSERPCO *)rpcO;

@end



@interface NSERPCO : NSERPCIO <NSERPCODelegate, NSEOutputStreamWritingDelegate>

@property (readonly) NSMutableOrderedSet<NSERPCODelegate> *delegates;
@property (readonly) BOOL needsResponse;

- (instancetype)initWithMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout;
- (instancetype)initWithResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout;

@end










@protocol NSERPCDelegate <NSEOperationDelegate, NSERPCIDelegate, NSERPCODelegate>

@optional
- (void)nseRPCDidUpdateState:(NSERPC *)rpc;
- (void)nseRPCDidStart:(NSERPC *)rpc;
- (void)nseRPCDidCancel:(NSERPC *)rpc;
- (void)nseRPCDidFinish:(NSERPC *)rpc;

- (void)nseRPCDidUpdateProgress:(NSERPC *)rpc;

@end



@interface NSERPC : NSEOperation <NSERPCDelegate>

@property NSESequence *sequence;

@property (readonly) NSEStreams *streams;
@property (readonly) Class iClass;
@property (readonly) Class oClass;
@property (readonly) NSMutableDictionary<NSNumber *, NSERPCO *> *outputs;
@property (readonly) NSERPCI *input;

- (instancetype)initWithStreams:(NSEStreams *)streams;

- (NSERPCI *)inputWithTimeout:(NSTimeInterval)timeout;
- (NSERPCI *)inputWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (NSERPCO *)outputMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout;
- (NSERPCO *)outputMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (NSERPCO *)outputResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout;
- (NSERPCO *)outputResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
