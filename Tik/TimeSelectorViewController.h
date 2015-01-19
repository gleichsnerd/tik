//
//  TimeSelectorViewController.h
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerViewController.h"

@interface TimeSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) TimerViewController *timer;

@end

typedef enum: NSUInteger {
    WORKTIME,
    BREAKTIME,
    REPEATCOUNT
} TimeSelectorStage;