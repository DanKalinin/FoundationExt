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
