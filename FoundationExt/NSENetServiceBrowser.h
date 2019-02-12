//
//  NSENetServiceBrowser.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSEObject.h"
#import "NSENetService.h"

@class NSENetServiceBrowser;
@class NSENetServiceBrowserDomainsSearch;
@class NSENetServiceBrowserServicesSearch;
@class NSENetServiceBrowserOperation;

@protocol NSENetServiceBrowserDelegate;
@protocol NSENetServiceBrowserDomainsSearchDelegate;
@protocol NSENetServiceBrowserServicesSearchDelegate;










@interface NSNetServiceBrowser (NSE)

@property (readonly) NSENetServiceBrowserOperation *nseOperation;

@end










@interface NSENetServiceBrowser : NSNetServiceBrowser

@end










@protocol NSENetServiceBrowserDomainsSearchDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseNetServiceBrowserDomainsSearchDidUpdateState:(NSENetServiceBrowserDomainsSearch *)search;
- (void)nseNetServiceBrowserDomainsSearchDidStart:(NSENetServiceBrowserDomainsSearch *)search;
- (void)nseNetServiceBrowserDomainsSearchDidCancel:(NSENetServiceBrowserDomainsSearch *)search;
- (void)nseNetServiceBrowserDomainsSearchDidFinish:(NSENetServiceBrowserDomainsSearch *)search;

- (void)nseNetServiceBrowserDomainsSearchDidUpdateProgress:(NSENetServiceBrowserDomainsSearch *)search;

@end



@interface NSENetServiceBrowserDomainsSearch : NSETimeoutOperation <NSENetServiceBrowserDomainsSearchDelegate>

@property (readonly) NSENetServiceBrowserOperation *parent;
@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserDomainsSearchDelegate> *delegates;
@property (readonly) NSENetServiceDomains domains;

- (instancetype)initWithDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout;

@end










@protocol NSENetServiceBrowserServicesSearchDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseNetServiceBrowserServicesSearchDidUpdateState:(NSENetServiceBrowserServicesSearch *)search;
- (void)nseNetServiceBrowserServicesSearchDidStart:(NSENetServiceBrowserServicesSearch *)search;
- (void)nseNetServiceBrowserServicesSearchDidCancel:(NSENetServiceBrowserServicesSearch *)search;
- (void)nseNetServiceBrowserServicesSearchDidFinish:(NSENetServiceBrowserServicesSearch *)search;

- (void)nseNetServiceBrowserServicesSearchDidUpdateProgress:(NSENetServiceBrowserServicesSearch *)search;

@end



@interface NSENetServiceBrowserServicesSearch : NSETimeoutOperation <NSENetServiceBrowserServicesSearchDelegate>

@property (readonly) NSENetServiceBrowserOperation *parent;
@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserServicesSearchDelegate> *delegates;
@property (readonly) NSString *type;
@property (readonly) NSString *domain;

- (instancetype)initWithType:(NSString *)type domain:(NSString *)domain timeout:(NSTimeInterval)timeout;

@end










@protocol NSENetServiceBrowserDelegate <NSEObjectDelegate, NSENetServiceDelegate, NSENetServiceBrowserDomainsSearchDelegate, NSENetServiceBrowserServicesSearchDelegate>

@end



@interface NSENetServiceBrowserOperation : NSEObjectOperation <NSENetServiceBrowserDelegate, NSNetServiceBrowserDelegate>

@property (weak, readonly) NSNetServiceBrowser *object;
@property (weak, readonly) NSENetServiceBrowserDomainsSearch *domainsSearch;
@property (weak, readonly) NSENetServiceBrowserServicesSearch *servicesSearch;

- (NSENetServiceBrowserDomainsSearch *)searchForDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserDomainsSearch *)searchForDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (NSENetServiceBrowserServicesSearch *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserServicesSearch *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
