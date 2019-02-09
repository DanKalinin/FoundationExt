//
//  NSERPC.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSEStreams.h"

@class NSERPCIO;
@class NSERPC;

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

@end










@protocol NSERPCIDelegate <NSERPCIODelegate>

@end



@interface NSERPCI : NSERPCIO

@end










@protocol NSERPCODelegate <NSERPCIODelegate>

@end



@interface NSERPCO : NSERPCIO <NSERPCODelegate>

@end










@protocol NSERPCDelegate <NSEOperationDelegate>

@optional
- (void)nseRPCDidUpdateState:(NSERPC *)rpc;
- (void)nseRPCDidStart:(NSERPC *)rpc;
- (void)nseRPCDidCancel:(NSERPC *)rpc;
- (void)nseRPCDidFinish:(NSERPC *)rpc;

- (void)nseRPCDidUpdateProgress:(NSERPC *)rpc;

@end



@interface NSERPC : NSEOperation <NSERPCDelegate>

@property (readonly) NSEStreams *streams;
@property (readonly) Class iClass;
@property (readonly) Class oClass;

- (instancetype)initWithStreams:(NSEStreams *)streams;

@end
