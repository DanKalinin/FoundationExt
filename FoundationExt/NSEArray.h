//
//  NSEArray.h
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEObject.h"

@class NSEArray;
@class NSEArrayOperation;
@class NSEMutableArray;
@class NSEMutableArrayOperation;

@protocol NSEArrayDelegate;
@protocol NSEMutableArrayDelegate;










@interface NSArray (NSE)

@property (readonly) NSEArrayOperation *nseOperation;

+ (instancetype)nseWeakArray;
+ (instancetype)nseStrongArray;

@end










@interface NSEArray : NSArray

@end










@protocol NSEArrayDelegate <NSEObjectDelegate>

@end



@interface NSEArrayOperation : NSEObjectOperation <NSEArrayDelegate>

@property NSPointerArray *backingStore;

@property (readonly) NSUInteger count;

@property (weak, readonly) NSArray *object;

- (id)objectAtIndex:(NSUInteger)index;

@end










@interface NSMutableArray (NSE)

@property (readonly) NSEMutableArrayOperation *nseOperation;

@end










@interface NSEMutableArray : NSMutableArray

@end










@protocol NSEMutableArrayDelegate <NSEArrayDelegate>

@end



@interface NSEMutableArrayOperation : NSEArrayOperation <NSEMutableArrayDelegate>

@property (weak, readonly) NSMutableArray *object;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
