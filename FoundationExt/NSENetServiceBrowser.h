//
//  NSENetServiceBrowser.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSEObject.h"
#import "NSENetService.h"

@class NSENetServiceBrowser;
@class NSENetServiceBrowserStopping;
@class NSENetServiceBrowserStarting;
@class NSENetServiceBrowserOperation;

@protocol NSENetServiceBrowserDelegate;
@protocol NSENetServiceBrowserStoppingDelegate;










@interface NSNetServiceBrowser (NSE)

@property (readonly) NSENetServiceBrowserOperation *nseOperation;

@end










@interface NSENetServiceBrowser : NSNetServiceBrowser

@end










@protocol NSENetServiceBrowserStoppingDelegate <NSEOperationDelegate>

@optional
- (void)nseNetServiceBrowserStoppingDidUpdateState:(NSENetServiceBrowserStopping *)stopping;
- (void)nseNetServiceBrowserStoppingDidStart:(NSENetServiceBrowserStopping *)stopping;
- (void)nseNetServiceBrowserStoppingDidCancel:(NSENetServiceBrowserStopping *)stopping;
- (void)nseNetServiceBrowserStoppingDidFinish:(NSENetServiceBrowserStopping *)stopping;

- (void)nseNetServiceBrowserStoppingDidUpdateProgress:(NSENetServiceBrowserStopping *)stopping;

@end



@interface NSENetServiceBrowserStopping : NSEOperation <NSENetServiceBrowserStoppingDelegate>

@property (readonly) NSENetServiceBrowserOperation *parent;
@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserStoppingDelegate> *delegates;

@end










@protocol NSENetServiceBrowserStartingDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseNetServiceBrowserStartingDidUpdateState:(NSENetServiceBrowserStarting *)starting;
- (void)nseNetServiceBrowserStartingDidStart:(NSENetServiceBrowserStarting *)starting;
- (void)nseNetServiceBrowserStartingDidCancel:(NSENetServiceBrowserStarting *)starting;
- (void)nseNetServiceBrowserStartingDidFinish:(NSENetServiceBrowserStarting *)starting;

- (void)nseNetServiceBrowserStartingDidUpdateProgress:(NSENetServiceBrowserStarting *)starting;

@end



@interface NSENetServiceBrowserStarting : NSETimeoutOperation <NSENetServiceBrowserStartingDelegate, NSENetServiceBrowserStoppingDelegate>

@property (readonly) NSENetServiceBrowserOperation *parent;
@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserStartingDelegate> *delegates;
@property (readonly) BOOL browsableDomains;
@property (readonly) BOOL registrationDomains;
@property (readonly) BOOL services;
@property (readonly) NSString *type;
@property (readonly) NSString *domain;
@property (readonly) NSENetServiceBrowserStopping *stopping;

- (instancetype)initForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout;
- (instancetype)initForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout;
- (instancetype)initForServicesOfType:(NSString *)type domain:(NSString *)domain timeout:(NSTimeInterval)timeout;

@end










@protocol NSENetServiceBrowserDelegate <NSEObjectDelegate, NSENetServiceDelegate>

@end



@interface NSENetServiceBrowserOperation : NSEObjectOperation <NSENetServiceBrowserDelegate, NSNetServiceBrowserDelegate>

@property (weak, readonly) NSNetServiceBrowser *object;
@property (weak, readonly) NSENetServiceBrowserStopping *stopping;
@property (weak, readonly) NSENetServiceBrowserStarting *starting;

- (NSENetServiceBrowserStopping *)stop;
- (NSENetServiceBrowserStopping *)stopWithCompletion:(NSEBlock)completion;

- (NSENetServiceBrowserStarting *)startForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserStarting *)startForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (NSENetServiceBrowserStarting *)startForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserStarting *)startForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

- (NSENetServiceBrowserStarting *)startForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserStarting *)startForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
