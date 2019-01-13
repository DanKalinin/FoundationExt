//
//  NSEDictionary.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "NSEObjectOperation.h"

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
