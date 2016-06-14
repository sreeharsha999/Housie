//
//  CallerViewController.m
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "CallerViewController.h"
#import "AppDelegate.h"


@interface CallerViewController ()
{
    CGPoint startingPoint;
    CGPoint endingPoint;
    CGPoint point;
    int checking;
    int first,second,third,compleate,fastFive;
    CGRect labelRect;
    NSMutableArray *latestTenNos;
    UISwitch *firstRowSwitch, *secondRowSwitch, *thirdRowSwitch, *fastFiveSwitch;
    UIView *v3;
    UIView *v4;
    AppDelegate *appDelegate;
    NSString *firstRowString, *secondRowString, *thirdRowString, *fastFiveString,*lastTenString;
    
    
}
@property(nonatomic,strong)NSMutableArray *allNoInTickets;
@end

@implementation CallerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}


-(void)getTickets:(NSArray*)tickets
{
    allTickets = tickets;
    caller = 0;
}

-(void)onlyCaller
{
    caller = 1;
    
}

-(void)prepareDictionary
{
    int j = 1;
    NSMutableSet *nosSet = [[NSMutableSet alloc]init];
    ticketSets = [[NSMutableDictionary alloc]init];
    for (NSArray *temp  in allTickets) {
        int i = 0;
        NSMutableSet *firstRow = [[NSMutableSet alloc]init];
        NSMutableSet *secondRow = [[NSMutableSet alloc]init];
        NSMutableSet *thirdRow = [[NSMutableSet alloc]init];
        for (NSNumber *number in temp) {
            [nosSet addObject:number];
            if(i < 9)
            {
                [firstRow addObject:number];
            }else if (i < 18) {
                [secondRow addObject:number];
            }else {
                [thirdRow addObject:number];
            }
            i++;
        }
        NSArray *arr = [[NSArray alloc]initWithObjects:firstRow,secondRow,thirdRow, nil];
        [ticketSets setObject:arr forKey:[NSNumber numberWithInt:j]];
        j++;
        
    }
    [nosSet removeObject:[NSNumber numberWithInt:0]];
    self.allNoInTickets = [[NSMutableArray alloc]init];
    for (NSNumber *number in nosSet) {
        [self.allNoInTickets addObject:number];
    }
    
    
    //starting timer and updating and scrolling the text in completions views labels
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(UpdateAndScrollLabel) userInfo:nil repeats:YES];
    
}

