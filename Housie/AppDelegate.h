//
//  AppDelegate.h
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigator;
@property (strong, nonatomic) NSDictionary *resources;
@property (strong, nonatomic) UIColor *backGroundColor;

@end
