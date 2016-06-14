//
//  TicketsViewController.m
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "TicketsViewController.h"
#import "HGTGenerateTicket.h"
#import "HSEticketView.h"
#import "CallerViewController.h"
#import "PdfCreator.h"
#import "AppDelegate.h"
#import "HTTPViewController.h"

@interface TicketsViewController ()
@property(nonatomic, strong) NSMutableArray *ticketsArray;
@property(strong, nonatomic) HGTGenerateTicket *ticketGenerator;

@end

@implementation TicketsViewController

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
    [Utilities gradientforViewcontrollerView:self.view];
    self.ticketsArray = [[NSMutableArray alloc] init];
    self.ticketsTableView.backgroundColor = [UIColor clearColor];
    if (self.ticketGenerator == nil) {
        
        self.ticketsTableView.hidden = YES;
        self.toolBar.hidden = YES;
        //self.toolBar.tintColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.toolBar.bounds andColors:@[[UIColor colorWithRed:0.282 green:0.922 blue:0.729 alpha:1.000], [UIColor colorWithRed:0.000 green:0.749 blue:0.976 alpha:1.000]]];
 //        [self.toolBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toolBar.png"]] atIndex:1];
        self.ticketGenerator = [[HGTGenerateTicket alloc]init];
        [self.view bringSubviewToFront:self.toolBar];
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ticketsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HSEticketView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HSEticketView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [Utilities setBackGroundColorForView:cell];
         //[Utilities gradientWithStart:[UIColor colorWithHue:0.09*indexPath.row saturation:1.0 brightness:1.0 alpha:0.9] End:[UIColor colorWithHue:0.09*(indexPath.row +1) saturation:1.0 brightness:1.0 alpha:0.9] Alpha:0.5 forView:cell.contentView];
    }
    [cell Tickets:[self.ticketsArray objectAtIndex:indexPath.row]];
    // Configure the cell...
    int ticketNo = (int)indexPath.row + 1;
    [cell setTicketNo:ticketNo];
    return cell;
}

- (void) gradientWithStart:(UIColor *)startColor End:(UIColor *)endColor Alpha:(float)alpha  forCell:(UIView*) cell{
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)startColor.CGColor, endColor.CGColor, nil];
    
    //    NSNumber *stopOne = [NSNumber numberWithFloat:-0.2];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0];
    
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.frame = cell.bounds;
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    
    [headerLayer setStartPoint:CGPointMake(0, 0)];
    [headerLayer setEndPoint:CGPointMake(1.0, 1.0)];
    
    
    [cell.layer addSublayer:headerLayer];
    
}

//to increase the height of the cell

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}



- (IBAction)goAction:(id)sender {
    
    self.title = @"Generating Tickets....";
    if ([self.enteredNo.text isEqualToString:@""] || self.enteredNo.text.intValue == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Enter a no other than 0" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles: nil];
        [alert show];
        
    }
    else{
        [self.enteredNo resignFirstResponder];
        self.enteredNo.hidden = YES;
        self.label.hidden = YES;
        self.button.hidden = YES;
        self.ticketsTableView.hidden = NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.ticketGenerator GenerateNoOfTickets:[self.enteredNo.text intValue]:self];
        });
    }
}

#pragma mark ticketGenrate delgate methods

-(void)generationOfTicketCompleated:(NSArray*)tArray;
{
    dispatch_async(dispatch_get_main_queue(), ^{
            [self.ticketsArray addObject:tArray];
            [self.ticketsTableView reloadData];
        //[self.ticketsTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:YES];
        
        if (self.ticketsArray.count == self.enteredNo.text.intValue) {
            self.toolBar.hidden = NO;
            self.title = @"Completed";
            PdfCreator *create = [[PdfCreator alloc]init];
            [create getArrayOfTickets:self.ticketGenerator.ticketNumbers];
            [create MyCreatePDFFile];
            
        }
    });
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Tickets.pdf"];
        NSMutableData *pdfData = [NSMutableData dataWithContentsOfFile:path];
        [mailComposer setSubject:@"Housie Tickets"];
        [mailComposer setMessageBody:@"These tickets are sent from HousieApp" isHTML:NO];
        [mailComposer addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"Tickets.pdf"];
        [self presentViewController:mailComposer animated:YES completion:nil];
        
    }else if(buttonIndex == 1)
    {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Tickets.pdf"];
        NSData *myPDFData = [NSData dataWithContentsOfFile:path];
        UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
        if  (pic && [UIPrintInteractionController canPrintData: myPDFData] ) {
            pic.delegate = self;
            
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = [path lastPathComponent];
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            pic.printInfo = printInfo;
            pic.showsPageRange = YES;
            pic.printingItem = myPDFData;
            
            void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
            ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
                //                self.content = nil;
                if (!completed && error)
                    NSLog(@"FAILED! due to error in domain %@ with error code %lu",
                          error.domain, error.code);
            };
            {
                [pic presentAnimated:YES completionHandler:completionHandler];
            }
        }
    }else if (buttonIndex == 2)
    {
        [self performSegueWithIdentifier:@"HTTPSegue" sender:self];
    }
}

- (IBAction)print:(id)sender {
    UIActionSheet *shareSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Mail",@"Print",@"Share via Wifi", nil];
    [shareSheet showFromToolbar:self.toolBar];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)play:(id)sender {
    CallerViewController *caller = [[CallerViewController alloc] init];
    [caller getTickets:self.ticketsArray];
    self.title = @"Tickets";
    [self.navigationController pushViewController:caller animated:YES];
}
@end