#pragma mark vieLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //starting all strings
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    firstRowString = @""; secondRowString = @""; thirdRowString = @""; fastFiveString = @""; lastTenString = @"Latest ten numbers are displayed here";
    appDelegate = [[UIApplication sharedApplication]delegate];
    [Utilities gradientforViewcontrollerView:self.view];
    [Utilities gradientforViewcontrollerView:self.noDispaly];
    [Utilities gradientforViewcontrollerView:self.compleations];
    
    self.title = @"Caller";
    for (UILabel *numbers in self.noDispaly.subviews) {
        numbers.layer.cornerRadius = 3;
        [Utilities setBackGroundColorForView:numbers];
        [numbers setNeedsDisplay];
    }
    self.displayNo.layer.cornerRadius = 5;
    v3 = [[UIView alloc]initWithFrame:CGRectMake(0, 250, 30, 40)];
    v3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slider.png"]];
    [self.view addSubview:v3];
    v3.layer.cornerRadius = 0.5;
    if (caller == 1) {
# pragma mark  need to uncomment
        //self.compleations.hidden = YES;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateOnlyLatestTenLabel) userInfo:nil repeats:YES];
    }
    //saving the rect of the label
    labelRect = self.displayNo.frame;
    latestTenNos = [[NSMutableArray alloc]init];
    first = 0, second = 0, third = 0, compleate = 0,fastFive = 0;
    selectedNos = [[NSMutableSet alloc]init];
    [selectedNos addObject:[NSNumber numberWithInt:0]];
    allNo = [[NSMutableArray alloc]init];
    int i ;
    for(i = 1;i < 91;i++)
    {
        [allNo addObject:[NSNumber numberWithInt:i]];
    }
    sounds = [[NSArray alloc]initWithObjects:@"pb_1",@"pb_2",@"pb_3",@"pb_4",@"pb_5",@"pb_6",@"pb_7",@"pb_8",@"pb_9",@"pb_10",@"pb_11",@"pb_12",@"pb_13",@"pb_14",@"pb_15",@"pb_16",@"pb_17",@"pb_18",@"pb_19",@"pb_20",@"pb_21",@"pb_22",@"pb_23",@"pb_24",@"pb_25",@"pb_26",@"pb_27",@"pb_28",@"pb_29",@"pb_30",@"pb_31",@"pb_32",@"pb_33",@"pb_34",@"pb_35",@"pb_36",@"pb_37",@"pb_38",@"pb_39",@"pb_40",@"pb_41",@"pb_42",@"pb_43",@"pb_44",@"pb_45",@"pb_46",@"pb_47",@"pb_48",@"pb_49",@"pb_50",@"pb_51",@"pb_52",@"pb_53",@"pb_54",@"pb_55",@"pb_56",@"pb_57",@"pb_58",@"pb_59",@"pb_60",@"pb_61",@"pb_62",@"pb_63",@"pb_64",@"pb_65",@"pb_66",@"pb_67",@"pb_68",@"pb_69",@"pb_70",@"pb_71",@"pb_72",@"pb_73",@"pb_74",@"pb_75",@"pb_76",@"pb_77",@"pb_78",@"pb_79",@"pb_80",@"pb_81",@"pb_82",@"pb_83",@"pb_84",@"pb_85",@"pb_86",@"pb_87",@"pb_88",@"pb_89",@"pb_90", nil];
    // Do any additional setup after loading the view from its nib.
    self.swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipR.direction = UISwipeGestureRecognizerDirectionRight;
    if (caller == 0) {
        
        firstRowTickets = [[NSMutableSet alloc]init];
        secondRowTickets = [[NSMutableSet alloc]init];
        thirdRowTickets = [[NSMutableSet alloc]init];
        fastFiveTickets = [[NSMutableSet alloc]init];
        compleationTickets = [[NSMutableSet alloc]init];
        v4 = [[UIView alloc]initWithFrame:CGRectMake(290, 194, 30, 40)];
        
        v4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sliderR.png"]];
        v4.layer.cornerRadius = 0.5;
        v4.layer.masksToBounds = YES;
        [self.view addSubview:v4];
        
        [self prepareDictionary];
        
        // Hiding the labels sothat it wont appear on the main view
        self.firstLabel.hidden = YES;
        self.fastLabel.hidden = YES;
        self.secondLabel.hidden = YES;
        self.ThirdLabel.hidden = YES;
        //adding tableview
        
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0,-13, self.view.frame.size.width, 200) style:UITableViewStyleGrouped];
        [self.compleations addSubview:table];
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = NO;
        table.backgroundView.opaque = YES;
        table.backgroundView = nil;
        table.separatorColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
        
        //Adding actions to the switches
        
        firstRowSwitch = [[UISwitch alloc]init];
        firstRowSwitch.onTintColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
        [firstRowSwitch addTarget:self action:@selector(FirstRowSwith:) forControlEvents:UIControlEventTouchUpInside];
        firstRowSwitch.on = YES;
        secondRowSwitch = [[UISwitch alloc]init];
        secondRowSwitch.onTintColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
        [secondRowSwitch addTarget:self action:@selector(SecondRowSwith:) forControlEvents:UIControlEventTouchUpInside];
        secondRowSwitch.on = YES;
        thirdRowSwitch = [[UISwitch alloc]init];
        thirdRowSwitch.onTintColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
        [thirdRowSwitch addTarget:self action:@selector(ThirdRowSwith:) forControlEvents:UIControlEventTouchUpInside];
        thirdRowSwitch.on = YES;
        fastFiveSwitch = [[UISwitch alloc]init];
        fastFiveSwitch.onTintColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
        [fastFiveSwitch addTarget:self action:@selector(FastFiveSwitch:) forControlEvents:UIControlEventTouchUpInside];
        fastFiveSwitch.on = YES;
    }
    self.displayNo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"anLabel2.png"]];
    
    //configuring iAd banner
    //[[UIScreen mainScreen] bounds].size.height - 150
    self.adBanner.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, 320, 50);
    //    [self.view addSubview:self.adBanner];
    self.bannerIsVisible =NO;
    //    self.adBanner.delegate = self;
    //    [self.view bringSubviewToFront:self.adBanner];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(home)];
    [homeButton setTitle:@"Home"];
    self.navigationItem.rightBarButtonItem = homeButton;
    self.scrollerImage.layer.cornerRadius = 15;
    self.scrollerImage.layer.masksToBounds = YES;
    
}
-(void)home
{
    if (caller == 1 ) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        if (compleationTickets.count == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"You will loose the present game " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Home", nil];
            
            [alert show];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    v3 = nil;
    v4 = nil;
    latestTenNos = nil;
    [self setNoDispaly:nil];
    [self setSwipe:nil];
    [self setCompleations:nil];
    [self setSwipR:nil];
    [self setDisplayNo:nil];
    [self setFirstLabel:nil];
    [self setSecondLabel:nil];
    [self setThirdLabel:nil];
    [self setFastLabel:nil];
    [self setLastLable:nil];
    [self setAdBanner:nil];
    [self setScrollerImage:nil];
    [super viewDidUnload];
}




#pragma mark to update and scroll the text in labels

-(void)updateOnlyLatestTenLabel
{
    self.lastLable.text = lastTenString;
    self.lastLable.center = CGPointMake(self.lastLable.center.x - 3.5, self.lastLable.center.y);
    if (self.lastLable.frame.origin.x < -(self.lastLable.bounds.size.width/2)) {
        self.lastLable.center = CGPointMake(320 + (self.lastLable.bounds.size.width/2),self.lastLable.center.y);
        
    }
}
-(void)UpdateAndScrollLabel
{
    self.firstLabel.text = firstRowString;
    self.firstLabel.center = CGPointMake(self.firstLabel.center.x - 3.5, self.firstLabel.center.y);
    if (self.firstLabel.frame.origin.x < -(self.firstLabel.bounds.size.width/2)) {
        self.firstLabel.center = CGPointMake(320 + (self.firstLabel.bounds.size.width/2),self.firstLabel.center.y);
    }
    
    //for second row
    self.secondLabel.text = secondRowString;
    self.secondLabel.center = CGPointMake(self.secondLabel.center.x - 3.5, self.secondLabel.center.y);
    if (self.secondLabel.frame.origin.x < -(self.secondLabel.bounds.size.width/2)) {
        self.secondLabel.center = CGPointMake(320 + (self.secondLabel.bounds.size.width/2),self.secondLabel.center.y);
    }
    
    //for third row
    self.ThirdLabel.text = thirdRowString;
    self.ThirdLabel.center = CGPointMake(self.ThirdLabel.center.x - 3.5, self.ThirdLabel.center.y);
    if (self.ThirdLabel.frame.origin.x < -(self.ThirdLabel.bounds.size.width/2)) {
        self.ThirdLabel.center = CGPointMake(320 + (self.ThirdLabel.bounds.size.width/2),self.ThirdLabel.center.y);
    }
    
    //for fast five
    self.fastLabel.text = fastFiveString;
    self.fastLabel.center = CGPointMake(self.fastLabel.center.x - 3.5, self.fastLabel.center.y);
    if (self.fastLabel.frame.origin.x < -(self.fastLabel.bounds.size.width/2)) {
        self.fastLabel.center = CGPointMake(320 + (self.fastLabel.bounds.size.width/2),self.fastLabel.center.y);
    }
    
    //for last label
    self.lastLable.text = lastTenString;
    self.lastLable.center = CGPointMake(self.lastLable.center.x - 3.5, self.lastLable.center.y);
    if (self.lastLable.frame.origin.x < -(self.lastLable.bounds.size.width/2)) {
        self.lastLable.center = CGPointMake(320 + (self.lastLable.bounds.size.width/2),self.lastLable.center.y);
    }
    
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSNumber *generatedNo;
    static int k = 0;
    if (allNo.count != 0) {
        if (![audioPlayer isPlaying]) {
            if (caller == 1) {
                int x = arc4random_uniform((int)allNo.count);
                generatedNo = [allNo objectAtIndex:x];
                [allNo removeObjectAtIndex:x];
            }
            else{
                int x ;
                if (k%2 == 0 || self.allNoInTickets.count == 0) {
                    x = arc4random_uniform((int)allNo.count);
                    generatedNo = [allNo objectAtIndex:x];
                    [allNo removeObjectAtIndex:x];
                    [self.allNoInTickets removeObject:generatedNo];
                }
                else{
                    x = arc4random_uniform((int)self.allNoInTickets.count);
                    generatedNo = [self.allNoInTickets objectAtIndex:x];
                    [allNo removeObject:generatedNo];
                    [self.allNoInTickets removeObject:generatedNo];
                }
                k++;
            }
            //updating the latest ten no array
            if (latestTenNos.count < 10) {
                [latestTenNos insertObject:generatedNo atIndex:0];
            }
            else{
                [latestTenNos removeObjectAtIndex:9];
                [latestTenNos insertObject:generatedNo atIndex:0];
            }
            
            UILabel *labelTarget = (UILabel *) [self.noDispaly viewWithTag:[generatedNo intValue]];
            //            [UIView beginAnimations:@"zoom1" context:nil];
            //            [UIView setAnimationDuration:0.8];
            //            CGRect rect = labelTarget.frame;
            //            labelTarget.frame = CGRectMake(labelTarget.frame.origin.x-20,labelTarget.frame.origin.y-20,labelTarget.frame.size.width + 40, labelTarget.frame.size.height+40);
            //            labelTarget.frame = rect;
            //            [UIView setAnimationRepeatAutoreverses:YES];
            //            [UIView commitAnimations];
            [self.noDispaly bringSubviewToFront:labelTarget];
            CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
            [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 3)]];
            [basic setAutoreverses:YES];
            [basic setRepeatCount:2];
            [basic setDuration:0.5];
            [labelTarget.  layer addAnimation:basic forKey:@"transform"];
            labelTarget.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selectedLabel.png"]];
            self.displayNo.frame = labelRect;
            [self diplayTheNoWithAnimation:[generatedNo intValue]];
            [selectedNos addObject:generatedNo];
            
            NSString * soundFilePath = [[NSBundle mainBundle] pathForResource:[sounds objectAtIndex:[generatedNo intValue]-1]  ofType:@"mp3"];
            
            //           NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
            
            NSError *error = nil;
            NSData * data = [ NSData dataWithContentsOfFile:soundFilePath options:NSDataReadingMapped error:&error ] ;
            
            // Create a sound ID,
            //            SystemSoundID myID;
            // Register the sound
            //            AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &myID) ;
            // Play the sound!
            //            AudioServicesPlaySystemSound(myID);
            
            audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
            if (audioPlayer == nil)
                NSLog(@"%@",error);
            else
            {
                [audioPlayer play];
                
            }
            NSLog(@"%d",[generatedNo intValue]);
            if (caller == 0) {
                [self verifyForCompleations];
            }
        }
    }
}

