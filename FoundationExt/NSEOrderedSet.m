//
//  NSEOrderedSet.m
//  FoundationExt
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEOrderedSet.h"
#import "NSEArray.h"










@implementation NSOrderedSet (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakOrderedSet {
    NSEOrderedSet *set = NSEOrderedSet.new;
    set.nseOperation.backingStore = NSArray.nseWeakArray;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEOrderedSet *set = NSEOrderedSet.new;
    set.nseOperation.backingStore = NSArray.nseStrongArray;
    return set;
}

- (Class)nseOperationClass {
    return NSEOrderedSetOperation.class;
}

@end










@interface NSEOrderedSet ()

@end



@implementation NSEOrderedSet

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectAtIndex:(NSUInteger)idx {
    id object = [self.nseOperation objectAtIndex:idx];
    return object;
}

- (NSUInteger)indexOfObject:(id)object {
    NSUInteger index = [self.nseOperation indexOfObject:object];
    return index;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [self.nseOperation _forwardInvocation:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (signature) {
    } else {
        signature = [self.nseOperation _methodSignatureForSelector:aSelector];
    }
    
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL responds = [super respondsToSelector:aSelector];
    
    if (responds) {
    } else {
        responds = [self.nseOperation _respondsToSelector:aSelector];
    }
    
    return responds;
}

@end










@interface NSEOrderedSetOperation ()

@property NSMutableSet *exceptions;

@end



@implementation NSEOrderedSetOperation

@dynamic object;

- (instancetype)initWithObject:(NSOrderedSet *)object {
    self = [super initWithObject:object];
    
    self.exceptions = NSMutableSet.set;
    
    return self;
}

- (NSUInteger)count {
    return self.backingStore.count;
}

- (id)objectAtIndex:(NSUInteger)idx {
    id object = [self.backingStore objectAtIndex:idx];
    return object;
}

- (NSUInteger)indexOfObject:(id)object {
    NSUInteger index = [self.backingStore indexOfObject:object];
    return index;
}

- (void)_forwardInvocation:(NSInvocation *)anInvocation {
    for (id target in self.object) {
        BOOL responds = [target respondsToSelector:anInvocation.selector];
        if (responds) {
            BOOL exception = [self.exceptions containsObject:NSStringFromSelector(anInvocation.selector)];
            if (self.invocationQueue && !exception) {
                [self.invocationQueue nseAddOperationWithBlock:^{
                    [anInvocation invokeWithTarget:target];
                } waitUntilFinished:YES];
            } else {
                [anInvocation invokeWithTarget:target];
            }
        }
    }
}

- (NSMethodSignature *)_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = nil;
    
    for (id target in self.object) {
        signature = [target methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }
    
    return signature;
}

- (BOOL)_respondsToSelector:(SEL)aSelector {
    BOOL responds = NO;
    
    for (id target in self.object) {
        responds = [target respondsToSelector:aSelector];
        if (responds) {
            break;
        }
    }
    
    return responds;
}

@end










@implementation NSMutableOrderedSet (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakOrderedSet {
    NSEMutableOrderedSet *set = NSEMutableOrderedSet.new;
    set.nseOperation.backingStore = NSMutableArray.nseWeakArray;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEMutableOrderedSet *set = NSEMutableOrderedSet.new;
    set.nseOperation.backingStore = NSMutableArray.nseStrongArray;
    return set;
}

- (Class)nseOperationClass {
    return NSEMutableOrderedSetOperation.class;
}

@end










@interface NSEMutableOrderedSet ()

@end



@implementation NSEMutableOrderedSet

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectAtIndex:(NSUInteger)idx {
    id object = [self.nseOperation objectAtIndex:idx];
    return object;
}

- (NSUInteger)indexOfObject:(id)object {
    NSUInteger index = [self.nseOperation indexOfObject:object];
    return index;
}

- (void)insertObject:(id)object atIndex:(NSUInteger)idx {
    [self.nseOperation insertObject:object atIndex:idx];
}

- (void)removeObjectAtIndex:(NSUInteger)idx {
    [self.nseOperation removeObjectAtIndex:idx];
}

- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object {
    [self.nseOperation replaceObjectAtIndex:idx withObject:object];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [self.nseOperation _forwardInvocation:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (signature) {
    } else {
        signature = [self.nseOperation _methodSignatureForSelector:aSelector];
    }
    
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL responds = [super respondsToSelector:aSelector];
    
    if (responds) {
    } else {
        responds = [self.nseOperation _respondsToSelector:aSelector];
    }
    
    return responds;
}

@end










@interface NSEMutableOrderedSetOperation ()

@end



@implementation NSEMutableOrderedSetOperation

@dynamic object;
@dynamic backingStore;

- (void)insertObject:(id)object atIndex:(NSUInteger)idx {
    BOOL contains = [self.object containsObject:object];
    if (contains) {
    } else {
        [self.backingStore insertObject:object atIndex:idx];
        
        [self didAddObject:object];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)idx {
    id object = self.object[idx];
    [self willRemoveObject:object];
    
    [self.backingStore removeObjectAtIndex:idx];
}

- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object {
    BOOL contains = [self.object containsObject:object];
    if (contains) {
    } else {
        id oldObject = self.object[idx];
        [self willRemoveObject:oldObject];
        
        [self.backingStore replaceObjectAtIndex:idx withObject:object];
        
        [self didAddObject:object];
    }
}

- (void)didAddObject:(id)object {
    BOOL kind = [object isKindOfClass:self.object.class];
    if (kind) {
        NSMutableOrderedSet *set = object;
        [set.nseOperation.exceptions unionSet:self.exceptions];
        for (object in set) {
            [set.nseOperation didAddObject:object];
        }
    }
}

- (void)willRemoveObject:(id)object {
    BOOL kind = [object isKindOfClass:self.object.class];
    if (kind) {
        NSMutableOrderedSet *set = object;
        [set.nseOperation.exceptions minusSet:self.exceptions];
        for (object in set) {
            [set.nseOperation willRemoveObject:object];
        }
    }
}

@end
