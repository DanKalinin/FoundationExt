//
//  NSERPC.m
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSERPC.h"
#import "NSEDictionary.h"










@interface NSERPCIO ()

@end



@implementation NSERPCIO

@dynamic parent;

@end










@interface NSERPCI ()

@end



@implementation NSERPCI

#pragma mark - NSERPCIDelegate

- (void)nseRPCIDidFinish:(NSERPC *)rpcI {
    if (self.error) {
    } else if (self.isCancelled) {
    } else {
        if (self.type == NSERPCIOTypeReturn) {
            NSERPCO *output = self.parent.outputs[@(self.responseSerial)];
            output.response = self.response;
            output.responseError = self.responseError;
            [output finish];
        }
    }
}

@end










@interface NSERPCO ()

@property BOOL needsResponse;

@end



@implementation NSERPCO

- (instancetype)initWithMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.message = message;
    self.needsResponse = needsResponse;
    
    self.type = needsResponse ? NSERPCIOTypeCall : NSERPCIOTypeSignal;
    
    return self;
}

- (instancetype)initWithResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.response = response;
    self.responseError = responseError;
    self.responseSerial = responseSerial;
    
    self.type = NSERPCIOTypeReturn;
    
    return self;
}

#pragma mark - NSERPCODelegate

- (void)nseRPCODidStart:(NSERPC *)rpcO {
    self.serial = self.parent.sequence.value;
    [self.parent.sequence next];
    
    if (self.needsResponse) {
        self.parent.outputs[@(self.serial)] = self;
    }
}

@end










@interface NSERPC ()

@property NSEStreams *streams;
@property NSMutableDictionary<NSNumber *, NSERPCO *> *outputs;
@property NSERPCI *input;

@end



@implementation NSERPC

- (instancetype)initWithStreams:(NSEStreams *)streams {
    self = super.init;
    
    self.streams = streams;
    
    self.isAsynchronous = YES;
    self.sequence = [NSESequence.alloc initWithStart:INT64_MIN stop:INT64_MAX step:1];
    self.outputs = NSMutableDictionary.nseStrongToWeakDictionary;
    
    return self;
}

- (Class)iClass {
    return NSERPCI.class;
}

- (Class)oClass {
    return NSERPCO.class;
}

- (NSERPCI *)inputWithTimeout:(NSTimeInterval)timeout {
    NSERPCI *input = [(NSERPCI *)self.iClass.alloc initWithTimeout:timeout];
    
    [self addOperation:input];
    
    return input;
}

- (NSERPCI *)inputWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSERPCI *input = [self inputWithTimeout:timeout];
    
    input.completion = completion;
    
    return input;
}

- (NSERPCO *)outputMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout {
    NSERPCO *output = [(NSERPCO *)self.oClass.alloc initWithMessage:message needsResponse:needsResponse timeout:timeout];
    
    [self addOperation:output];
    
    return output;
}

- (NSERPCO *)outputMessage:(id)message needsResponse:(BOOL)needsResponse timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSERPCO *output = [self outputMessage:message needsResponse:needsResponse timeout:timeout];
    
    output.completion = completion;
    
    return output;
}

- (NSERPCO *)outputResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout {
    NSERPCO *output = [(NSERPCO *)self.oClass.alloc initWithResponse:response responseError:responseError responseSerial:responseSerial timeout:timeout];
    
    [self addOperation:output];
    
    return output;
}

- (NSERPCO *)outputResponse:(id)response responseError:(NSError *)responseError responseSerial:(int64_t)responseSerial timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSERPCO *output = [self outputResponse:response responseError:responseError responseSerial:responseSerial timeout:timeout];
    
    output.completion = completion;
    
    return output;
}

#pragma mark - NSERPCDelegate

- (void)nseRPCDidStart:(NSERPC *)rpc {
    self.input = [self inputWithTimeout:0.0];
}

- (void)nseRPCDidCancel:(NSERPC *)rpc {
    [self.input cancel];
}

#pragma mark - NSERPCIDelegate

- (void)nseRPCIDidFinish:(NSERPC *)rpcI {
    if (rpcI.error) {
    } else if (rpcI.isCancelled) {
    } else {
        self.input = [self inputWithTimeout:0.0];
    }
}

@end
