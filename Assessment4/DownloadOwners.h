//
//  Owners.h
//  Assessment4
//
//  Created by Justin Haar on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadOwners : NSObject

+(void)downloadOwnersWithCompletion:(void(^)(NSArray *))complete;

@end
