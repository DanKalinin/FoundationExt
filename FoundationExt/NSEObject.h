//
//  NSEObject.h
//  FoundationExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "NSEMain.h"

@class NSEObject;

@protocol NSEObject;










@protocol NSEObject <NSObject>

@end



@interface NSObject (NSE) <NSEObject>

@property (readonly) NSMutableDictionary *nseWeakDictionary;
@property (readonly) NSMutableDictionary *nseStrongDictionary;

+ (instancetype)nseShared;
+ (void)nseInvokeBlock:(NSEBlock)block;

- (instancetype)nseAutorelease;
- (void)nseInvokeBlock:(NSEBlock)block;

@end










@interface NSEObject : NSObject

@end
