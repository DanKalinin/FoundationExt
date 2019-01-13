//
//  NSEArray.m
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEArray.h"










@implementation NSArray (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakArray {
    NSEArray *array = NSEArray.new;
    array.nseOperation.backingStore = NSPointerArray.weakObjectsPointerArray;
    return array;
}

+ (instancetype)nseStrongArray {
    NSEArray *array = NSEArray.new;
    array.nseOperation.backingStore = NSPointerArray.strongObjectsPointerArray;
    return array;
}

- (Class)nseOperationClass {
    return NSEArrayOperation.class;
}

@end










@interface NSEArray ()

@end



@implementation NSEArray

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    id object = [self.nseOperation objectAtIndex:index];
    return object;
}

@end










@interface NSEArrayOperation ()

@end



@implementation NSEArrayOperation

@dynamic object;

- (NSUInteger)count {
    [self.backingStore compact];
    
    return self.backingStore.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    [self.backingStore compact];
    
    id object = (__bridge id)[self.backingStore pointerAtIndex:index];
    return object;
}

@end










@implementation NSMutableArray (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakArray {
    NSEMutableArray *array = NSEMutableArray.new;
    array.nseOperation.backingStore = NSPointerArray.weakObjectsPointerArray;
    return array;
}

+ (instancetype)nseStrongArray {
    NSEMutableArray *array = NSEMutableArray.new;
    array.nseOperation.backingStore = NSPointerArray.strongObjectsPointerArray;
    return array;
}

- (Class)nseOperationClass {
    return NSEMutableArrayOperation.class;
}

@end










@interface NSEMutableArray ()

@end



@implementation NSEMutableArray

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    id object = [self.nseOperation objectAtIndex:index];
    return object;
}

- (void)addObject:(id)anObject {
    [self.nseOperation addObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.nseOperation insertObject:anObject atIndex:index];
}

- (void)removeLastObject {
    [self.nseOperation removeLastObject];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.nseOperation removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.nseOperation replaceObjectAtIndex:index withObject:anObject];
}

@end










@interface NSEMutableArrayOperation ()

@end



@implementation NSEMutableArrayOperation

@dynamic object;

- (void)addObject:(id)anObject {
    [self.backingStore compact];
    
    [self.backingStore addPointer:(__bridge void *)anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.backingStore compact];
    
    [self.backingStore insertPointer:(__bridge void *)anObject atIndex:index];
}

- (void)removeLastObject {
    [self.backingStore compact];
    
    NSUInteger index = self.backingStore.count - 1;
    [self.backingStore removePointerAtIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.backingStore compact];
    
    [self.backingStore removePointerAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.backingStore compact];
    
    [self.backingStore replacePointerAtIndex:index withPointer:(__bridge void *)anObject];
}

@end
