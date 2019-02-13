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










@interface NSENetServiceBrowserStarting ()

@property BOOL browsableDomains;
@property BOOL registrationDomains;
@property BOOL services;
@property NSString *type;
@property NSString *domain;
@property NSENetServiceBrowserStopping *stopping;

@end



@implementation NSENetServiceBrowserStarting

@dynamic parent;
@dynamic delegates;

- (instancetype)initForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.browsableDomains = YES;
    
    return self;
}

- (instancetype)initForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.registrationDomains = YES;
    
    return self;
}

- (instancetype)initForServicesOfType:(NSString *)type domain:(NSString *)domain timeout:(NSTimeInterval)timeout {
    self = [super initWithTimeout:timeout];
    
    self.type = type;
    self.domain = domain;
    
    self.services = YES;
    
    return self;
}

- (void)updateState:(NSEOperationState)state {
    [super updateState:state];
    
    [self.delegates nseNetServiceBrowserStartingDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseNetServiceBrowserStartingDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseNetServiceBrowserStartingDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseNetServiceBrowserStartingDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseNetServiceBrowserStartingDidUpdateProgress:self];
}

#pragma mark - NSENetServiceBrowserStartingDelegate

- (void)nseNetServiceBrowserStartingDidStart:(NSENetServiceBrowserStarting *)starting {
    if (self.browsableDomains) {
        [self.parent.object searchForBrowsableDomains];
    } else if (self.registrationDomains) {
        [self.parent.object searchForRegistrationDomains];
    } else if (self.services) {
        [self.parent.object searchForServicesOfType:self.type inDomain:self.domain];
    }
}

- (void)nseNetServiceBrowserStartingDidCancel:(NSENetServiceBrowserStarting *)starting {
    self.stopping = self.parent.stop;
    [self.stopping.delegates addObject:self];
}

#pragma mark - NSENetServiceBrowserStoppingDelegate

- (void)nseNetServiceBrowserStoppingDidFinish:(NSENetServiceBrowserStopping *)stopping {
    [self finish];
}

@end










@interface NSENetServiceBrowserOperation ()

@property (weak) NSENetServiceBrowserStopping *stopping;
@property (weak) NSENetServiceBrowserStarting *starting;

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

- (NSENetServiceBrowserStarting *)startForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout {
    self.starting = [NSENetServiceBrowserStarting.alloc initForBrowsableDomainsWithTimeout:timeout].nseAutorelease;
    
    [self addOperation:self.starting];
    
    return self.starting;
}

- (NSENetServiceBrowserStarting *)startForBrowsableDomainsWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserStarting *starting = [self startForBrowsableDomainsWithTimeout:timeout];
    
    starting.completion = completion;
    
    return starting;
}

- (NSENetServiceBrowserStarting *)startForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout {
    self.starting = [NSENetServiceBrowserStarting.alloc initForRegistrationDomainsWithTimeout:timeout].nseAutorelease;
    
    [self addOperation:self.starting];
    
    return self.starting;
}

- (NSENetServiceBrowserStarting *)startForRegistrationDomainsWithTimeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserStarting *starting = [self startForRegistrationDomainsWithTimeout:timeout];
    
    starting.completion = completion;
    
    return starting;
}

- (NSENetServiceBrowserStarting *)startForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout {
    self.starting = [NSENetServiceBrowserStarting.alloc initForServicesOfType:type domain:domain timeout:timeout].nseAutorelease;
    
    [self addOperation:self.starting];
    
    return self.starting;
}

- (NSENetServiceBrowserStarting *)startForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserStarting *starting = [self startForServicesOfType:type inDomain:domain timeout:timeout];
    
    starting.completion = completion;
    
    return starting;
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
    [self.starting finish];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *, NSNumber *> *)errorDict {
    NSLog(@"dict - %@", errorDict);
    
    self.starting.error = nil;
    [self.starting finish];
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser {
    [self.stopping finish];
}

// 1 search at a time
// n - create n browsers

@end
