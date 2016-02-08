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

+ (void) gradientforViewcontrollerView:(UIView*) view{
    
    [self gradientWithStart:[UIColor colorWithRed:0.282 green:0.922 blue:0.729 alpha:1.000] End:[UIColor colorWithRed:0.000 green:0.749 blue:0.976 alpha:1.000] Alpha:1.0 forView:view];
    
}

+ (void) setBackGroundColorForView:(UIView*)view{
    view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleRadial withFrame:view.bounds andColors:@[[UIColor colorWithRed:0.282 green:0.922 blue:0.729 alpha:1.000], [UIColor colorWithRed:0.000 green:0.749 blue:0.976 alpha:1.000]]];
}
@end
