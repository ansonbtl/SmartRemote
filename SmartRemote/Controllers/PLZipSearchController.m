//
//  PLZipSearchController.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLZipSearchController.h"
#import "PLProvidersController.h"
#import "PLCloudManager.h"
#import "PLLoadingView.h"

@interface PLZipSearchController ()<UITextFieldDelegate> {
    PLLoadingView *loadingIndicator;
}

@end

@implementation PLZipSearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.zipTextField becomeFirstResponder];
    self.zipTextField.delegate = self;
    
    self.title = @"FIND SERVICE PROVIDER";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.title = @"";
    
    [loadingIndicator removeFromSuperview];
}

- (IBAction)startZipSearch:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isSearching) return;
        
        self.isSearching = YES;
        
        [self zipSearch:self.zipTextField.text];
    });
}

- (void)zipSearch:(NSString *)zipCode {    
    if (![self isValidZipCode:zipCode]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Zip Code"
                                                            message:@"Please check your zip code and try again."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        [self.zipTextField becomeFirstResponder];
        
        return;
    }
    
    if (loadingIndicator) {
        [loadingIndicator removeFromSuperview];
        loadingIndicator = nil;
    }
    
    loadingIndicator = [[PLLoadingView alloc] initWithFrame:self.view.bounds];
    [loadingIndicator appear];
    [self.view addSubview:loadingIndicator];
    
    [self.zipTextField resignFirstResponder];
    
    [[PLCloudManager instance] lineUpsWithCountry:@"US" withZip:zipCode completion:^(int code, NSArray *lineUps) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isSearching = NO;
            
            [loadingIndicator removeFromSuperview];
            loadingIndicator = nil;
            
            if (lineUps.count > 0) {
                PLProvidersController *controller = [[PLProvidersController alloc] initWithLineUps:lineUps];
                [self.navigationController pushViewController:controller animated:YES];
            }
        });
    }];
}

- (BOOL)isValidZipCode:(NSString *)zip {
    if (zip.length != 5) return NO;
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([self isValidZipCode:newContent]) {
        [self performSelector:@selector(startZipSearch:) withObject:nil afterDelay:.25];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
