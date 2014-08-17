//
//  ExpenditureCell.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "ExpenditureCell.h"

#import "NSNumber+NumberExtensions.h"

@implementation ExpenditureCell

-(void)populate {
    [self.descriptionLbl setText:self.model.expenseDescription];
    [self.costLbl setText:[[NSNumber numberWithDouble:[self.model.expenseAmount doubleValue]] getCurrencyString]];
}

@end
