//
//  NSESequence.m
//  FoundationExt
//
//  Created by Dan Kalinin on 2/9/19.
//

#import "NSESequence.h"



@interface NSESequence ()

@property int64_t start;
@property int64_t stop;
@property int64_t step;
@property int64_t value;

@end



@implementation NSESequence

- (instancetype)initWithStart:(int64_t)start stop:(int64_t)stop step:(int64_t)step {
    self = super.init;
    
    self.start = start;
    self.stop = stop;
    self.step = step;
    
    self.value = self.start;
    
    return self;
}

- (void)next {
    if (self.stop > self.start) {
        self.value += self.step;
        if (self.value > self.stop) {
            self.value = self.start;
        }
    } else {
        self.value -= self.step;
        if (self.value < self.stop) {
            self.value = self.start;
        }
    }
}

@end
