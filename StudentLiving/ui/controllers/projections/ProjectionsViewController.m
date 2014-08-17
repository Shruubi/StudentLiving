//
//  ProjectionsViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "ProjectionsViewController.h"

#import "UIView+FormScroll.h"

#import "NSNumber+NumberExtensions.h"
#import "NSString+StringExtensions.h"

#import "DataModelManager.h"

@interface ProjectionsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *monthlyIncomeContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *housingContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *billsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *foodCostsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *petrolCostsContainer;
@property (weak, nonatomic) IBOutlet UITableViewCell *miscCostsContainer;

@property (weak, nonatomic) IBOutlet UITextField *monthlyIncomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *housingCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *billsTextField;
@property (weak, nonatomic) IBOutlet UITextField *foodCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *petrolCostsTextField;
@property (weak, nonatomic) IBOutlet UITextField *miscCostsTextField;

@property (strong, nonatomic) Month *currentMonth;

@end

@implementation ProjectionsViewController

-(void)viewWillAppear:(BOOL)animated {
    DataModelManager *manager = [DataModelManager getInstance];
    self.currentMonth = [manager getLatestMonth];
    [self updateValues:manager];
}

-(void)updateValues:(DataModelManager*)manager {
    double income = [self.currentMonth.income doubleValue];
    double housing = [self.currentMonth.housing doubleValue];
    double bills = [self.currentMonth.bills doubleValue];
    double food = [self.currentMonth.food doubleValue];
    double petrol = [self.currentMonth.petrol doubleValue];
    double misc = [self.currentMonth.misc doubleValue];
    
    [self.monthlyIncomeTextField setText:[[NSNumber numberWithDouble:income] getCurrencyString]];
    [self.housingCostsTextField setText:[[NSNumber numberWithDouble:housing] getCurrencyString]];
    [self.billsTextField setText:[[NSNumber numberWithDouble:bills] getCurrencyString]];
    [self.foodCostsTextField setText:[[NSNumber numberWithDouble:food] getCurrencyString]];
    [self.petrolCostsTextField setText:[[NSNumber numberWithDouble:petrol] getCurrencyString]];
    [self.miscCostsTextField setText:[[NSNumber numberWithDouble:misc] getCurrencyString]];
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
    } else if(textField == self.monthlyIncomeTextField) {
        [self.view scrollToView:self.monthlyIncomeContainer];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self.view scrollToY:0];
    
    NSString *val = textField.text;
    textField.text = [[val asNSNumber] getCurrencyString];
    
    [textField resignFirstResponder];
}

- (IBAction)onUpdateProjections:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *income = [formatter numberFromString:self.monthlyIncomeTextField.text];
    NSNumber *housing = [formatter numberFromString:self.housingCostsTextField.text];
    NSNumber *bills = [formatter numberFromString:self.billsTextField.text];
    NSNumber *food = [formatter numberFromString:self.foodCostsTextField.text];
    NSNumber *petrol = [formatter numberFromString:self.petrolCostsTextField.text];
    NSNumber *misc = [formatter numberFromString:self.miscCostsTextField.text];
    
    self.currentMonth.income = [NSDecimalNumber decimalNumberWithDecimal:[income decimalValue]];
    self.currentMonth.housing = [NSDecimalNumber decimalNumberWithDecimal:[housing decimalValue]];
    self.currentMonth.bills = [NSDecimalNumber decimalNumberWithDecimal:[bills decimalValue]];
    self.currentMonth.food = [NSDecimalNumber decimalNumberWithDecimal:[food decimalValue]];
    self.currentMonth.petrol = [NSDecimalNumber decimalNumberWithDecimal:[petrol decimalValue]];
    self.currentMonth.misc = [NSDecimalNumber decimalNumberWithDecimal:[misc decimalValue]];
    
    [[DataModelManager getInstance] persist];
}

- (IBAction)onBackgroundViewTouched:(id)sender {
    [self.housingCostsTextField resignFirstResponder];
    [self.billsTextField resignFirstResponder];
    [self.foodCostsTextField resignFirstResponder];
    [self.petrolCostsTextField resignFirstResponder];
    [self.miscCostsTextField resignFirstResponder];
    [self.monthlyIncomeTextField resignFirstResponder];
}


@end
