//
//  NSENetServiceBrowser.m
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSENetServiceBrowser.h"










@implementation NSNetServiceBrowser (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSENetServiceBrowserOperation.class;
}

@end










@interface NSENetServiceBrowser ()

@end



@implementation NSENetServiceBrowser

@end










@interface NSENetServiceBrowserStopping ()

@end



@implementation NSENetServiceBrowserStopping

@dynamic parent;
@dynamic delegates;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseNetServiceBrowserStoppingDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseNetServiceBrowserStoppingDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseNetServiceBrowserStoppingDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseNetServiceBrowserStoppingDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseNetServiceBrowserStoppingDidUpdateProgress:self];
}

#pragma mark - NSENetServiceBrowserStoppingDelegate

- (void)nseNetServiceBrowserStoppingDidStart:(NSENetServiceBrowserStopping *)stopping {
    [self.parent stop];
}

@end










@interface NSENetServiceBrowserOperation ()

@property (weak) NSENetServiceBrowserStopping *stopping;

@end



@implementation NSENetServiceBrowserOperation

@dynamic object;

- (instancetype)initWithObject:(NSNetServiceBrowser *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

- (NSENetServiceBrowserStopping *)stop {
    self.stopping = NSENetServiceBrowserStopping.new.nseAutorelease;
    
    [self addOperation:self.stopping];
    
    return self.stopping;
}

- (NSENetServiceBrowserStopping *)stopWithCompletion:(NSEBlock)completion {
    NSENetServiceBrowserStopping *stopping = self.stop;
    
    stopping.completion = completion;
    
    return stopping;
}

#pragma mark - NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)browser {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *, NSNumber *> *)errorDict {
    NSLog(@"dict - %@", errorDict);
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser {
    [self.stopping finish];
}

// 1 search at a time
// n - create n browsers

@end
