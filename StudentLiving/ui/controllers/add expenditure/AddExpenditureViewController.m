//
//  AddExpenditureViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "AddExpenditureViewController.h"

#import "UIView+FormScroll.h"

@interface AddExpenditureViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *costsContainer;

@property (weak, nonatomic) IBOutlet UITextField *expenditureDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *expenditureCostTextField;

@end

@implementation AddExpenditureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField == self.expenditureDescriptionTextField) {
        [self.view scrollToView:self.descriptionContainer];
    } else if(textField == self.expenditureCostTextField) {
        [self.view scrollToView:self.costsContainer];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self.view scrollToY:0];
    [textField resignFirstResponder];
}

- (IBAction)onSavePressed:(id)sender {
}

- (IBAction)onBackgroundViewTouched:(id)sender {
    [self.expenditureDescriptionTextField resignFirstResponder];
    [self.expenditureCostTextField resignFirstResponder];
}

@end
