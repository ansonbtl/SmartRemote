//
//  PLSetupController.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLSetupController.h"
#import "PLCountriesController.h"
#import "PLUtility.h"
#import "PLCloudManager.h"

@interface PLSetupController ()

@end

@implementation PLSetupController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor darkTextColor];
    self.navigationController.navigationBar.tintColor = [PLUtility themeTitleColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[PLCloudManager instance] allCountries];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"PEEL SMART REMOTE";
}

- (void)viewWillDisappear:(BOOL)animated {
    self.title = @"";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)selectCountries:(id)sender {
    PLCountriesController *controller = [[PLCountriesController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
