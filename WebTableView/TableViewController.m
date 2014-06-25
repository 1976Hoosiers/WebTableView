//
//  TableViewController.m
//  WebTableView
//
//  Created by Rabah Rahil on 6/24/14.
//  Copyright (c) 2014 76 Labs. All rights reserved.
//

#import "TableViewController.h"
#import "AFNetworking.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.finishedAthletesArray = [[NSArray alloc]init];
    [self makeEggRequest];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Number of Athletes %i", [self.athletesArrayFromAFNetworking count]);

    return [self.athletesArrayFromAFNetworking count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tempDictionary= [self.athletesArrayFromAFNetworking objectAtIndex:indexPath.row];
    NSLog(@"%@",[tempDictionary objectForKey:@"population"]);
    
    cell.textLabel.text = [tempDictionary objectForKey:@"name"];
    
    //Formats the output with commas...oo so pretty :)
    // Create formatter
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    //--------------------------------------------
    // Set to decimal style and output to console
    //--------------------------------------------
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedOutput = [formatter stringFromNumber:[tempDictionary objectForKey:@"population"]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", formattedOutput];
    
    return cell;
}

-(void)makeEggRequest
{
    NSURL *url = [NSURL URLWithString:@"http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=1976Hoosiers"];
    NSURLRequest * request = [NSURLRequest requestWithURL: url];
    
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest: request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.athletesArrayFromAFNetworking = [responseObject objectForKey:@"geonames"];
        
        [self.tableView reloadData];
    }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed Connection Brah...");
                                     }];
    [operation start];
    
}

@end
