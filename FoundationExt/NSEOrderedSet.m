//
//  NSEOrderedSet.m
//  Helpers
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

@end










@interface NSEOrderedSetOperation ()

@end



@implementation NSEOrderedSetOperation

@dynamic object;

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

@end










@interface NSEMutableOrderedSetOperation ()

@end



@implementation NSEMutableOrderedSetOperation

@dynamic object;
@dynamic backingStore;

- (void)insertObject:(id)object atIndex:(NSUInteger)idx {
    [self.backingStore insertObject:object atIndex:idx];
}

- (void)removeObjectAtIndex:(NSUInteger)idx {
    [self.backingStore removeObjectAtIndex:idx];
}

- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object {
    [self.backingStore replaceObjectAtIndex:idx withObject:object];
}

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
