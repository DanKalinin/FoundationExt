//
//  NSEObjectOperation.h
//  FoundationExt
//
//  Created by Dan Kalinin on 1/14/19.
//

#import "NSEOperation.h"

@class NSEObjectOperation;
@class NSECFObjectOperation;

@protocol NSEObjectDelegate;










@interface NSObject (NSEObjectOperation)

@property (readonly) Class nseOperationClass;
@property (readonly) NSEObjectOperation *nseOperation;

@end










@protocol NSEObjectDelegate <NSEOperationDelegate>

@end



@interface NSEObjectOperation : NSEOperation <NSEObjectDelegate>

@property (weak, readonly) NSObject *object;

- (instancetype)initWithObject:(NSObject *)object;

@end










@interface NSECFObjectOperation : NSEOperation <NSEObjectDelegate>

@property (readonly) CFTypeRef object;

- (instancetype)initWithObject:(CFTypeRef)object;

@end
