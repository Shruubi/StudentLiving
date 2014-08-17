//
//  OverviewViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "OverviewViewController.h"

#import "DataModelManager.h"
#import "NSNumber+NumberExtensions.h"

@interface OverviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *monthlyExpenditureLbl;
@property (weak, nonatomic) IBOutlet UILabel *monthlyIncomeLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalExpensesLbl;
@property (weak, nonatomic) IBOutlet UILabel *savingsLbl;

@end

@implementation OverviewViewController

-(void)viewWillAppear:(BOOL)animated {
    DataModelManager *manager = [DataModelManager getInstance];
    [self updateValues:manager];
    
}

-(void)updateValues:(DataModelManager*)manager {
    Month *currentMonth = [manager getLatestMonth];
    
    NSNumber *monthlyExpenditure = [manager getMonthlyExpenditure:currentMonth];
    NSNumber *monthlyExpenses = [manager getMonthlyExpenses:currentMonth];
    NSNumber *monthlyIncome = [manager getMonthlyIncome:currentMonth];
    NSNumber *monthlySavings = [manager getMonthlySavings:currentMonth];
    
    [self.monthlyExpenditureLbl setText:[monthlyExpenditure getCurrencyString]];
    [self.monthlyIncomeLbl setText:[monthlyIncome getCurrencyString]];
    [self.additionalExpensesLbl setText:[monthlyExpenses getCurrencyString]];
    [self.savingsLbl setText:[monthlySavings getCurrencyString]];
}

@end
