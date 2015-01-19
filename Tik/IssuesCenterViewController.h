//
//  IssuesCenterViewController.h
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerViewController.h"
#import "IssuesCenter.h"

@interface IssuesCenterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) TimerViewController *timer;
@property (strong, nonatomic) UIBarButtonItem *searchButton;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSArray *issueData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *issueButton;

@end
