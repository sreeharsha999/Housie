//
//  HSEticketView.h
//  Housie
//
//  Created by Harsha on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HSEticketView : UITableViewCell

@property (nonatomic, strong) UILabel *label;

- (void)Tickets:(NSArray*)ticketNosArray;
-(void)setTicketNo:(int) no;
@end
