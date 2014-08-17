//
//  DataModelManager.m
//  StudentLiving
//
//  Created by Damon Swayn on 17/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "DataModelManager.h"
#import "AppDelegate.h"
#import "Month.h"
#import "AdditionalExpense.h"

#import "NSNumber+NumberExtensions.h"

@interface DataModelManager ()

@property NSManagedObjectContext *context;

@end

@implementation DataModelManager

static DataModelManager *instance;

+(DataModelManager *)getInstance {
    if(instance == nil) {
        instance = [[DataModelManager alloc] init];
        [instance internalInitialize];
    }
    
    return instance;
}

//store an internal manager object context for use with the manager
-(void)internalInitialize {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.context = [delegate managedObjectContext];
}

//check the last entry to see if it is this month, returns no if we need a new month
-(BOOL)validateCurrentMonth {
    Month* latest = [self getLatestMonth];
    
    if(latest != nil) {
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDate* lastEntry = latest.timestamp;
        NSDateComponents *lastEntryDateComponents = [calendar
                                                     components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:lastEntry];
        
        NSDate* now = [NSDate date];
        NSDateComponents *nowDateComponents = [calendar
                                               components:(NSYearCalendarUnit | NSMonthCalendarUnit)
                                                     fromDate:now];

        
        //if lastEntry is earlier than now
        if([[lastEntryDateComponents date] compare:[nowDateComponents date]] == NSOrderedAscending) {
            return NO;
        }
        
        return YES;
    } else {
        return NO;
    }
}

-(void)onStartup {
    if(![self validateCurrentMonth]) {
        BOOL creationStatus = [self createNewMonth];
        
        if(!creationStatus) {
            NSLog(@"No current month");
        }
    }
}

-(BOOL)persist {
    NSError *error;
    
    [self.context save:&error];
    
    if(error) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    }
    
    return YES;
}

-(BOOL)createNewMonth {
    Month* newEntry = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Month" inManagedObjectContext:self.context];
    newEntry.timestamp = [NSDate date];
    
    return [self persist];
}

-(AdditionalExpense*)createNewExpense:(NSString*)desc withCost:(NSDecimalNumber*)cost {
    AdditionalExpense* newEntry = [NSEntityDescription
                       insertNewObjectForEntityForName:@"AdditionalExpense" inManagedObjectContext:self.context];
    
    newEntry.expenseDescription = desc;
    newEntry.expenseAmount = cost;
    
    BOOL persistStatus = [self persist];
    
    if(persistStatus) {
        return newEntry;
    } else {
        return nil;
    }
}

-(Month*)getLatestMonth {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[self getMonthEntityDescription]];
    
    // Results should be in descending order of timeStamp.
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSArray *results = [self.context executeFetchRequest:request error:NULL];
    
    if (results == nil || [results count] == 0) {
        return nil;
    } else {
        Month *latestEntity = [results objectAtIndex:0];
        return latestEntity;
    }
}

-(NSEntityDescription*)getMonthEntityDescription {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Month" inManagedObjectContext:self.context];
    return entityDescription;
}

-(NSEntityDescription*)getAdditionalExpenseEntityDescription {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"AdditionalExpense" inManagedObjectContext:self.context];
    return entityDescription;
}

-(NSNumber*)getMonthlyExpenditure:(Month*)currentMonth {
    double housing = [currentMonth.housing doubleValue];
    double bills = [currentMonth.bills doubleValue];
    double food = [currentMonth.food doubleValue];
    double petrol = [currentMonth.petrol doubleValue];
    double misc = [currentMonth.misc doubleValue];
    
    double result = housing + bills + food + petrol + misc;
    
    NSNumber *final = [NSNumber numberWithDouble:result];
    NSLog(@"%@", final);
    
    return final;
}

-(NSNumber*)getMonthlyIncome:(Month*)currentMonth {
    double income = [currentMonth.income doubleValue];
    NSNumber *final = [NSNumber numberWithDouble:income];
    
    NSLog(@"%@", final);
    
    return final;
}

-(NSNumber*)getMonthlyExpenses:(Month*)currentMonth {
    double result = 0;
    
    NSSet *expenses = currentMonth.additionalExpenses;
    
    for (AdditionalExpense* expense in expenses) {
        result += [expense.expenseAmount doubleValue];
    }
    
    NSNumber *final = [NSNumber numberWithDouble:result];
    
    NSLog(@"%@", final);
    
    return final;
}

-(NSNumber*)getMonthlySavings:(Month*)currentMonth {
    double expenditure = [[self getMonthlyExpenditure:currentMonth] doubleValue];
    double expenses = [[self getMonthlyExpenses:currentMonth] doubleValue];
    
    double income = [[self getMonthlyIncome:currentMonth] doubleValue];
    
    double totalExpenses = expenditure + expenses;
    
    double result = income - totalExpenses;
    
    NSNumber *final = [NSNumber numberWithDouble:result];
    
    NSLog(@"%@", final);
    
    return final;
}

@end