//
//  NSENetService.m
//  FoundationExt
//
//  Created by Dan Kalinin on 2/12/19.
//

#import "NSENetService.h"










@implementation NSNetService (NSE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return NSENetServiceOperation.class;
}

@end










@interface NSENetService ()

@end



@implementation NSENetService

@end










@interface NSENetServiceOperation ()

@end



@implementation NSENetServiceOperation

@dynamic object;

- (instancetype)initWithObject:(NSNetService *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

@end
