//
//  PLZipSearchController.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseController.h"

@interface PLZipSearchController : PLBaseController

@property(nonatomic, strong) IBOutlet UITextField *zipTextField;
@property(nonatomic, strong) NSString *countryCode;
@property(nonatomic, assign) BOOL isSearching;

- (IBAction)startZipSearch:(id)sender;

@end
