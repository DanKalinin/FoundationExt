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

- (NSMutableDictionary *)nseWeakDictionary {
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, @selector(nseWeakDictionary));
    
    if (dictionary) {
    } else {
        dictionary = NSMutableDictionary.nseStrongToWeakDictionary;
        objc_setAssociatedObject(self, @selector(nseWeakDictionary), dictionary, OBJC_ASSOCIATION_RETAIN);
    }
    
    return dictionary;
}

- (NSMutableDictionary *)nseStrongDictionary {
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, @selector(nseStrongDictionary));
    
    if (dictionary) {
    } else {
        dictionary = NSMutableDictionary.dictionary;
        objc_setAssociatedObject(self, @selector(nseStrongDictionary), dictionary, OBJC_ASSOCIATION_RETAIN);
    }
    
    return dictionary;
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
