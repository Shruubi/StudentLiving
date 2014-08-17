//
//  NSNumber+NumberExtensions.m
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "NSNumber+NumberExtensions.h"

@implementation NSNumber (NumberExtensions)

+(NSNumber *)zero {
    return [NSNumber numberWithDouble:0.0f];
}

-(NSString *)getCurrencyString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return [formatter stringFromNumber:self];
}

@end
