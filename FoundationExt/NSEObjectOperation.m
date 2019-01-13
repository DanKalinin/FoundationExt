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
    NSEObjectOperation *operation = self.nseStrongDictionary[NSStringFromSelector(@selector(nseOperation))];
    
    if (operation) {
    } else {
        operation = [self.nseOperationClass.alloc initWithObject:self];
        self.nseStrongDictionary[NSStringFromSelector(@selector(nseOperation))] = operation;
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
