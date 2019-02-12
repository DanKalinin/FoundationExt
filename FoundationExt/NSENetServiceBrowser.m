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










@interface NSENetServiceBrowserDomainsSearch ()

@end



@implementation NSENetServiceBrowserDomainsSearch

@dynamic parent;
@dynamic delegates;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseNetServiceBrowserDomainsSearchDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseNetServiceBrowserDomainsSearchDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseNetServiceBrowserDomainsSearchDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseNetServiceBrowserDomainsSearchDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseNetServiceBrowserDomainsSearchDidUpdateProgress:self];
}

#pragma mark - NSENetServiceBrowserDomainsSearchDelegate

- (void)nseNetServiceBrowserDomainsSearchDidCancel:(NSENetServiceBrowserDomainsSearch *)search {
    [self.parent.object stop];
}

@end










@interface NSENetServiceBrowserServicesSearch ()

@end



@implementation NSENetServiceBrowserServicesSearch

@dynamic parent;
@dynamic delegates;

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseNetServiceBrowserServicesSearchDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseNetServiceBrowserServicesSearchDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseNetServiceBrowserServicesSearchDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseNetServiceBrowserServicesSearchDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseNetServiceBrowserServicesSearchDidUpdateProgress:self];
}

#pragma mark - NSENetServiceBrowserServicesSearchDelegate

- (void)nseNetServiceBrowserServicesSearchDidCancel:(NSENetServiceBrowserServicesSearch *)search {
    [self.parent.object stop];
}

@end










@interface NSENetServiceBrowserOperation ()

@property (weak) NSENetServiceBrowserDomainsSearch *domainsSearch;
@property (weak) NSENetServiceBrowserServicesSearch *servicesSearch;

@end



@implementation NSENetServiceBrowserOperation

@dynamic object;

- (instancetype)initWithObject:(NSNetServiceBrowser *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
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
    [self.domainsSearch finish];
    [self.servicesSearch finish];
}

// 1 search at a time
// n - create n browsers

@end
