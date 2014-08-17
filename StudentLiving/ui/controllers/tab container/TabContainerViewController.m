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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
    [[DataModelManager getInstance] onStartup];
}

@end
