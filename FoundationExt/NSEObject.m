//
//  NSEObject.m
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEObject.h"
#import "NSEDictionary.h"










@implementation NSObject (NSE)

+ (instancetype)nseShared {
    static NSObject *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = self.new;
    });
    return shared;
}

- (instancetype)nseAutorelease {
    __autoreleasing NSObject *object = self;
    return object;
}

@end










@interface NSEObject ()

@end



@implementation NSEObject

@end
