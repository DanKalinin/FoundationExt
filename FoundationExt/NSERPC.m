//
//  NSERPC.m
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSERPC.h"










@interface NSERPCI ()

@end



@implementation NSERPCI

@end










@interface NSERPCO ()

@end



@implementation NSERPCO

@end










@interface NSERPC ()

@property NSEStreams *streams;

@end



@implementation NSERPC

- (instancetype)initWithStreams:(NSEStreams *)streams {
    self = super.init;
    
    self.streams = streams;
    
    return self;
}

- (Class)iClass {
    return NSERPCI.class;
}

- (Class)oClass {
    return NSERPCO.class;
}

- (void)nseRPCDidStart:(NSERPC *)rpc {
    
}

@end
