//
//  HSEticketView.m
//  Housie
//
//  Created by Harsha on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HSEticketView.h"
#import "AppDelegate.h"


@implementation HSEticketView
{
    NSArray *ticketNos;
    
}

-(void)setTicketNo:(int) no
{
    self.label.text = [NSString stringWithFormat:@"TICKET NO:%d",no];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
//        AppDelegate *app = [[UIApplication sharedApplication]delegate];
        self.frame = CGRectMake(0, 0, 320, 165);
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, self.frame.size.width, 30)];
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.backgroundColor = [UIColor clearColor];
        self.backgroundColor =  [UIColor clearColor];
        [self addSubview:self.label];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)Tickets:(NSArray*)ticketNosArray
{
    
        ticketNos = ticketNosArray;
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ticketBackGround.png"]];
        [self setNeedsDisplay];
//         self.backgroundColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.9];
    
   
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSArray *linecolor = @[@"0.6",@"1",@"1",@"0.2"];
    //drawing lines in the view
    int j = 20;//(self.frame.size.width -270)/2;
    int x = j ,y = 50,i;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat red[4] = {((NSString*)[linecolor objectAtIndex:0]).floatValue, ((NSString*)[linecolor objectAtIndex:1]).floatValue, ((NSString*)[linecolor objectAtIndex:2]).floatValue, ((NSString*)[linecolor objectAtIndex:3]).floatValue};
    CGContextSetStrokeColor(context,red );
    
    CGContextSetLineWidth(context, 1);
    for (i = 0; i<10; i++) {
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x, y+105);
        x = x+30;
        
    }
    x = j;
    for (i = 0; i<4; i++) {
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x+270, y);
        y = y +35;
    }
    
    //draw the nos in the view
    x = j;
    y = 50;
    
    for (NSNumber *temp in ticketNos) {
        NSString *string;
        if ([temp intValue] == 0) {
            string = @"";
        }else {
            string = [NSString stringWithFormat:@"%@",temp];
        }
        
       
        CGRect viewRect = CGRectMake(x, y, 30, 35);
        UIFont* font = [UIFont systemFontOfSize:14];
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGSize size = [string sizeWithAttributes:attributes];
        float x_pos = (viewRect.size.width - size.width) / 2; 
        float y_pos = (viewRect.size.height - size.height) /2;
        [string drawAtPoint:CGPointMake(viewRect.origin.x + x_pos, viewRect.origin.y + y_pos) withAttributes:attributes];
        x = x + 30;
        if (x > 260 && y == 50 ) {
            x = j;
            y = y + 35;
        }
        else if(x > 260 && y == 85){
            x = j;
            y = y+35;
        }
    }
    CGContextStrokePath(context);
}


@end
