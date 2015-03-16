//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Jen Kelley on 3/16/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *deprocrastinatorTableView;
@property (strong, nonatomic) IBOutlet UITextField *toDoTextField;
@property NSMutableArray *taskArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskArray = [NSMutableArray arrayWithObjects:
                      @"Homework",
                      @"This Shit",
                      @"Cook Dinner",
                      @"Buy a Dog", nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell"];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
    NSString *toDoText = self.toDoTextField.text;
    [self.taskArray addObject:toDoText];

    [self.deprocrastinatorTableView reloadData]; 


}

@end
