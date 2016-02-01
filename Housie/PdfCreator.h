//
//  PdfCreator.h
//  Housie
//
//  Created by SREEHARSHA on 14/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PdfCreator : NSObject
{
    NSArray *allTickets;
}
-(void)MyCreatePDFFile;
-(void)getArrayOfTickets:(NSArray*)all;
@end
