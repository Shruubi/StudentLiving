//
//  ExpendituresViewController.m
//  StudentLiving
//
//  Created by Damon Swayn on 16/08/2014.
//  Copyright (c) 2014 Swayn Consulting. All rights reserved.
//

#import "ExpendituresViewController.h"

#import "DataModelManager.h"
#import "ExpenditureCell.h"
#import "AdditionalExpense.h"

#import "AddExpenditureViewController.h"

#define CELL_ID @"expenditureCell"

#define ADD_SEGUE_ID @"addExpenditureSegue"
#define EDIT_SEGUE_ID @"editExpenditureSegue"

@interface ExpendituresViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ExpendituresViewController

-(void)viewDidAppear:(BOOL)animated {
    self.dataSource = [[NSMutableArray alloc] init];
    
    [self loadDataSource];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:EDIT_SEGUE_ID]) {
        AddExpenditureViewController *controller = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        AdditionalExpense *item = [self.dataSource objectAtIndex:indexPath.row];
        
        controller.additionalExpense = item;
    }
}

-(void)loadDataSource {
    DataModelManager *manager = [DataModelManager getInstance];
    Month *currentMonth = [manager getLatestMonth];
    self.dataSource = [[currentMonth.additionalExpenses allObjects] mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpenditureCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    
    if(cell == nil) {
        cell = [[ExpenditureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    AdditionalExpense *item = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = item;
    [cell populate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:EDIT_SEGUE_ID sender:self];
}

@end
