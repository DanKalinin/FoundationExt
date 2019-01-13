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
@class NSEDictionaryObject;

@protocol NSEDictionaryDelegate;










@interface NSDictionary (NSE)

@end










@interface NSEDictionary : NSDictionary

@end










@protocol NSEDictionaryDelegate <NSEObjectDelegate>

@end



@interface NSEDictionaryOperation : NSEObjectOperation <NSEDictionaryDelegate>

@end










@interface NSMutableDictionary (NSE)

@end










@interface NSEMutableDictionary : NSMutableDictionary

@end










@protocol NSEMutableDictionaryDelegate <NSEDictionaryDelegate>

@end



@interface NSEMutableDictionaryOperation : NSEDictionaryOperation <NSEMutableDictionaryDelegate>

@end
