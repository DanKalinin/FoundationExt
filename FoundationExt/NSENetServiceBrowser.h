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










@protocol NSENetServiceBrowserDelegate <NSEObjectDelegate, NSENetServiceDelegate>

@end



@interface NSENetServiceBrowserOperation : NSEObjectOperation <NSENetServiceBrowserDelegate, NSNetServiceBrowserDelegate>

@property (weak, readonly) NSNetServiceBrowser *object;
@property (weak, readonly) NSENetServiceBrowserStopping *stopping;

- (NSENetServiceBrowserStopping *)stop;
- (NSENetServiceBrowserStopping *)stopWithCompletion:(NSEBlock)completion;

@end
