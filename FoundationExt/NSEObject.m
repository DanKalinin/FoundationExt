//
//  NSEObject.m
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEObject.h"










@implementation NSObject (NSE)

+ (instancetype)nseShared {
    static NSObject *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = self.new;
    });
    return shared;
}

- (Class)nseOperationClass {
    return NSEObjectOperation.class;
}

- (NSEObjectOperation *)nseOperation {
    NSEObjectOperation *operation = objc_getAssociatedObject(self, @selector(nseOperation));
    
    if (operation) {
    } else {
        operation = [(NSEObjectOperation *)self.nseOperationClass.alloc initWithObject:self];
        objc_setAssociatedObject(self, @selector(nseOperation), operation, OBJC_ASSOCIATION_RETAIN);
    }
    
    return operation;
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










@interface NSEObjectOperation ()

@property (weak) NSObject *object;

@end



@implementation NSEObjectOperation

- (instancetype)initWithObject:(NSObject *)object {
    self = super.init;
    
    self.object = object;
    
    return self;
}

@end










@interface NSECFObject ()

@property CFTypeRef object;

@end



@implementation NSECFObject

- (instancetype)initWithObject:(CFTypeRef)object {
    self = super.init;
    
    self.object = object;
    
    return self;
}

- (void)dealloc {
    CFRelease(self.object);
}

@end
