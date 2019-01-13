//
//  NSEDictionaryObject.h
//  Helpers
//
//  Created by Dan Kalinin on 1/10/19.
//

#import "NSEObjectOperation.h"

@class NSEDictionaryObject;



@interface NSEDictionaryObject : NSEObject

@property (readonly) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
