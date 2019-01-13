//
//  NSEOrderedSet.m
//  Helpers
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEOrderedSet.h"



@interface _NSEOrderedSet ()

@end



@implementation _NSEOrderedSet

+ (instancetype)weakOrderedSet {
    return self.weakArray;
}

+ (instancetype)strongOrderedSet {
    return self.strongArray;
}

#pragma mark - NSMutableArray

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    BOOL contains = [self containsObject:anObject];
    if (contains) {
    } else {
        NSUInteger count = self.count;
        if (index > count) {
            index = count;
        }
        
        [super insertObject:anObject atIndex:index];
    }
}

- (void)addObject:(id)anObject {
    BOOL contains = [self containsObject:anObject];
    if (contains) {
    } else {
        [super addObject:anObject];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    BOOL contains = [self containsObject:anObject];
    if (contains) {
    } else {
        [super replaceObjectAtIndex:index withObject:anObject];
    }
}

@end










@implementation NSOrderedSet (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakOrderedSet {
    NSEOrderedSet *set = NSEOrderedSet.new;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEOrderedSet *set = NSEOrderedSet.new;
    return set;
}

- (Class)nseOperationClass {
    return NSEOrderedSetOperation.class;
}

@end










@interface NSEOrderedSet ()

@end



@implementation NSEOrderedSet

@end










@interface NSEOrderedSetOperation ()

@end



@implementation NSEOrderedSetOperation

@dynamic object;

@end










@implementation NSMutableOrderedSet (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakOrderedSet {
    NSEMutableOrderedSet *set = NSEMutableOrderedSet.new;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEMutableOrderedSet *set = NSEMutableOrderedSet.new;
    return set;
}

- (Class)nseOperationClass {
    return NSEMutableOrderedSetOperation.class;
}

@end










@interface NSEMutableOrderedSet ()

@end



@implementation NSEMutableOrderedSet

//@property (readonly) NSUInteger count;
//- (ObjectType)objectAtIndex:(NSUInteger)idx;
//- (NSUInteger)indexOfObject:(ObjectType)object;

//- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)idx;
//- (void)removeObjectAtIndex:(NSUInteger)idx;
//- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(ObjectType)object;

@end










@interface NSEMutableOrderedSetOperation ()

@end



@implementation NSEMutableOrderedSetOperation

@dynamic object;

//- (void)didAddObject:(id)object {
//    BOOL kind = [object isKindOfClass:self.class];
//    if (kind) {
//        NSEArray *array = object;
//        [array.exceptions unionSet:self.exceptions];
//        for (object in array) {
//            [array didAddObject:object];
//        }
//    }
//}
//
//- (void)willRemoveObject:(id)object {
//    BOOL kind = [object isKindOfClass:self.class];
//    if (kind) {
//        NSEArray *array = object;
//        [array.exceptions minusSet:self.exceptions];
//        for (object in array) {
//            [array willRemoveObject:object];
//        }
//    }
//}

//#pragma mark - NSMutableArray
//
//- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
//    [self.backingStore compact];
//
//    [self.backingStore insertPointer:(__bridge void *)anObject atIndex:index];
//
//    [self didAddObject:anObject];
//}
//
//- (void)removeObjectAtIndex:(NSUInteger)index {
//    [self.backingStore compact];
//
//    id object = self[index];
//    [self willRemoveObject:object];
//
//    [self.backingStore removePointerAtIndex:index];
//}
//
//- (void)addObject:(id)anObject {
//    [self.backingStore compact];
//
//    [self.backingStore addPointer:(__bridge void *)anObject];
//
//    [self didAddObject:anObject];
//}
//
//- (void)removeLastObject {
//    [self.backingStore compact];
//
//    [self willRemoveObject:self.lastObject];
//
//    NSUInteger index = self.backingStore.count - 1;
//    [self.backingStore removePointerAtIndex:index];
//}
//
//- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
//    [self.backingStore compact];
//
//    id object = self[index];
//    [self willRemoveObject:object];
//
//    [self.backingStore replacePointerAtIndex:index withPointer:(__bridge void *)anObject];
//
//    [self didAddObject:anObject];
//}
//
//#pragma mark - NSObject
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    for (id target in self) {
//        BOOL responds = [target respondsToSelector:anInvocation.selector];
//        if (responds) {
//            BOOL exception = [self.exceptions containsObject:NSStringFromSelector(anInvocation.selector)];
//            if (self.queue && !exception) {
//                [self.queue nseAddOperationWithBlock:^{
//                    [anInvocation invokeWithTarget:target];
//                } waitUntilFinished:YES];
//            } else {
//                [anInvocation invokeWithTarget:target];
//            }
//        }
//    }
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//
//    if (signature) {
//    } else {
//        for (id target in self) {
//            signature = [target methodSignatureForSelector:aSelector];
//            if (signature) {
//                break;
//            }
//        }
//    }
//
//    return signature;
//}
//
//- (BOOL)respondsToSelector:(SEL)aSelector {
//    BOOL responds = [super respondsToSelector:aSelector];
//
//    if (responds) {
//    } else {
//        for (id target in self) {
//            responds = [target respondsToSelector:aSelector];
//            if (responds) {
//                break;
//            }
//        }
//    }
//
//    return responds;
//}

@end
