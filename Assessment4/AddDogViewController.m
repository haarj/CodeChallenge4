//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

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

    self.nameTextField.delegate = self;
    self.breedTextField.delegate = self;
    self.colorTextField.delegate = self;

    self.title = @"Add Dog";
    self.nameTextField.placeholder = @"Enter Name";
    self.breedTextField.placeholder = @"Enter Breed";
    self.colorTextField.placeholder = @"Enter Color";
}

-(void)viewWillAppear:(BOOL)animated
{
    self.nameTextField.text = self.dog.name;
    self.breedTextField.text = self.dog.breed;
    self.colorTextField.text = self.dog.color;
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


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(![textField isEqual:@""])
    {
        if (textField == self.nameTextField) {
            self.dog = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Dog class]) inManagedObjectContext:self.owner.managedObjectContext];
            self.dog.name = textField.text;
            [self.breedTextField becomeFirstResponder];
        }else if (textField == self.breedTextField)
        {
            self.dog.breed = textField.text;
            [self.colorTextField becomeFirstResponder];
        }else if (textField == self.colorTextField)
        {
            self.dog.color = textField.text;
        }

        [self.owner addDogObject:self.dog];
        [self.owner.managedObjectContext save:nil];
    }
    else
    {
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }
}


- (IBAction)onPressedUpdateDog:(UIButton *)sender
{

//    self.nameTextField.text = self.dog.name;
//    self.breedTextField.text = self.dog.breed;
//    self.colorTextField.text = self.dog.color;
//
//        if (![self.nameTextField isEqual:@""]) {
//            self.dog = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Dog class]) inManagedObjectContext:self.owner.managedObjectContext];
//            self.dog.name = self.nameTextField.text;
//            [self.breedTextField becomeFirstResponder];
//        }else if (![self.breedTextField isEqual:@""])
//        {
//            self.dog.breed = self.breedTextField.text;
//            [self.colorTextField becomeFirstResponder];
//        }else if (![self.colorTextField isEqual:@""])
//        {
//            self.dog.color = self.colorTextField.text;
//        }
//
//            [self.owner addDogObject:self.dog];
//            [self.owner.managedObjectContext save:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
