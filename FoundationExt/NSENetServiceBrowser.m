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










@interface NSENetServiceBrowserDidService ()

@property NSNetService *service;
@property BOOL moreComing;

@end



@implementation NSENetServiceBrowserDidService

- (instancetype)initWithService:(NSNetService *)service moreComing:(BOOL)moreComing {
    self = super.init;
    
    self.service = service;
    self.moreComing = moreComing;
    
    return self;
}

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
    [self.parent.object stop];
}

@end










@interface NSENetServiceBrowserSearching ()

@property NSString *type;
@property NSString *domain;
@property NSENetServiceBrowserStopping *stopping;

@end



@implementation NSENetServiceBrowserSearching

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
    
    [self.delegates nseNetServiceBrowserSearchingDidUpdateState:self];
    if (state == NSEOperationStateDidStart) {
        [self.delegates nseNetServiceBrowserSearchingDidStart:self];
    } else if (state == NSEOperationStateDidCancel) {
        [self.delegates nseNetServiceBrowserSearchingDidCancel:self];
    } else if (state == NSEOperationStateDidFinish) {
        [self.delegates nseNetServiceBrowserSearchingDidFinish:self];
    }
}

- (void)updateProgress:(int64_t)completedUnitCount {
    [super updateProgress:completedUnitCount];
    
    [self.delegates nseNetServiceBrowserSearchingDidUpdateProgress:self];
}

#pragma mark - NSENetServiceBrowserSearchingDelegate

- (void)nseNetServiceBrowserSearchingDidStart:(NSENetServiceBrowserSearching *)searching {
    [self.parent.object searchForServicesOfType:self.type inDomain:self.domain];
}

- (void)nseNetServiceBrowserSearchingDidCancel:(NSENetServiceBrowserSearching *)searching {
    self.stopping = self.parent.stop;
    [self.stopping.delegates addObject:self];
}

#pragma mark - NSENetServiceBrowserStoppingDelegate

- (void)nseNetServiceBrowserStoppingDidFinish:(NSENetServiceBrowserStopping *)stopping {
    [self finish];
}

@end










@interface NSENetServiceBrowserOperation ()

@property (weak) NSENetServiceBrowserDidService *didFindService;
@property (weak) NSENetServiceBrowserDidService *didRemoveService;
@property (weak) NSENetServiceBrowserStopping *stopping;
@property (weak) NSENetServiceBrowserSearching *searching;

@end



@implementation NSENetServiceBrowserOperation

@dynamic delegates;
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

- (NSENetServiceBrowserSearching *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout {
    self.searching = [NSENetServiceBrowserSearching.alloc initWithType:type domain:domain timeout:timeout].nseAutorelease;
    
    [self addOperation:self.searching];
    
    return self.searching;
}

- (NSENetServiceBrowserSearching *)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain timeout:(NSTimeInterval)timeout completion:(NSEBlock)completion {
    NSENetServiceBrowserSearching *searching = [self searchForServicesOfType:type inDomain:domain timeout:timeout];
    
    searching.completion = completion;
    
    return searching;
}

#pragma mark - NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing {
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    self.didFindService = [NSENetServiceBrowserDidService.alloc initWithService:service moreComing:moreComing].nseAutorelease;
    [self.delegates nseNetServiceBrowserDidFindService:browser];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    self.didRemoveService = [NSENetServiceBrowserDidService.alloc initWithService:service moreComing:moreComing].nseAutorelease;
    [self.delegates nseNetServiceBrowserDidRemoveService:browser];
}

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)browser {
    [self.searching finish];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *, NSNumber *> *)errorDict {
    self.searching.error = [NSError errorWithDomain:errorDict[NSNetServicesErrorDomain].stringValue code:errorDict[NSNetServicesErrorCode].integerValue userInfo:nil];
    [self.searching finish];
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser {
    [self.stopping finish];
}

@end