- (IBAction)nextNo:(UIButton*)sender {
    sender.hidden = YES;
    [self performSelector:@selector(unHideButton:) withObject:sender afterDelay:3.3];
    NSNumber *generatedNo;
    static int k = 0;
    if (allNo.count != 0) {
        if (![audioPlayer isPlaying]) {
            if (caller == 1) {
                int x = arc4random_uniform((int)allNo.count);
                generatedNo = [allNo objectAtIndex:x];
                [allNo removeObjectAtIndex:x];
            }
            else{
                int x ;
                if (k%2 == 0 || self.allNoInTickets.count == 0) {
                    x = arc4random_uniform((int)allNo.count);
                    generatedNo = [allNo objectAtIndex:x];
                    [allNo removeObjectAtIndex:x];
                    [self.allNoInTickets removeObject:generatedNo];
                }
                else{
                    x = arc4random_uniform((int)self.allNoInTickets.count);
                    generatedNo = [self.allNoInTickets objectAtIndex:x];
                    [allNo removeObject:generatedNo];
                    [self.allNoInTickets removeObject:generatedNo];
                }
                k++;
            }
            //updating the latest ten no array
            if (latestTenNos.count < 10) {
                [latestTenNos insertObject:generatedNo atIndex:0];
            }
            else{
                [latestTenNos removeObjectAtIndex:9];
                [latestTenNos insertObject:generatedNo atIndex:0];
            }
            lastTenString = @"";
            for (NSNumber *number in latestTenNos) {
                
                lastTenString = [lastTenString stringByAppendingString:[NSString stringWithFormat:@"%@  ",number]];
            }
            
            UILabel *labelTarget = (UILabel *) [self.noDispaly viewWithTag:[generatedNo intValue]];
            //            [UIView beginAnimations:@"zoom1" context:nil];
            //            [UIView setAnimationDuration:0.8];
            //            CGRect rect = labelTarget.frame;
            //            labelTarget.frame = CGRectMake(labelTarget.frame.origin.x-20,labelTarget.frame.origin.y-20,labelTarget.frame.size.width + 40, labelTarget.frame.size.height+40);
            //             labelTarget.frame = rect;
            //            [UIView setAnimationRepeatAutoreverses:YES];
            //            [UIView commitAnimations];
            [self.noDispaly bringSubviewToFront:labelTarget];
            CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
            [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 3)]];
            [basic setAutoreverses:YES];
            [basic setRepeatCount:2];
            [basic setDuration:0.3];
            [labelTarget.  layer addAnimation:basic forKey:@"transform"];
            labelTarget.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nonSelected.png"]];
            self.displayNo.frame = labelRect;
            [self diplayTheNoWithAnimation:[generatedNo intValue]];
            self.displayNo.text = [NSString stringWithFormat:@"%d",[generatedNo intValue] ];
            [selectedNos addObject:generatedNo];
            
            NSString * soundFilePath = [[NSBundle mainBundle] pathForResource:[sounds objectAtIndex:[generatedNo intValue]-1]  ofType:@"mp3"];
            
            //           NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
            
            NSError *error = nil;
            NSData * data = [ NSData dataWithContentsOfFile:soundFilePath options:NSDataReadingMapped error:&error ] ;
            
            // Create a sound ID,
            //            SystemSoundID myID;
            // Register the sound
            //            AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &myID) ;
            // Play the sound!
            //            AudioServicesPlaySystemSound(myID);
            
            audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
            if (audioPlayer == nil)
                NSLog(@"%@",error);
            else
            {
                [audioPlayer play];
                
            }
            NSLog(@"%d",[generatedNo intValue]);
            if (caller == 0) {
                [self performSelector:@selector(verifyForCompleations) withObject:nil afterDelay:0.01];
            }
        }
    }
}

