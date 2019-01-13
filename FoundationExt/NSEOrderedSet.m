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
    set.nseOperation.backingStore = NSPointerArray.weakObjectsPointerArray;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEOrderedSet *set = NSEOrderedSet.new;
    set.nseOperation.backingStore = NSPointerArray.strongObjectsPointerArray;
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
    set.nseOperation.backingStore = NSPointerArray.weakObjectsPointerArray;
    return set;
}

+ (instancetype)nseStrongOrderedSet {
    NSEMutableOrderedSet *set = NSEMutableOrderedSet.new;
    set.nseOperation.backingStore = NSPointerArray.strongObjectsPointerArray;
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

@end
