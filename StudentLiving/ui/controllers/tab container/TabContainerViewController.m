//
//  TabContainerViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "TabContainerViewController.h"

#import "DataModelManager.h"

@interface TabContainerViewController ()

@end

@implementation TabContainerViewController

-(void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUpdatedProjections:)
                                                 name:@"updatedProjections"
                                               object:nil];
    
    [[DataModelManager getInstance] onStartup];
}

-(void)handleUpdatedProjections:(id)sender {
    NSLog(@"called notification listener");
    [self setSelectedIndex:0];
}

@end
