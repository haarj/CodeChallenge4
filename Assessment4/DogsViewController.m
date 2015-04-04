//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"


@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSMutableArray *dogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
}


-(void)viewWillAppear:(BOOL)animated
{
    [self loadDogs];
    [self.dogsTableView reloadData];
}


-(void)loadDogs
{
    self.dogs = [[self.owner.dog allObjects]mutableCopy];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    cell.textLabel.text = [self.dogs[indexPath.row] name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[self.dogs[indexPath.row] breed], [self.dogs[indexPath.row]color]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *addDogVC = segue.destinationViewController;
        addDogVC.owner = self.owner;
        addDogVC.addDogMoc = self.dogMoc;
    }
    else if ([segue.identifier isEqualToString:@"dogProfile"])
    {
        AddDogViewController *dogProfile = segue.destinationViewController;
        dogProfile.dog = self.dogs[[[self.dogsTableView indexPathForSelectedRow]row]];
        dogProfile.addDogMoc = self.dogMoc;
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *deletedObject = self.dogs[indexPath.row];
        [self.dogMoc deleteObject:deletedObject];
        [self.dogs removeObjectAtIndex:indexPath.row];
        [self.dogsTableView reloadData];
        [self.dogMoc save:nil];
    }
}


@end
