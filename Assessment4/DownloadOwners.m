//
//  Owners.m
//  Assessment4
//
//  Created by Justin Haar on 4/3/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DownloadOwners.h"

@implementation DownloadOwners

+(void)downloadOwnersWithCompletion:(void (^)(NSArray *))complete
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *readerArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        complete(readerArray);
    }];
}

@end
