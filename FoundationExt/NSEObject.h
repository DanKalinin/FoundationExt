//
//  NSEObject.h
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEOperation.h"

@class NSEObject;
@class NSEObjectOperation;
@class NSECFObject;

@protocol NSEObjectDelegate;










@interface NSObject (NSE)

@property (readonly) Class nseOperationClass;
@property (readonly) NSEObjectOperation *nseOperation;

+ (instancetype)nseShared;

- (instancetype)nseAutorelease;

- (NSEObjectOperation *)nseOperationForKey:(void *)key ofClass:(Class)cls;

@end










@interface NSEObject : NSObject

@end










@protocol NSEObjectDelegate <NSEOperationDelegate>

@end



@interface NSEObjectOperation : NSEOperation <NSEObjectDelegate>

@property (weak, readonly) NSObject *object;

- (instancetype)initWithObject:(NSObject *)object;

@end










@interface NSECFObject : NSEOperation <NSEObjectDelegate>

@property (readonly) CFTypeRef object;

- (instancetype)initWithObject:(CFTypeRef)object;

@end
