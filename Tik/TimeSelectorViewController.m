//
//  TimeSelectorViewController.m
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import "TimeSelectorViewController.h"
#import "TimerViewController.h"

@interface TimeSelectorViewController ()
    @property (nonatomic) TimeSelectorStage *selectorState;
@end

NSArray *currentData;
NSArray *workTime;
NSArray *breakTime;
NSArray *repeatCounts;

int workMinutes;
int breakMinutes;
int repeatCount;

int rowRecord;


@implementation TimeSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    workTime = @[@"1 minutes", @"10 minutes", @"20 minutes", @"30 minutes", @"40 minutes", @"50 minutes", @"60 minutes"];
    breakTime = @[@"1 minutes", @"5 minutes", @"10 minutes", @"15 minutes", @"20 minutes"];
    repeatCounts = @[@"1 time", @"2 times", @"3 times", @"4 times", @"5 times"];
    
    rowRecord = 0;
    
    _selectorState = WORKTIME;
    currentData = workTime;
    
    [self pickerView:self.pickerView didSelectRow:rowRecord inComponent:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextSelection:(id)sender {

    switch ((int)_selectorState) {
        case WORKTIME:
            _selectorState = BREAKTIME;
            currentData = breakTime;
            [self.pickerView reloadAllComponents];
            [self pickerView:self.pickerView didSelectRow:rowRecord inComponent:0];
            break;
            
        case BREAKTIME:
            _selectorState = REPEATCOUNT;
            currentData = repeatCounts;
            [self.pickerView reloadAllComponents];
            [self pickerView:self.pickerView didSelectRow:rowRecord inComponent:0];
            break;
            
        case REPEATCOUNT:
            
            _timer.workMinutes = workMinutes;
            _timer.breakMinutes = breakMinutes;
            _timer.repeatCount = repeatCount;
            _timer.timerState = POSTSETUP;
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [currentData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component
{
    return [currentData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch ((int)_selectorState) {
        case WORKTIME:
            workMinutes = [[[workTime objectAtIndex:row] stringByReplacingOccurrencesOfString:@" minutes" withString:@""] intValue];
            break;
            
        case BREAKTIME:
            breakMinutes = [[[breakTime objectAtIndex:row] stringByReplacingOccurrencesOfString:@" minutes" withString:@""] intValue];
            break;
            
        case REPEATCOUNT:
            repeatCount = [[[[repeatCounts objectAtIndex:row] stringByReplacingOccurrencesOfString:@" times" withString:@""] stringByReplacingOccurrencesOfString:@" time" withString:@""] intValue];
            break;
            
        default:
            break;
    }
    rowRecord = row;
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