-(void)unHideButton:(UIButton*)sender
{
    sender.hidden = NO;
}



#pragma mark verifications


-(void)verifyForCompleations
{
    NSMutableArray *alerts = [NSMutableArray array];
    int count;
    NSEnumerator *enumrat = [ticketSets objectEnumerator];
    NSArray *temp;
    while ((temp = enumrat.nextObject))  {
        NSNumber *no = [[ticketSets allKeysForObject:temp] objectAtIndex:0];
        [self verifyForFastFiveWithTicketNo:no andTicket:temp];
        int i = 0;
        for (NSSet *set in temp) {
            if ([set isSubsetOfSet:selectedNos]) {
                //checking which row ticket is it
                if (i == 0) {
                    //checking wether switch is on or of
                    if (first == 0) {
                        count = 0;
                        //checking if the ticket is alredy present in the completed tickets
                        for (NSNumber *num in firstRowTickets) {
                            if (num == no) {
                                count++;
                            }
                        }
                        //if it is not present showing the alert view
                        if (count == 0) {
                            
                            [alerts addObject:[NSString stringWithFormat:@"First row of ticket %@ is completed",no]];
                            //                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Row Completed" message:[NSString stringWithFormat:@"First row of ticket %@ is completed",no] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                            //                            [alert show];
                        }
                    }
                    [firstRowTickets addObject:no];
                    firstRowString = @"";
                    for (NSNumber *numb in firstRowTickets) {
                        firstRowString = [firstRowString stringByAppendingFormat:@"%@  ",numb];
                    }
                    compleate++;
                }else if(i == 1){
                    
                    
                    if (second == 0) {
                        count = 0;
                        for (NSNumber *num in secondRowTickets) {
                            if (num == no) {
                                count++;
                            }
                        }
                        if (count == 0) {
                            [alerts addObject:[NSString stringWithFormat:@"Second row of ticket %@ is completed",no]];
                            //                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Row Completed" message:[NSString stringWithFormat:@"Second row of ticket %@ is completed",no] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                            //                            [alert show];
                        }
                    }
                    [secondRowTickets addObject:no];
                    secondRowString = @"";
                    for (NSNumber *numb in secondRowTickets) {
                        secondRowString = [secondRowString stringByAppendingFormat:@"%@  ",numb];
                    }
                    
                    compleate++;
                    
                }else if(i == 2){
                    
                    if (third == 0) {
                        count = 0;
                        for (NSNumber *num in thirdRowTickets) {
                            if (num == no) {
                                count++;
                            }
                        }
                        if (count == 0) {
                            [alerts addObject:[NSString stringWithFormat:@"Third row of ticket %@ is completed",no]];
                            //                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Row Completed" message:[NSString stringWithFormat:@"Third row of ticket %@ is completed",no] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                            //                            [alert show];
                        }
                    }
                    [thirdRowTickets addObject:no];
                    thirdRowString = @"";
                    for (NSNumber *numb in thirdRowTickets) {
                        thirdRowString = [firstRowString stringByAppendingFormat:@"%@  ",numb];
                    }
                    
                    compleate++;
                }
            }
            i++;
            
            
        }
        if (compleate == 3) {
            count = 0;
            for (NSNumber *num in compleationTickets) {
                if (num == no) {
                    count++;
                }
            }
            if (count == 0) {
                [alerts addObject:[NSString stringWithFormat:@" Ticket %@ has completed housie",no]];
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Housie Completed" message:[NSString stringWithFormat:@" Ticket %@ has completed housie",no] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                //                [alert show];
            }
            
            [compleationTickets addObject:no];
            
        }
        compleate = 0;
        if (firstRowTickets.count == 1) {
            firstRowSwitch.on = NO;
            first = 1;
        }
        if (secondRowTickets.count == 1) {
            secondRowSwitch.on = NO;
            second = 1;
        }
        if (thirdRowTickets.count == 1) {
            thirdRowSwitch.on = NO;
            third = 1;
        }
        
    }
    if (alerts.count != 0) {
        NSString *combinedAllert = @"" ;
        int i = 0;
        for (NSString *str in alerts) {
            if (i == 0) {
                combinedAllert = [combinedAllert stringByAppendingString:str];
            }else{
                combinedAllert = [combinedAllert stringByAppendingFormat:@"\n%@",str];
            }
            
            i++;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Completion" message:combinedAllert delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
}


-(void)verifyForFastFiveWithTicketNo:(NSNumber*)no andTicket:(NSArray*)tSet
{
    int commonNos = 0,count;
    @autoreleasepool {
        for (NSSet *se in tSet) {
            NSMutableSet *temSet = [NSMutableSet setWithSet:selectedNos];
            [temSet intersectSet:se];
            commonNos += [temSet count];
        }
    }
    
    if (commonNos == 8) {
        //checking wether switch is on or of
        if (fastFive  == 0) {
            count = 0;
            //checking if the ticket is alredy present in the completed tickets
            for (NSNumber *num in fastFiveTickets) {
                if (num == no) {
                    count++;
                }
            }
            //if it is not present showing the alert view
            if (count == 0) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fast Five Completed" message:[NSString stringWithFormat:@"Fast Five is completed for ticket No:%@",no] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
            }
        }
        [fastFiveTickets addObject:no];
        fastFiveString = @"";
        for (NSNumber *numb in fastFiveTickets) {
            fastFiveString = [fastFiveString stringByAppendingFormat:@"  %@",numb];
        }
        if (fastFiveTickets.count == 1) {
            fastFiveSwitch.on = NO;
            fastFive = 1;
        }
        
    }
}



#pragma mark animation method

-(void)diplayTheNoWithAnimation:(int)no
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.displayNo.layer addAnimation:animation forKey:@"changeTextTransition"];
    
    [UIView beginAnimations:@"zoom" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:2];
    
    //    CGSize sz = CGSizeMake(self.an.frame.size.width + 100, self.an.frame.size.height+100);
    // Change the text
    
    //    self.displayNo.text = [NSString stringWithFormat:@"%d",no ];
    self.displayNo.frame = CGRectMake(self.displayNo.frame.origin.x-50,self.displayNo.frame.origin.y-50,self.displayNo.frame.size.width + 100, self.displayNo.frame.size.height+100);
    self.displayNo.font = [UIFont boldSystemFontOfSize:40];
    [UIView commitAnimations];
    
}






