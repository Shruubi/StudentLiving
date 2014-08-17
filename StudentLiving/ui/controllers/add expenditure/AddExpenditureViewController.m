//
//  AddExpenditureViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "AddExpenditureViewController.h"

#import "DataModelManager.h"

#import "UIView+FormScroll.h"
#import "NSNumber+NumberExtensions.h"
#import "NSString+StringExtensions.h"

@interface AddExpenditureViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *costsContainer;

@property (weak, nonatomic) IBOutlet UITextField *expenditureDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *expenditureCostTextField;

@end

@implementation AddExpenditureViewController

-(void)viewWillAppear:(BOOL)animated {
    if(self.additionalExpense != nil) {
        [self updateValues];
    }
}

-(void)updateValues {
    NSString *desc = self.additionalExpense.expenseDescription;
    NSString *cost = [[NSNumber numberWithDouble:[self.additionalExpense.expenseAmount doubleValue]] getCurrencyString];
    
    [self.expenditureDescriptionTextField setText:desc];
    [self.expenditureCostTextField setText:cost];
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
    
    if(textField == self.expenditureCostTextField) {
        NSString *val = textField.text;
        textField.text = [[val asNSNumber] getCurrencyString];
    }
    
    [textField resignFirstResponder];
}

- (IBAction)onSavePressed:(id)sender {
    DataModelManager *manager = [DataModelManager getInstance];
    Month *currentMonth = [manager getLatestMonth];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *desc = self.expenditureDescriptionTextField.text;
    
    NSNumber *costNum = [formatter numberFromString:self.expenditureCostTextField.text];
    
    NSDecimalNumber *cost = [NSDecimalNumber decimalNumberWithDecimal:[costNum decimalValue]];
    
    if(self.additionalExpense == nil) {
        AdditionalExpense *expense = [manager createNewExpense:desc withCost:cost];
        [currentMonth addAdditionalExpensesObject:expense];
        [manager persist];
    } else {
        self.additionalExpense.expenseDescription = desc;
        self.additionalExpense.expenseAmount = cost;
        
        [manager persist];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBackgroundViewTouched:(id)sender {
    [self.expenditureDescriptionTextField resignFirstResponder];
    [self.expenditureCostTextField resignFirstResponder];
}

@end
