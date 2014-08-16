//
//  UIView+FormScroll.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "UIView+FormScroll.h"

@implementation UIView (FormScroll)

-(void)scrollToY:(float)y {
    [UIView beginAnimations:@"registerScroll" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    self.transform = CGAffineTransformMakeTranslation(0, y);
    [UIView commitAnimations];
    
}

-(void)scrollToView:(UIView *)view {
    CGRect theFrame = view.frame;
    float y = theFrame.origin.y - 15;
    y -= (y/1.7);
    [self scrollToY:-y];
}


-(void)scrollElement:(UIView *)view toPoint:(float)y {
    CGRect theFrame = view.frame;
    float orig_y = theFrame.origin.y;
    float diff = y - orig_y;
    if (diff < 0) {
        [self scrollToY:diff];
    } else {
        [self scrollToY:0];
    }
}

@end
