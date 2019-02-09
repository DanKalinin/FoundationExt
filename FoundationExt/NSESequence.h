//
//  NSESequence.h
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSEOperation.h"



@interface NSESequence : NSEOperation

@property (readonly) int64_t start;
@property (readonly) int64_t stop;
@property (readonly) int64_t step;
@property (readonly) int64_t value;

- (instancetype)initWithStart:(int64_t)start stop:(int64_t)stop step:(int64_t)step;
- (void)next;

@end
