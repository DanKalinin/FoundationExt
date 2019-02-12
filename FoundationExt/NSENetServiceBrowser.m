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










@interface NSENetServiceBrowserOperation ()

@end



@implementation NSENetServiceBrowserOperation

@dynamic object;

- (instancetype)initWithObject:(NSNetServiceBrowser *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

@end
