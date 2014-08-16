//
//  ProjectionsViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "ProjectionsViewController.h"

#import "UIView+FormScroll.h"

@interface ProjectionsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *housingContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *billsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *foodCostsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *petrolCostsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *miscCostsContainer;

@property (weak, nonatomic) IBOutlet UITextField *housingCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *billsTextField;
@property (weak, nonatomic) IBOutlet UITextField *foodCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *petrolCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *miscCostsTextField;

@end

@implementation ProjectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField == self.housingCostsTextField) {
        [self.view scrollToView:self.housingContainer];
    } else if(textField == self.billsTextField) {
        [self.view scrollToView:self.billsContainer];
    } else if(textField == self.foodCostsTextField) {
        [self.view scrollToView:self.foodCostsContainer];
    } else if(textField == self.petrolCostsTextField) {
        [self.view scrollToView:self.petrolCostsContainer];
    } else if(textField == self.miscCostsTextField) {
        [self.view scrollToView:self.miscCostsContainer];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self.view scrollToY:0];
    [textField resignFirstResponder];
}

- (IBAction)onUpdateProjections:(id)sender {
}

- (IBAction)onBackgroundViewTouched:(id)sender {
    [self.housingCostsTextField resignFirstResponder];
    [self.billsTextField resignFirstResponder];
    [self.foodCostsTextField resignFirstResponder];
    [self.petrolCostsTextField resignFirstResponder];
    [self.miscCostsTextField resignFirstResponder];
}


@end
