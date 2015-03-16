//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Jen Kelley on 3/16/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *deprocrastinatorTableView;
@property (strong, nonatomic) IBOutlet UITextField *toDoTextField;
@property NSMutableArray *taskArray;
@property NSMutableArray *colorsArray;
@property NSIndexPath *deletedPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskArray = [NSMutableArray arrayWithObjects:
                      @"Homework",
                      @"This Shit",
                      @"Cook Dinner",
                      @"Buy a Dog", nil];
    self.colorsArray = [NSMutableArray arrayWithObjects:
                        [UIColor blackColor],
                        [UIColor blackColor],
                        [UIColor blackColor],
                        [UIColor blackColor],
                        nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell"];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.colorsArray objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
    NSString *toDoText = self.toDoTextField.text;
    [self.taskArray addObject:toDoText];
    [self.colorsArray addObject:[UIColor blackColor]];

    [self.deprocrastinatorTableView reloadData];
    self.toDoTextField.text = @"";
    [self.view resignFirstResponder];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Edit"]) {
        sender.title = @"Done";
        [self.deprocrastinatorTableView setEditing:YES animated:YES];
    } else {
        sender.title = @"Edit";
        [self.deprocrastinatorTableView setEditing:NO animated:YES];
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.deletedPath = indexPath;
        [self alertView];
    }
}

-(void)alertView {
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"ALERT!"
                                                   message:@"ARE YOU SUREEEEE"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.taskArray removeObjectAtIndex:self.deletedPath.row];
        [self.colorsArray removeObjectAtIndex:self.deletedPath.row];
        [self.deprocrastinatorTableView reloadData];
        self.deletedPath = nil;
    }

}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    CGPoint swipeLocation = [sender locationInView:self.deprocrastinatorTableView];
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSIndexPath *indexPath = [self.deprocrastinatorTableView indexPathForRowAtPoint:swipeLocation];
        UITableViewCell *cell = [self.deprocrastinatorTableView cellForRowAtIndexPath:indexPath];

        if([cell.textLabel.textColor isEqual:[UIColor redColor]]) {
            cell.textLabel.textColor = [UIColor yellowColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor yellowColor]]) {
            cell.textLabel.textColor = [UIColor greenColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor blackColor]]) {
            cell.textLabel.textColor = [UIColor redColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor greenColor]]) {
            cell.textLabel.textColor = [UIColor blackColor];
        }
        [self.colorsArray replaceObjectAtIndex:indexPath.row withObject:cell.textLabel.textColor];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    UITableViewCell *tempcell = [tableView cellForRowAtIndexPath:sourceIndexPath];
    [self.taskArray removeObjectAtIndex:sourceIndexPath.row];
    [self.taskArray insertObject:tempcell.textLabel.text atIndex:destinationIndexPath.row];

    [self.colorsArray removeObjectAtIndex:sourceIndexPath.row];
    [self.colorsArray insertObject:tempcell.textLabel.textColor atIndex:destinationIndexPath.row];

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}








@end
