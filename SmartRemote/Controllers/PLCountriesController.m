//
//  PLCountriesController.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLCountriesController.h"
#import "PLZipSearchController.h"
#import "PLUtility.h"
#import "PLCloudManager.h"
#import "PLCountryCell.h"

@interface PLCountriesController () {
    BOOL isLoading;
    
    NSOperationQueue *imageQueue;
}

@property(nonatomic, strong) NSArray *countries;

@end

@implementation PLCountriesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"PLCountryCell" bundle:nil] forCellReuseIdentifier:@"country_cell"];
    
    imageQueue = [[NSOperationQueue alloc] init];
    
    [self loadCountries];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"SELECT COUNTRY OR REGION";
}


- (void)loadCountries {
    NSMutableArray *items = [[[PLCloudManager instance] allCountries] mutableCopy];
    
    if (!items) {
        isLoading = YES;
    }
    else {
        NSDictionary *usDict = nil;
        for (NSDictionary *dict in items) {
            if ([dict[@"countryCode"] isEqualToString:@"US"]) {
                usDict = dict;
            }
        }
        if (usDict) [items removeObject:usDict];
        [items insertObject:usDict atIndex:0];
    }
    self.countries = items;
    
    [self.tableView reloadData];
}

- (void)goToZipSearch {
    PLZipSearchController *controller = [[PLZipSearchController alloc] initWithNibName:@"PLZipSearchController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(1, self.countries.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"country_cell" forIndexPath:indexPath];
    
    if (self.countries.count > 0) {
        NSDictionary *dict = self.countries[indexPath.row];
        
        cell.countryLabel.text = dict[@"countryName"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSString *code = [dict[@"countryCode"] lowercaseString];
        NSString *filename = [NSString stringWithFormat:@"flag_%@", code];
        
        [imageQueue addOperationWithBlock:^{
            UIImage *flagImage = [[UIImage alloc] initWithBundleFile:filename type:@"png"];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.flagImage.image = flagImage;
            });
        }];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self goToZipSearch];
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
