//
//  PdfCreator.m
//  Housie
//
//  Created by SREEHARSHA on 14/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "PdfCreator.h"

@implementation PdfCreator
{
    CGContextRef pdfContext;
    CFMutableDictionaryRef pageDictionary;
}

-(void)getArrayOfTickets:(NSArray*)all
{
    allTickets = all;
}

-(void)MyCreatePDFFile

{
    
    
    CGRect pageRect = CGRectMake(0, 0, 612 ,792);
    CFStringRef filePath;
    CFURLRef url;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    pageDictionary = NULL;
    const char* path = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Tickets.pdf"] UTF8String];
    filePath = CFStringCreateWithCString (NULL, path ,
                                          kCFStringEncodingUTF8);
    
    url = CFURLCreateWithFileSystemPath (NULL, filePath, kCFURLPOSIXPathStyle, 0);
    
    CFRelease (filePath);
    myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks); // 4
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, @"Tickets To Print");
    //CFDictionarySetValue(myDictionary, kCGPDFContextCreator, givenDetails.name);
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary); // 5
    CFRelease(myDictionary);
    CFRelease(url);
    pageDictionary = CFDictionaryCreateMutable(NULL, 0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks); // 6
    boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    
    CGPDFContextBeginPage (pdfContext, pageDictionary);
    [self printTickets];

    CGPDFContextEndPage (pdfContext);
    
        
    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    CFRelease(boxData);
}


-(void)printTickets
{
    NSArray *ticketNos;
    int x, y, labelx,labely,nox,noy,i,ticketsIndex = 1;
    
    //setting the default value of x
    x = 20;
    y = 720;
    for (ticketNos in allTickets) {
        int defaultx = x,defaulty = y;
        CGContextSaveGState(pdfContext);
        CGContextSelectFont (pdfContext,
                             "Arial-BoldMT",
                             16,
                             kCGEncodingMacRoman);
        NSString *note =[NSString stringWithFormat:@"Ticket No: %d",ticketsIndex];
        int length = [note  length];
        labelx = x+87;
        labely = y +10;
        const char* note1 = [note UTF8String];
        
        CGContextShowTextAtPoint (pdfContext, labelx, labely,note1, length);
        
        CGContextSelectFont (pdfContext,
                             "ArialMT",
                             14,
                             kCGEncodingMacRoman);
        CGContextSetCharacterSpacing (pdfContext,0);
        
        CGContextSetTextDrawingMode (pdfContext
                                     , kCGTextFill);
        nox = x + 14;
        noy = y - 24;
        int index = 0;
        for (NSNumber* num in ticketNos) {
            NSString *no;
            if ([num intValue] == 0) {
                no = @" ";
            }else{
                no = [NSString stringWithFormat:@"%@",num];
                if (no.length == 1) {
                    no = [no stringByAppendingString:@" "];
                }
            }
            length = no.length;
            const char* no1 = [no UTF8String];
            CGContextShowTextAtPoint(pdfContext, nox, noy, no1, length);
            if (index == 8 || index == 17 ) {
                nox = x -16;
                noy -= 35;
            }
            
            
            nox += 29;
            
            index++;
            
        }
        
        
        for (i = 0; i<10; i++) {
            CGContextMoveToPoint(pdfContext, x, y);
            CGContextAddLineToPoint(pdfContext, x, y-105);
            x = x+30;
            
        }
        x = defaultx;
        for (i = 0; i<4; i++) {
            CGContextMoveToPoint(pdfContext, x, y);
            CGContextAddLineToPoint(pdfContext, x+270, y);
            y = y -35;
        }
        
        CGContextDrawPath(pdfContext, kCGPathEOFillStroke);
        CGContextRestoreGState(pdfContext);
        x = defaultx;
        y = defaulty;
        if (ticketsIndex % 2 != 0) {
            x = x + 300;
        
    }
        else
        {
            y = y - 160;
            x = 20;
        }
        if (ticketsIndex %8 == 0 ) {
            CGPDFContextEndPage (pdfContext);

            CGPDFContextBeginPage (pdfContext, pageDictionary);
            x = 20;
            y = 720;

                       
        }
        printf(" x = %d, y = %d, index = %d", x, y, ticketsIndex);
        ticketsIndex ++;
        

    }
}


@end
