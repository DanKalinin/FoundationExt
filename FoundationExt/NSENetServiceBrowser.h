//
//  NSENetServiceBrowser.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSEObject.h"

@class NSENetServiceBrowser;
@class NSENetServiceBrowserOperation;

@protocol NSENetServiceBrowserDelegate;










@interface NSNetServiceBrowser (NSE)

@property (readonly) NSENetServiceBrowserOperation *nseOperation;

@end










@interface NSENetServiceBrowser : NSNetServiceBrowser

@end










@protocol NSENetServiceBrowserDelegate <NSEObjectDelegate>

@end



@interface NSENetServiceBrowserOperation : NSEObjectOperation <NSENetServiceBrowserDelegate, NSNetServiceBrowserDelegate>

@property (weak, readonly) NSNetServiceBrowser *object;

@end
