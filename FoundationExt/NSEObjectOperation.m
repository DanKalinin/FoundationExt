//
//  NSEObjectOperation.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/14/19.
//

#import "NSEObjectOperation.h"










@implementation NSObject (NSEObjectOperation)

- (Class)nseOperationClass {
    return NSEObjectOperation.class;
}

- (NSEObjectOperation *)nseOperation {
    NSEObjectOperation *operation = objc_getAssociatedObject(self, @selector(nseOperation));
    
    if (operation) {
    } else {
        operation = [self.nseOperationClass.alloc initWithObject:self];
        objc_setAssociatedObject(self, @selector(nseOperation), operation, OBJC_ASSOCIATION_RETAIN);
    }
    
    return operation;
}

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










@interface NSECFObjectOperation ()

@property CFTypeRef object;

@end



@implementation NSECFObjectOperation

- (instancetype)initWithObject:(CFTypeRef)object {
    self = super.init;
    
    self.object = object;
    
    return self;
}

- (void)dealloc {
    CFRelease(self.object);
}

@end
