//
//  NSENetService.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSEObject.h"
#import "NSETimeoutOperation.h"

@class NSENetService;
@class NSENetServiceOperation;

@protocol NSENetServiceDelegate;










@interface NSNetService (NSE)

@property (readonly) NSENetServiceOperation *nseOperation;

@end










@interface NSENetService : NSNetService

typedef NS_ENUM(NSUInteger, NSENetServiceDomains) {
    NSENetServiceDomainsBrowsable,
    NSENetServiceDomainsRegistration
};

@end










@protocol NSENetServiceDelegate <NSEObjectDelegate>

@end



@interface NSENetServiceOperation : NSEObjectOperation <NSENetServiceDelegate, NSNetServiceDelegate>

@property (weak, readonly) NSNetService *object;

@end
