//
//  NSEOrderedSet.h
//  Helpers
//
//  Created by Dan Kalinin on 1/8/19.
//

#import "NSEArray.h"

@class _NSEOrderedSet;



@interface _NSEOrderedSet : NSEArray

+ (instancetype)weakOrderedSet;
+ (instancetype)strongOrderedSet;

@end










#import "NSEObject.h"

@class NSEOrderedSet;
@class NSEOrderedSetOperation;
@class NSEMutableOrderedSet;
@class NSEMutableOrderedSetOperation;

@protocol NSEOrderedSetDelegate;
@protocol NSEMutableOrderedSetDelegate;










@interface NSOrderedSet (NSE)

@property (readonly) NSEOrderedSetOperation *nseOperation;

+ (instancetype)nseWeakOrderedSet;
+ (instancetype)nseStrongOrderedSet;

@end










@interface NSEOrderedSet : NSOrderedSet

@end










@protocol NSEOrderedSetDelegate <NSEObjectDelegate>

@end



@interface NSEOrderedSetOperation : NSEObjectOperation <NSEOrderedSetDelegate>

@property (weak, readonly) NSOrderedSet *object;

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)idx;
- (NSUInteger)indexOfObject:(id)object;

@end










@interface NSMutableOrderedSet (NSE)

@property (readonly) NSEMutableOrderedSetOperation *nseOperation;

@end










@interface NSEMutableOrderedSet : NSMutableOrderedSet

@end










@protocol NSEMutableOrderedSetDelegate <NSEOrderedSetDelegate>

@end



@interface NSEMutableOrderedSetOperation : NSEOrderedSetOperation <NSEMutableOrderedSetDelegate>

@property (weak, readonly) NSMutableOrderedSet *object;

@end
