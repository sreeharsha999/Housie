//
//  TicketsViewController.h
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "HGTGenerateTicket.h"

@interface TicketsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,HGTGenerateTicketDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIPrintInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *enteredNo;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *ticketsTableView;
- (IBAction)done:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)play:(id)sender;
@end
