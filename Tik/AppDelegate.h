//
//  AppDelegate.h
//  Tik
//
//  Created by Adam Gleichsner on 1/17/15.
//  Copyright (c) 2015 Adam Gleichsner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

