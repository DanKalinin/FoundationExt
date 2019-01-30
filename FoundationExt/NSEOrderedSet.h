//
//  NSEOrderedSet.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/8/19.
//

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

@property NSArray *backingStore;
@property NSOperationQueue *invocationQueue;

@property (readonly) NSMutableSet *exceptions;
@property (readonly) NSUInteger count;

@property (weak, readonly) NSOrderedSet *object;

- (id)objectAtIndex:(NSUInteger)idx;
- (NSUInteger)indexOfObject:(id)object;

- (void)_forwardInvocation:(NSInvocation *)anInvocation;
- (NSMethodSignature *)_methodSignatureForSelector:(SEL)aSelector;
- (BOOL)_respondsToSelector:(SEL)aSelector;

@end










@interface NSMutableOrderedSet (NSE)

@property (readonly) NSEMutableOrderedSetOperation *nseOperation;

@end










@interface NSEMutableOrderedSet : NSMutableOrderedSet

@end










@protocol NSEMutableOrderedSetDelegate <NSEOrderedSetDelegate>

@end



@interface NSEMutableOrderedSetOperation : NSEOrderedSetOperation <NSEMutableOrderedSetDelegate>

@property NSMutableArray *backingStore;

@property (weak, readonly) NSMutableOrderedSet *object;

- (void)insertObject:(id)object atIndex:(NSUInteger)idx;
- (void)removeObjectAtIndex:(NSUInteger)idx;
- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object;

- (void)didAddObject:(id)object;
- (void)willRemoveObject:(id)object;

@end
