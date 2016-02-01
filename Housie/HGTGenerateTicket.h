//
//  HGTGenerateTicket.h
//  trail
//
//  Created by Harsha on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGTGenerateTicket;

@protocol HGTGenerateTicketDelegate <NSObject>

-(void)generationOfTicketCompleated:(NSArray*)tArray;

@end

@interface HGTGenerateTicket : NSObject


@property(assign) id<HGTGenerateTicketDelegate> delgate;

@property(nonatomic, strong)NSMutableArray *ticketNumbers;

- (void)GenerateNoOfTickets:(int)noOfTickets :(id<HGTGenerateTicketDelegate>)someClass;

-(NSArray*)generateTickets;
@end
