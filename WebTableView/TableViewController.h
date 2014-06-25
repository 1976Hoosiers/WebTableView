//
//  TableViewController.h
//  WebTableView
//
//  Created by Rabah Rahil on 6/24/14.
//  Copyright (c) 2014 76 Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) NSArray *athletesArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *finishedAthletesArray;


@end
