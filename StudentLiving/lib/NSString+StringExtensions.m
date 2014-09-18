//
//  NSString+StringExtensions.m
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "NSString+StringExtensions.h"

@implementation NSString (StringExtensions)

-(NSNumber*)asNSNumber {
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* result = [f numberFromString:self];
    
    return result;
}

-(BOOL)isEmpty {
    if([self isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

@end