#pragma mark touch methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    startingPoint  = [[touches anyObject] locationInView:self.view];
    NSLog(@"%f  %f",startingPoint.x,startingPoint.y);
    if (CGRectContainsPoint(v3.frame, startingPoint)) {
        checking = 1;
        
    }else if (CGRectContainsPoint(v4.frame, startingPoint))
    {
        checking = 2;
    }
    else{
        checking = 0;
    }
    point = startingPoint;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint movedPoint = [[touches anyObject] locationInView:self.view];
    float change = movedPoint.x - point.x;
    if (checking == 1) {
        CGPoint p = CGPointMake(v3.center.x + change, v3.center.y);
        
        v3.center = p;
        
        CGPoint p1 = CGPointMake(self.noDispaly.center.x + change, self.noDispaly.center.y);
        self.noDispaly.center = p1;
    }else if(checking == 2){
        CGPoint p = CGPointMake(v4.center.x + change, v4.center.y);
        v4.center = p;
        CGPoint p1 = CGPointMake(self.compleations.center.x + change, self.compleations.center.y);
        self.compleations.center = p1;
    }
    point = movedPoint;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (checking == 1) {
        
        if (point.x > 100) {
            int distenceToMove = self.noDispaly.frame.origin.x - 0;
            [UIView beginAnimations:@"left" context:NULL];
            self.noDispaly.frame = CGRectOffset(self.noDispaly.frame, -distenceToMove, 0);
            v3.frame = CGRectOffset(v3.frame, -distenceToMove, 0);
            [UIView commitAnimations];
            self.navigationItem.hidesBackButton = YES;
            v4.frame = CGRectMake(0, 0, 0, 0);
            self.title = @"Generated No's";
            
        }else{
            int distenceToMove = self.noDispaly.frame.origin.x + 320;
            [UIView beginAnimations:@"left" context:NULL];
            self.noDispaly.frame = CGRectOffset(self.noDispaly.frame, -distenceToMove, 0);
            v3.frame = CGRectOffset(v3.frame, -distenceToMove, 0);
            [UIView commitAnimations];
            
        }
    }
    else if (checking == 2)
    {
        if (point.x < 220) {
            int distenceToMove =0 - self.compleations.frame.origin.x ;
            [UIView beginAnimations:@"right" context:NULL];
            self.compleations.frame = CGRectOffset(self.compleations.frame, distenceToMove, 0);
            v4.frame = CGRectOffset(v4.frame, distenceToMove, 0);
            
            [UIView commitAnimations];
            self.firstLabel.hidden = NO;
            self.fastLabel.hidden = NO;
            self.secondLabel.hidden = NO;
            self.ThirdLabel.hidden = NO;
            self.adBanner.hidden = YES;
            v3.frame = CGRectMake(0, 0, 0, 0);
            self.navigationItem.hidesBackButton = YES;
            self.title = @"Completions";
            
        }else{
            int distenceToMove =320- self.compleations.frame.origin.x ;
            [UIView beginAnimations:@"right" context:NULL];
            self.compleations.frame = CGRectOffset(self.compleations.frame, distenceToMove, 0);
            v4.frame = CGRectOffset(v4.frame, distenceToMove, 0);
            [UIView commitAnimations];
            
        }
        
    }
}

