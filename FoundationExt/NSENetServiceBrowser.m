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

@property NSENetServiceDomains domains;

@end



@implementation NSENetServiceBrowserDomainsSearch

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.domains = domains;
    
    return self;
}

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

- (void)nseNetServiceBrowserDomainsSearchDidStart:(NSENetServiceBrowserDomainsSearch *)search {
    if (self.domains == NSENetServiceDomainsBrowsable) {
        [self.parent.object searchForBrowsableDomains];
    } else if (self.domains == NSENetServiceDomainsRegistration) {
        [self.parent.object searchForRegistrationDomains];
    }
}

- (void)nseNetServiceBrowserDomainsSearchDidCancel:(NSENetServiceBrowserDomainsSearch *)search {
    [self.parent.object stop];
}

@end










@interface NSENetServiceBrowserServicesSearch ()

@property NSString *type;
@property NSString *domain;

@end



@implementation NSENetServiceBrowserServicesSearch

@dynamic parent;
@dynamic delegates;

- (instancetype)initWithType:(NSString *)type domain:(NSString *)domain timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.type = type;
    self.domain = domain;
    
    return self;
}

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

- (void)nseNetServiceBrowserServicesSearchDidStart:(NSENetServiceBrowserServicesSearch *)search {
    [self.parent.object searchForServicesOfType:self.type inDomain:self.domain];
}

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

- (NSENetServiceBrowserDomainsSearch *)searchForDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout {
    self.domainsSearch = [NSENetServiceBrowserDomainsSearch.alloc initWithDomains:domains timeout:timeout].nseAutorelease;
    
    [self addOperation:self.domainsSearch];
    
    return self.domainsSearch;
}

- (NSENetServiceBrowserDomainsSearch *)searchForDomains:(NSENetServiceDomains)domains timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserDomainsSearch *search = [self searchForDomains:domains timeout:timeout];
    
    search.completion = completion;
    
    return search;
}

- (NSENetServiceBrowserServicesSearch *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout {
    self.servicesSearch = [NSENetServiceBrowserServicesSearch.alloc initWithType:type domain:domain timeout:timeout].nseAutorelease;
    
    [self addOperation:self.servicesSearch];
    
    return self.servicesSearch;
}

- (NSENetServiceBrowserServicesSearch *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserServicesSearch *search = [self searchForServicesOfType:type inDomain:domain timeout:timeout];
    
    search.completion = completion;
    
    return search;
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
