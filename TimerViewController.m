//
//  TimerViewController.m
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import "TimerViewController.h"
#import "TimeSelectorViewController.h"
#import "IssuesCenterViewController.h"

@interface TimerViewController ()

//Keep track of whether or not we should start or stop
@property (nonatomic) BOOL isTiming;

//Timer for countdown display and variable to allow countdown
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic) int remainingTicks;

@end

int remainingCounts;
UIBarButtonItem *searchButton;

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerState = PRESETUP;
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL) prefersStatusBarHidden {return NO;}

- (void)viewWillAppear:(BOOL)animated {
    searchButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                     target:self
                                     action:nil];
    UINavigationItem *topItem = self.navigationController.navigationBar.topItem;
    topItem.rightBarButtonItem = searchButton;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:66/255.0f green: 255/255.0f blue:35/255.0f alpha:1]];
    self.navigationController.navigationBar.opaque = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    if (self.timerState == POSTSETUP) {
        NSLog(@"%d\t%d\t%d", self.workMinutes, self.breakMinutes, self.repeatCount);
        self.timerDisplay.text = [NSString stringWithFormat:@"%02d:00", self.workMinutes];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setupTimer:(id)sender {
    TimeSelectorViewController *selectorController = [[TimeSelectorViewController alloc] init];
    selectorController.timer = self;
    [self.navigationController pushViewController:selectorController animated:YES];
}
- (IBAction)playOrPause:(id)sender {
    if (self.timerState == POSTSETUP) {
        [self doCountdown:self.workMinutes * 6000];
        remainingCounts = self.repeatCount;
        self.timerState = TIMING;
    } else if (self.timerState == TIMING) {
        [self doCountdown:self.remainingTicks];
        self.timerState = PAUSED;
    } else if (self.timerState == PAUSED) {
        [self doCountdown:self.remainingTicks];
        self.timerState = TIMING;
    }
}
- (IBAction)stopButtonAction:(id)sender {
    //Return to postsetup
    NSLog(@"Stopped timing, return to postsetup");
    self.timerState = POSTSETUP;
    self.isTiming = NO;
    [self.countdownTimer invalidate];
    self.remainingTicks = self.workMinutes * 6000;
    remainingCounts = self.repeatCount;
    [self updateLabel];
}
- (IBAction)openIssuesCenter:(id)sender {
    IssuesCenterViewController *issuesCenter = [[IssuesCenterViewController alloc] init];
    issuesCenter.timer = self;
    issuesCenter.searchButton = searchButton;
    issuesCenter.context = self.context;
    [self.navigationController pushViewController:issuesCenter animated:YES];
}

-(void)doCountdown:(int)remainingTicks
{
    //If we aren't timing, start
    if (!self.isTiming) {
        //In case we've already sent a file
        [self.timerDisplay setFont:[UIFont fontWithName:@"OpenSans" size:22]];
        //Setup for visual countdown
        self.remainingTicks = remainingTicks;
        [self updateLabel];
        self.isTiming = true;
        
        //Begin counting
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval: .01 target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
    } else {
        //Stop the clock!
        self.isTiming = false;
        [self.countdownTimer invalidate];
    }
}

-(void)handleTimerTick
{
    //If we're timing and haven't hit zero, decrement
    if (self.isTiming && self.remainingTicks > 0) {
        self.remainingTicks = self.remainingTicks - 1;
        [self updateLabel];
    } else if (self.remainingTicks <= 0) {
        if (self.timerState == TIMING) {
            //Switch to break
            NSLog(@"On break");
            self.timerState = BREAKTIME;
            remainingCounts--;
            self.isTiming = NO;
            [self.countdownTimer invalidate];
            [self doCountdown:self.breakMinutes * 6000];
            //TODO - invert color scheme
        } else if (self.timerState == BREAKTIME) {
            //Switch to timing while counts remaining
            if (remainingCounts > 0) {
                NSLog(@"On the clock, %d more times", remainingCounts);
                self.timerState = TIMING;
                self.isTiming = NO;
                [self.countdownTimer invalidate];
                [self doCountdown:self.workMinutes * 6000];
            } else {
                //We're done timing
                NSLog(@"Finished timing, return to postsetup");
                self.timerState = POSTSETUP;
                self.isTiming = NO;
                [self.countdownTimer invalidate];
                self.remainingTicks = self.workMinutes * 6000;
                remainingCounts = self.repeatCount;
                [self updateLabel];
            }
        }
    } else {
        //Kill the timer and stop timing
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        self.isTiming = false;
        
        [self updateLabel];
    }
}

-(void)updateLabel
{
    //Calculate total remaining minutes, seconds, and milliseconds
    int total = self.remainingTicks;
    
    int minutes = floor(total / 6000);
    total = total - minutes * 6000;
    
    int seconds = floor(total / 100);
    total = total - seconds * 100;
    
    
    //Display content like a stopwatch
    self.timerDisplay.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
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
