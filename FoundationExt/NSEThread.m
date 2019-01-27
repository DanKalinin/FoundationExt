//
//  NSEThread.m
//  AVFoundationExt
//
//  Created by Dan Kalinin on 1/27/19.
//

#import "NSEThread.h"










@implementation NSThread (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSEThreadOperation.class;
}

@end










@interface NSEThread ()

@end



@implementation NSEThread

@end










@interface NSEThreadOperation ()

@end



@implementation NSEThreadOperation

@dynamic object;

@end
