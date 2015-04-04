//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "AppDelegate.h"

@interface AddDogViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;


@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.addDogMoc = [appDelegate managedObjectContext];

    self.nameTextField.delegate = self;
    self.breedTextField.delegate = self;
    self.colorTextField.delegate = self;

    if (self.dog == nil)
    {
        self.title = @"Add Dog";
        self.nameTextField.placeholder = @"Enter Name";
        self.breedTextField.placeholder = @"Enter Breed";
        self.colorTextField.placeholder = @"Enter Color";
    }else
    {
        self.title = @"Edit Dog";
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (self.dog == nil)
    {
        Dog *newDog = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Dog class]) inManagedObjectContext:self.addDogMoc];

        newDog.name = self.nameTextField.text;
        newDog.breed = self.breedTextField.text;
        newDog.color = self.colorTextField.text;
        [self.owner addDogObject:newDog];
        [self.addDogMoc save:nil];
    }else
    {
        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;
        [self.addDogMoc save:nil];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
