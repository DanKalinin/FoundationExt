//
//  NSEDictionary.m
//  Helpers
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "NSEDictionary.h"










@implementation NSDictionary (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakToWeakDictionary {
    NSEDictionary *dictionary = NSEDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.weakToWeakObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseWeakToStrongDictionary {
    NSEDictionary *dictionary = NSEDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.weakToStrongObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseStrongToWeakDictionary {
    NSEDictionary *dictionary = NSEDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.strongToWeakObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseStrongToStrongDictionary {
    NSEDictionary *dictionary = NSEDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.strongToStrongObjectsMapTable;
    return dictionary;
}

- (Class)nseOperationClass {
    return NSEDictionaryOperation.class;
}

@end










@interface NSEDictionary ()

@end



@implementation NSEDictionary

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectForKey:(id)aKey {
    id object = [self.nseOperation objectForKey:aKey];
    return object;
}

- (NSEnumerator *)keyEnumerator {
    return self.nseOperation.keyEnumerator;
}

@end










@interface NSEDictionaryOperation ()

@end



@implementation NSEDictionaryOperation

@dynamic object;

- (NSUInteger)count {
    return self.backingStore.count;
}

- (id)objectForKey:(id)aKey {
    id object = [self.backingStore objectForKey:aKey];
    return object;
}

- (NSEnumerator *)keyEnumerator {
    return self.backingStore.keyEnumerator;
}

@end










@implementation NSMutableDictionary (NSE)

@dynamic nseOperation;

+ (instancetype)nseWeakToWeakDictionary {
    NSEMutableDictionary *dictionary = NSEMutableDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.weakToWeakObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseWeakToStrongDictionary {
    NSEMutableDictionary *dictionary = NSEMutableDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.weakToStrongObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseStrongToWeakDictionary {
    NSEMutableDictionary *dictionary = NSEMutableDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.strongToWeakObjectsMapTable;
    return dictionary;
}

+ (instancetype)nseStrongToStrongDictionary {
    NSEMutableDictionary *dictionary = NSEMutableDictionary.new;
    dictionary.nseOperation.backingStore = NSMapTable.strongToStrongObjectsMapTable;
    return dictionary;
}

- (Class)nseOperationClass {
    return NSEMutableDictionaryOperation.class;
}

@end










@interface NSEMutableDictionary ()

@end



@implementation NSEMutableDictionary

- (NSUInteger)count {
    return self.nseOperation.count;
}

- (id)objectForKey:(id)aKey {
    id object = [self.nseOperation objectForKey:aKey];
    return object;
}

- (NSEnumerator *)keyEnumerator {
    return self.nseOperation.keyEnumerator;
}

- (void)removeObjectForKey:(id)aKey {
    [self.nseOperation removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    [self.nseOperation setObject:anObject forKey:aKey];
}

@end










@interface NSEMutableDictionaryOperation ()

@end



@implementation NSEMutableDictionaryOperation

@dynamic object;

- (void)removeObjectForKey:(id)aKey {
    [self.backingStore removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    [self.backingStore setObject:anObject forKey:aKey];
}

@end
