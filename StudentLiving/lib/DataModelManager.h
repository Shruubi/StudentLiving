//
//  DataModelManager.h
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Month.h"

@interface DataModelManager : NSObject

+(DataModelManager *)getInstance;

-(void)onStartup;
-(Month*)getLatestMonth;

-(AdditionalExpense*)createNewExpense:(NSString*)desc withCost:(NSDecimalNumber*)cost;

-(BOOL)persist;

-(NSNumber*)getMonthlyExpenditure:(Month*)currentMonth;
-(NSNumber*)getMonthlyIncome:(Month*)currentMonth;
-(NSNumber*)getMonthlyExpenses:(Month*)currentMonth;
-(NSNumber*)getMonthlySavings:(Month*)currentMonth;

@end
