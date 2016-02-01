//
//  HTTPViewController.m
//  Housie
//
//  Created by SREEHARSHA on 05/11/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "HTTPViewController.h"
#import "AppDelegate.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "localhostAddresses.h"

@interface HTTPViewController ()

@end

@implementation HTTPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utilities gradientWithStart:[UIColor colorWithRed:0.282 green:0.922 blue:0.729 alpha:1.000] End:[UIColor colorWithRed:0.000 green:0.749 blue:0.976 alpha:1.000] Alpha:1 forView:self.view];
    NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    httpServer = [HTTPServer new];
    [httpServer setType:@"_http._tcp."];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    [httpServer setDocumentRoot:[NSURL fileURLWithPath:root]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayInfoUpdate:) name:@"LocalhostAdressesResolved" object:nil];
    [localhostAddresses performSelectorInBackground:@selector(list) withObject:nil];
    NSError *error;
    if(![httpServer start:&error])
    {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
    
    [self displayInfoUpdate:nil];
    [self cornerRadiusView: self.displayInfo];
    [self cornerRadiusView: self.info];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [httpServer stop];
    [super viewWillDisappear:animated];
}

- (void)cornerRadiusView:(UIView *)view
{
    view.layer.cornerRadius = 9;
    view.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9].CGColor;
    view.layer.borderWidth = 4.0;
    view.layer.shadowColor = [UIColor whiteColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 1.0f;
    view.layer.shadowRadius = 10.0f;
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.info.bounds].CGPath;
}

- (void)displayInfoUpdate:(NSNotification *) notification
{
    NSLog(@"displayInfoUpdate:");
    
    if(notification)
    {
        addresses = [[notification object] copy];
        NSLog(@"addresses: %@", addresses);
    }
    
    if(addresses == nil)
    {
        return;
    }
    
    NSString *info;
    UInt16 port = [httpServer port];
    
    NSString *localIP = nil;
    
    localIP = [addresses objectForKey:@"en0"];
    
    if (!localIP)
    {
        localIP = [addresses objectForKey:@"en1"];
    }
    
    if (!localIP)
        info = @"Wifi: No Connection!\n";
    else
        info = [NSString stringWithFormat:@"http://iphone.local:%d		http://%@:%d\n", port, localIP, port];
    
    NSString *wwwIP = [addresses objectForKey:@"www"];
    
    if (wwwIP)
        info = [info stringByAppendingFormat:@"Web: %@:%d\n", wwwIP, port];
    else
        info = [info stringByAppendingString:@"Web: Unable to determine external IP\n"];
    NSRange r;
    r.length = 26;
    r.location = 27;
    NSString *ip = [info substringWithRange:r];
    
    if ([ip hasPrefix:@"nable"]) {
        ip = @"No Internet Connection";
    }
    self.displayInfo.text = ip;
    NSLog(@"****************%@",ip);
    //    self.navigationController.navigationBar.backItem = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
