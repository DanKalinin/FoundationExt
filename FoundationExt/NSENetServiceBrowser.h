//
//  NSENetServiceBrowser.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSENetService.h"

@class NSENetServiceBrowser;
@class NSENetServiceBrowserDidService;
@class NSENetServiceBrowserStopping;
@class NSENetServiceBrowserSearching;
@class NSENetServiceBrowserOperation;

@protocol NSENetServiceBrowserDelegate;
@protocol NSENetServiceBrowserStoppingDelegate;
@protocol NSENetServiceBrowserSearchingDelegate;










@interface NSNetServiceBrowser (NSE)

@property (readonly) NSENetServiceBrowserOperation *nseOperation;

@end










@interface NSENetServiceBrowser : NSNetServiceBrowser

@end










@interface NSENetServiceBrowserDidService : NSEObject

@property (readonly) NSNetService *service;
@property (readonly) BOOL moreComing;

- (instancetype)initWithService:(NSNetService *)service moreComing:(BOOL)moreComing;

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










@protocol NSENetServiceBrowserSearchingDelegate <NSETimeoutOperationDelegate>

@optional
- (void)nseNetServiceBrowserSearchingDidUpdateState:(NSENetServiceBrowserSearching *)searching;
- (void)nseNetServiceBrowserSearchingDidStart:(NSENetServiceBrowserSearching *)searching;
- (void)nseNetServiceBrowserSearchingDidCancel:(NSENetServiceBrowserSearching *)searching;
- (void)nseNetServiceBrowserSearchingDidFinish:(NSENetServiceBrowserSearching *)searching;

- (void)nseNetServiceBrowserSearchingDidUpdateProgress:(NSENetServiceBrowserSearching *)searching;

@end



@interface NSENetServiceBrowserSearching : NSETimeoutOperation <NSENetServiceBrowserSearchingDelegate, NSENetServiceBrowserStoppingDelegate>

@property (readonly) NSENetServiceBrowserOperation *parent;
@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserSearchingDelegate> *delegates;
@property (readonly) NSString *type;
@property (readonly) NSString *domain;
@property (readonly) NSENetServiceBrowserStopping *stopping;

- (instancetype)initWithType:(NSString *)type domain:(NSString *)domain timeout:(NSTimeInterval)timeout;

@end










@protocol NSENetServiceBrowserDelegate <NSEObjectDelegate, NSENetServiceDelegate, NSENetServiceBrowserStoppingDelegate, NSENetServiceBrowserSearchingDelegate>

@optional
- (void)nseNetServiceBrowserDidFindService:(NSNetServiceBrowser *)browser;
- (void)nseNetServiceBrowserDidRemoveService:(NSNetServiceBrowser *)browser;

@end



@interface NSENetServiceBrowserOperation : NSEObjectOperation <NSENetServiceBrowserDelegate, NSNetServiceBrowserDelegate>

@property (readonly) NSMutableOrderedSet<NSENetServiceBrowserDelegate> *delegates;

@property (weak, readonly) NSNetServiceBrowser *object;
@property (weak, readonly) NSENetServiceBrowserDidService *didFindService;
@property (weak, readonly) NSENetServiceBrowserDidService *didRemoveService;
@property (weak, readonly) NSENetServiceBrowserStopping *stopping;
@property (weak, readonly) NSENetServiceBrowserSearching *searching;

- (NSENetServiceBrowserStopping *)stop;
- (NSENetServiceBrowserStopping *)stopWithCompletion:(NSEBlock)completion;

- (NSENetServiceBrowserSearching *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout;
- (NSENetServiceBrowserSearching *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion;

@end
