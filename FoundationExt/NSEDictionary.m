//
//  NSEDictionary.m
//  Helpers
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "NSEDictionary.h"










@implementation NSDictionary (_NSE)

- (_NSEDictionary *)nseWeakToWeakDictionary {
    _NSEDictionary *dictionary = _NSEDictionary.weakToWeakDictionary;
    [dictionary addEntriesFromDictionary:self];
    return dictionary;
}

- (_NSEDictionary *)nseWeakToStrongDictionary {
    _NSEDictionary *dictionary = _NSEDictionary.weakToStrongDictionary;
    [dictionary addEntriesFromDictionary:self];
    return dictionary;
}

- (_NSEDictionary *)nseStrongToWeakDictionary {
    _NSEDictionary *dictionary = _NSEDictionary.strongToWeakDictionary;
    [dictionary addEntriesFromDictionary:self];
    return dictionary;
}

- (_NSEDictionary *)nseStrongToStrongDictionary {
    _NSEDictionary *dictionary = _NSEDictionary.strongToStrongDictionary;
    [dictionary addEntriesFromDictionary:self];
    return dictionary;
}

@end










@interface _NSEDictionary ()

@property NSMapTable *backingStore;

@end



@implementation _NSEDictionary

+ (instancetype)weakToWeakDictionary {
    _NSEDictionary *dictionary = [self.alloc initWithBackingStore:NSMapTable.weakToWeakObjectsMapTable];
    return dictionary;
}

+ (instancetype)weakToStrongDictionary {
    _NSEDictionary *dictionary = [self.alloc initWithBackingStore:NSMapTable.weakToStrongObjectsMapTable];
    return dictionary;
}

+ (instancetype)strongToWeakDictionary {
    _NSEDictionary *dictionary = [self.alloc initWithBackingStore:NSMapTable.strongToWeakObjectsMapTable];
    return dictionary;
}

+ (instancetype)strongToStrongDictionary {
    _NSEDictionary *dictionary = [self.alloc initWithBackingStore:NSMapTable.strongToStrongObjectsMapTable];
    return dictionary;
}

- (instancetype)initWithBackingStore:(NSMapTable *)backingStore {
    self = super.init;
    
    self.backingStore = backingStore;
    
    return self;
}

#pragma mark - NSDictionary

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

#pragma mark - NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    [self.backingStore setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey {
    [self.backingStore removeObjectForKey:aKey];
}

@end
