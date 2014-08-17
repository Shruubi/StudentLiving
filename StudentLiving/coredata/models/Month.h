//
//  Month.h
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdditionalExpense;

@interface Month : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSDecimalNumber * income;
@property (nonatomic, retain) NSDecimalNumber * housing;
@property (nonatomic, retain) NSDecimalNumber * bills;
@property (nonatomic, retain) NSDecimalNumber * food;
@property (nonatomic, retain) NSDecimalNumber * petrol;
@property (nonatomic, retain) NSDecimalNumber * misc;
@property (nonatomic, retain) NSSet *additionalExpenses;
@end

@interface Month (CoreDataGeneratedAccessors)

- (void)addAdditionalExpensesObject:(AdditionalExpense *)value;
- (void)removeAdditionalExpensesObject:(AdditionalExpense *)value;
- (void)addAdditionalExpenses:(NSSet *)values;
- (void)removeAdditionalExpenses:(NSSet *)values;

@end
