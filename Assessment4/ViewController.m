//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Owner.h"
#import "DownloadOwners.h"
#import "DogsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *owners;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    self.owners = [NSArray new];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = [appDelegate managedObjectContext];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![userDefaults objectForKey:@"owners"])
    {
        [DownloadOwners downloadOwnersWithCompletion:^(NSArray *ownersArray)
        {
            NSMutableArray *tempArray = [NSMutableArray new];
            for (NSString *name in ownersArray)
            {
                Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Owner class]) inManagedObjectContext:self.moc];
                owner.name = name;
                [tempArray addObject:owner];
            }
            self.owners = tempArray.copy;
            [self.moc save:nil];
            [userDefaults setObject:@YES forKey:@"owners"];
            [userDefaults synchronize];
            [self.tableView reloadData];
        }];
    }else
    {
        [self loadOwners];
    }
}


-(void)loadOwners
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Owner class])];
    self.owners = [self.moc executeFetchRequest:request error:nil];
    NSData *theData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myColor"];
    UIColor *theColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:theData];
    self.navigationController.navigationBar.tintColor = theColor;
    [self.tableView reloadData];
    [self.navigationController reloadInputViews];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *dogVC = segue.destinationViewController;
    dogVC.owner = self.owners[[[self.tableView indexPathForSelectedRow]row]];
    dogVC.dogMoc = self.moc;

}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //COMPLETED
    return self.owners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Owner *owner = [self.owners objectAtIndex:indexPath.row];
    cell.textLabel.text = owner.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor purpleColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.moc save:nil];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blueColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.moc save:nil];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor orangeColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.moc save:nil];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor greenColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.moc save:nil];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
