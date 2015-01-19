//
//  TimerViewController.h
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssuesCenter.h"

typedef enum: NSUInteger {
    PRESETUP,
    POSTSETUP,
    TIMING,
    PAUSED,
    ONBREAK,
    STOPPED
} TimerState;


@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *setupButton;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (nonatomic) TimerState *timerState;
@property (strong, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UINavigationBar *timerNavigationBar;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) IssuesCenter *issuesData;

@property (nonatomic) int workMinutes;
@property (nonatomic) int breakMinutes;
@property (nonatomic) int repeatCount;


@end

