//
//  AdditionalExpense.h
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Month;

@interface AdditionalExpense : NSManagedObject

@property (nonatomic, retain) NSString * expenseDescription;
@property (nonatomic, retain) NSDecimalNumber * expenseAmount;
@property (nonatomic, retain) Month *forMonth;

@end
