//
//  NSEDictionary.h
//  Helpers
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "NSEObject.h"

@class _NSEDictionary;










@interface NSDictionary (_NSE)

@property (readonly) _NSEDictionary *nseWeakToWeakDictionary;
@property (readonly) _NSEDictionary *nseWeakToStrongDictionary;
@property (readonly) _NSEDictionary *nseStrongToWeakDictionary;
@property (readonly) _NSEDictionary *nseStrongToStrongDictionary;

@end










@interface _NSEDictionary : NSMutableDictionary

@property (readonly) NSMapTable *backingStore;

+ (instancetype)weakToWeakDictionary;
+ (instancetype)weakToStrongDictionary;
+ (instancetype)strongToWeakDictionary;
+ (instancetype)strongToStrongDictionary;

- (instancetype)initWithBackingStore:(NSMapTable *)backingStore;

@end










#import "NSEObject.h"

@class NSEDictionary;
@class NSEDictionaryOperation;
@class NSEMutableDictionary;
@class NSEMutableDictionaryOperation;

@protocol NSEDictionaryDelegate;
@protocol NSEMutableDictionaryDelegate;










@interface NSDictionary (NSE)

@property (readonly) NSEDictionaryOperation *nseOperation;

+ (instancetype)nseWeakToWeakDictionary;
+ (instancetype)nseWeakToStrongDictionary;
+ (instancetype)nseStrongToWeakDictionary;
+ (instancetype)nseStrongToStrongDictionary;

@end










@interface NSEDictionary : NSDictionary

@end










@protocol NSEDictionaryDelegate <NSEObjectDelegate>

@end



@interface NSEDictionaryOperation : NSEObjectOperation <NSEDictionaryDelegate>

@property NSMapTable *backingStore;

@property (readonly) NSUInteger count;
@property (readonly) NSEnumerator *keyEnumerator;

@property (weak, readonly) NSDictionary *object;

- (id)objectForKey:(id)aKey;

@end










@interface NSMutableDictionary (NSE)

@property (readonly) NSEMutableDictionaryOperation *nseOperation;

@end










@interface NSEMutableDictionary : NSMutableDictionary

@end










@protocol NSEMutableDictionaryDelegate <NSEDictionaryDelegate>

@end



@interface NSEMutableDictionaryOperation : NSEDictionaryOperation <NSEMutableDictionaryDelegate>

@property (weak, readonly) NSMutableDictionary *object;

- (void)removeObjectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id)aKey;

@end
