//
//  IssuesCenter.h
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IssuesCenter : NSManagedObject

@property (nonatomic, retain) NSString * issue;
@property (nonatomic, retain) NSString * resolution;

@end
