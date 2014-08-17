//
//  ExpenditureCell.h
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AdditionalExpense.h"

@interface ExpenditureCell : UITableViewCell

@property (strong, nonatomic) AdditionalExpense *model;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;

-(void)populate;

@end
