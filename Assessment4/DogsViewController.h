//
//  DogsViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner.h"

@interface DogsViewController : UIViewController

@property (nonatomic) Owner *owner;
@property NSManagedObjectContext *dogMoc;

@end
