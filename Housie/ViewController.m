//
//  ViewController.m
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "ViewController.h"
#import "TicketsViewController.h"
#import "CallerViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [Utilities gradientWithStart:[UIColor colorWithRed:0.282 green:0.922 blue:0.729 alpha:1.000] End:[UIColor colorWithRed:0.000 green:0.749 blue:0.976 alpha:1.000] Alpha:1 forView:self.view];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onlyCaller:(id)sender {
    CallerViewController *caller =[[CallerViewController alloc] init];
    [caller onlyCaller];
    [self.navigationController pushViewController:caller animated:YES];
}

@end
