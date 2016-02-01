//
//  Utilities.h
//  Housie
//
//  Created by Harsha on 01/02/16.
//  Copyright © 2016 SREEHARSHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+ (void) gradientWithStart:(UIColor *)startColor End:(UIColor *)endColor Alpha:(float)alpha  forView:(UIView*) view;
@end
