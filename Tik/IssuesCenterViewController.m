//
//  IssuesCenterViewController.m
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import "IssuesCenterViewController.h"
#import "IssuesCenter.h"
#import "IssueFormViewController.h"

@interface IssuesCenterViewController ()

@end

NSMutableArray *openIssues;

@implementation IssuesCenterViewController
@synthesize timer = _timer;
@synthesize issueData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = _searchButton;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"IssuesCenter" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.issueData = [self.context executeFetchRequest:fetchRequest error:&error];
    openIssues = [[NSMutableArray alloc] init];
    for (IssuesCenter *info in issueData) {
        if (info.resolution == nil && info.issue != nil) {
            [openIssues addObject:info];
        }
    }
    
    self.title = @"Issues Center";
    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)makeNewIssue:(id)sender {
    IssueFormViewController *issueForm = [[IssueFormViewController alloc] init];
    issueForm.modalPresentationStyle = UIModalPresentationFormSheet;
    issueForm.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:issueForm animated:YES completion:nil];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (openIssues != nil) {
        return [openIssues count];
    } else return 0;
}
- (NSInteger)numberOfSections {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    // Set up the cell...
    IssuesCenter *info = [openIssues objectAtIndex:indexPath.row];
    cell.textLabel.text = info.issue;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
