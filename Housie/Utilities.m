//
//  Utilities.m
//  Housie
//
//  Created by Harsha on 01/02/16.
//  Copyright © 2016 SREEHARSHA. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
+ (void) gradientWithStart:(UIColor *)startColor End:(UIColor *)endColor Alpha:(float)alpha  forView:(UIView*) view{
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)startColor.CGColor, endColor.CGColor, nil];
    
    //    NSNumber *stopOne = [NSNumber numberWithFloat:-0.2];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0];
    
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.frame = view.bounds;
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    
    [headerLayer setStartPoint:CGPointMake(0, 0)];
    [headerLayer setEndPoint:CGPointMake(1.0, 1.0)];
    
    
    [view.layer insertSublayer:headerLayer atIndex:0];
    
}

+ (void) gradientWithStart:(UIColor *)startColor End:(UIColor *)endColor Alpha:(float)alpha  forLabel:(UILabel*) label{
    NSArray *colors =  [NSArray arrayWithObjects:(id)startColor.CGColor, endColor.CGColor, nil];
    
    //    NSNumber *stopOne = [NSNumber numberWithFloat:-0.2];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0];
    
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.frame = label.bounds;
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    
    [headerLayer setStartPoint:CGPointMake(0, 0)];
    [headerLayer setEndPoint:CGPointMake(1.0, 1.0)];
    
    
    [label.layer insertSublayer:headerLayer atIndex:0];
}
@end
