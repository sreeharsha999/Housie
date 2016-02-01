//
//  CallerViewController.h
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
#import "QuartzCore/QuartzCore.h"
#import "AudioToolbox/AudioToolbox.h"
#import "iAd/iAd.h"

@interface CallerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ADBannerViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *allNo;
    NSMutableSet *selectedNos;
    AVAudioPlayer * audioPlayer;
    NSArray *sounds;
    NSArray *allTickets;
    NSMutableDictionary *ticketSets;
    NSMutableSet *firstRowTickets;
    NSMutableSet *secondRowTickets;
    NSMutableSet *thirdRowTickets;
    NSMutableSet *fastFiveTickets;
    NSMutableSet *compleationTickets;
    int caller;
    
    NSTimer *timer;
}

-(void)getTickets:(NSArray*)tickets;
-(void)onlyCaller;
@property (weak, nonatomic) IBOutlet UILabel *displayNo;

@property (weak, nonatomic) IBOutlet UIView *noDispaly;


@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
- (IBAction)leftSwipe:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *compleations;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipR;
- (IBAction)rightSwipe:(id)sender;

- (IBAction)FirstRowSwith:(id)sender;

- (IBAction)SecondRowSwith:(id)sender;

- (IBAction)ThirdRowSwith:(id)sender;

- (IBAction)FastFiveSwitch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lastLable;

//COMPLETION VIEW LABELS
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fastLabel;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;

@property (nonatomic,assign) BOOL bannerIsVisible;
@property (weak, nonatomic) IBOutlet UIImageView *scrollerImage;

@end
