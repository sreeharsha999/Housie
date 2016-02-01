//
//  AppDelegate.m
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    //Getting resources from resources plist
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Resources" ofType:@"plist"];
    self.resources = [[NSDictionary alloc]initWithContentsOfFile:path];
//    NSArray *colorValues = [self.resources valueForKey:@"appBackGrounColor"];
    NSArray *navTextColor = [self.resources valueForKey:@"navBarTextColor"];
//    NSArray *labelColor = [self.resources valueForKey:@"allLabelsColor"];
    self.backGroundColor = [UIColor colorWithRed:0.094 green:0.294 blue:0.596 alpha:1.000];//[UIColor colorWithRed:((NSString*)[colorValues objectAtIndex:0]).floatValue  green:((NSString*)[colorValues objectAtIndex:1]).floatValue blue:((NSString*)[colorValues objectAtIndex:2]).floatValue alpha:((NSString*)[colorValues objectAtIndex:3]).floatValue];
//    self.backGroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"canvas.png"]];
////    self.backGroundColor = [UIColor clearColor];
//    
//    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    self.viewController.title = @"Housie";
//    self.navigator = [[ UINavigationController alloc] initWithRootViewController:self.viewController];
//    UIImage *img = [[UIImage imageNamed:@"navBar.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
////    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0 green:255 blue:255 alpha:0.9]];
//    UIImage *buttonImage = [[UIImage imageNamed:@"backButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 10, 1, 10)];
//    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"toolBarButton.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIFont fontWithName:[self.resources valueForKey:@"navBarTextFont"] size:0.0],
//      UITextAttributeFont,[UIColor colorWithRed:((NSString*)[navTextColor objectAtIndex:0]).floatValue green:((NSString*)[navTextColor objectAtIndex:1]).floatValue blue:((NSString*)[navTextColor objectAtIndex:2]).floatValue alpha:((NSString*)[navTextColor objectAtIndex:3]).floatValue],UITextAttributeTextColor,
//      nil]];
//    
//    //UILabel appearence
////        [[UILabel appearance] setColor:[UIColor colorWithRed:((NSString*)[labelColor objectAtIndex:0]).floatValue green:((NSString*)[labelColor objectAtIndex:1]).floatValue blue:((NSString*)[labelColor objectAtIndex:2]).floatValue alpha:((NSString*)[labelColor objectAtIndex:3]).floatValue]];
//    
//    [self.navigator.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//    self.window.rootViewController = self.navigator;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