- (IBAction)leftSwipe:(id)sender {
    
    [UIView beginAnimations:@"left" context:NULL];
    self.noDispaly.frame = CGRectOffset(self.noDispaly.frame, -320, 0);
    v3.frame = CGRectOffset(v3.frame, -320, 0);
    [UIView commitAnimations];
    self.navigationItem.hidesBackButton = NO ;
    if (caller == 0) {
        v4.frame =  CGRectMake(290, 194, 30, 40);
    }
    
    self.title = @"Caller";
    
}
- (IBAction)rightSwipe:(id)sender {
    [UIView beginAnimations:@"right" context:NULL];
    self.compleations.frame = CGRectOffset(self.compleations.frame, 320, 0);
    v4.frame = CGRectOffset(v4.frame, 320, 0);
    [UIView commitAnimations];
    self.firstLabel.hidden = YES;
    self.fastLabel.hidden = YES;
    self.secondLabel.hidden = YES;
    self.ThirdLabel.hidden = YES;
    self.adBanner.hidden = NO;
    self.navigationItem.hidesBackButton = NO;
    self.title = @"Caller";
    v3.frame  = CGRectMake(0, 250, 30, 40);
}


- (IBAction)FirstRowSwith:(UISwitch *)sender {
    
    if (sender.on) {
        first = 0;
    }
    else{
        first = 1;
    }
}

- (IBAction)SecondRowSwith:(UISwitch *)sender {
    if (sender.on) {
        second = 0;
    }
    else{
        second = 1;
    }
}

- (IBAction)ThirdRowSwith:(UISwitch *)sender {
    if (sender.on) {
        third = 0;
    }
    else{
        third = 1;
    }
}

- (IBAction)FastFiveSwitch:(UISwitch *)sender {
    if (sender.on) {
        fastFive = 0;
    }
    else{
        fastFive = 1;
    }
}


#pragma mark tableViewMethods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // Configure the cell...
        if (indexPath.row == 0) {
            cell.accessoryView = firstRowSwitch;
            cell.textLabel.text = @"First Row";
        }else if (indexPath.row == 1) {
            cell.accessoryView = secondRowSwitch;
            cell.textLabel.text = @"Second Row";
        }else if (indexPath.row == 2) {
            cell.accessoryView = thirdRowSwitch;
            cell.textLabel.text = @"Third Row";
        }else if (indexPath.row == 3) {
            cell.accessoryView = fastFiveSwitch;
            cell.textLabel.text = @"FastFive";
        }
        
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Completions Alerts";
}


#pragma mark iAd Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the top of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the top of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, 50.0f);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}


@end
