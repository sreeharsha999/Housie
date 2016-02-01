//
//  HTTPViewController.h
//  Housie
//
//  Created by SREEHARSHA on 05/11/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@class   HTTPServer;

@interface HTTPViewController : UIViewController
{
    HTTPServer *httpServer;
	NSDictionary *addresses;
}
@property (weak, nonatomic) IBOutlet UILabel *displayInfo;
@property (weak, nonatomic) IBOutlet UILabel *info;

@end
