//
//  ViewController.m
//  Housie
//
//  Created by SREEHARSHA on 04/10/12.
//  Copyright (c) 2012 SREEHARSHA. All rights reserved.
//

#import "ViewController.h"
#import "TicketsViewController.h"
#import "CallerViewController.h"
#import "AppDelegate.h"

#define GARDIANTSTYLE UIGradientStyleTopToBottom
@interface ViewController ()

@end

@implementation ViewController

- (void)addLabelToView:(UIView *)view withText:(NSString*)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont systemFontOfSize:51];
    label.textColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:view.backgroundColor isFlat:YES];
    
    [view addSubview:label];
    
    
    view.layer.cornerRadius = view.frame.size.width/2;
    view.alpha = 0.9;
    
    [self.view addSubview:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [Utilities gradientforViewcontrollerView:self.view];
    self.navigationController.hidesNavigationBarHairline = YES;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(-100,100, 75, 75)];
    view.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view.bounds andColors:@[[UIColor colorWithRed:0.996 green:0.831 blue:0.231 alpha:1.000], [UIColor colorWithRed:0.996 green:0.773 blue:0.039 alpha:1.000]]];
    [self addLabelToView:view withText:@"H"];
    //[self addAnimationToView:view];
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(425, 75, 75, 75)];
    view2.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view2.bounds andColors:@[[UIColor colorWithRed:0.906 green:0.173 blue:0.655 alpha:1.000], [UIColor colorWithRed:0.714 green:0.094 blue:0.984 alpha:1.000]]];
   [self addLabelToView:view2 withText:@"U"];
    
    // [self addAnimationToView:view2];
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(150, -100, 75, 75)];
    view1.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view1.bounds andColors:@[[UIColor colorWithRed:0.984 green:0.271 blue:0.176 alpha:1.000], [UIColor colorWithRed:0.984 green:0.008 blue:0.329 alpha:1.000]]];
    [self addLabelToView:view1 withText:@"O"];
    
       //[self addAnimationToView:view];
   
    
    // [self addAnimationToView:view2];
    UIView * view5 = [[UIView alloc] initWithFrame:CGRectMake(150, -100, 75, 75)];
    view5.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view5.bounds andColors:@[[UIColor colorWithRed:0.984 green:0.271 blue:0.176 alpha:1.000], [UIColor colorWithRed:0.984 green:0.008 blue:0.329 alpha:1.000]]];
    [self addLabelToView:view5 withText:@"I"];
    UIView * view4 = [[UIView alloc] initWithFrame:CGRectMake(-100,100, 75, 75)];
    view4.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view4.bounds andColors:@[[UIColor colorWithRed:0.996 green:0.831 blue:0.231 alpha:1.000], [UIColor colorWithRed:0.996 green:0.773 blue:0.039 alpha:1.000]]];
    [self addLabelToView:view4 withText:@"S"];

    UIView * view6 = [[UIView alloc] initWithFrame:CGRectMake(425, 75, 75, 75)];
    view6.backgroundColor = [UIColor colorWithGradientStyle:GARDIANTSTYLE withFrame:view6.bounds andColors:@[[UIColor colorWithRed:0.906 green:0.173 blue:0.655 alpha:1.000], [UIColor colorWithRed:0.714 green:0.094 blue:0.984 alpha:1.000]]];
    [self addLabelToView:view6 withText:@"E"];
    
    [self.view addSubview:view1];
    [UIView animateWithDuration:2.5 animations:^{
        view.frame = CGRectMake(0, 100, 75, 75);
        view1.frame = CGRectMake(50, 100, 75, 75);
        view2.frame = CGRectMake(100, 100, 75, 75);
        view4.frame = CGRectMake(150, 100, 75, 75);
        view5.frame = CGRectMake(200, 100, 75, 75);
        view6.frame = CGRectMake(250, 100, 75, 75);

    }completion:^ (BOOL finished){
        [self addAnimationToView:view];
        [self addAnimationToView:view1];
        [self addAnimationToView:view2];
        [self addAnimationToView:view4];
        [self addAnimationToView:view5];
        [self addAnimationToView:view6];
    }];
}


-(void) viewWillAppear:(BOOL)animated
{
    //hide navigationbar
    self.navigationController.navigationBarHidden = YES;

}

-(void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)addAnimationToView:(UIView*)view
{
    view.layer.cornerRadius = view.frame.size.width/2;
    view.alpha = 0.9;
    //create an animation to follow a circular path
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //interpolate the movement to be more smooth
    pathAnimation.calculationMode = kCAAnimationPaced;
    //apply transformation at the end of animation (not really needed since it runs forever)
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //run forever
    pathAnimation.repeatCount = INFINITY;
    //no ease in/out to have the same speed along the path
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    
    //The circle to follow will be inside the circleContainer frame.
    //it should be a frame around the center of your view to animate.
    //do not make it to large, a width/height of 3-4 will be enough.
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(view.frame, 23, 23);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    //add the path to the animation
    pathAnimation.path = curvedPath;
    //release path
    CGPathRelease(curvedPath);
    //add animation to the view's layer
    [view.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    
    //create an animation to scale the width of the view
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    //set the duration
    scaleX.duration = 1;
    //it starts from scale factor 1, scales to 1.05 and back to 1
    scaleX.values = @[@1.0, @1.05, @1.0];
    //time percentage when the values above will be reached.
    //i.e. 1.05 will be reached just as half the duration has passed.
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    //keep repeating
    scaleX.repeatCount = INFINITY;
    //play animation backwards on repeat (not really needed since it scales back to 1)
    scaleX.autoreverses = YES;
    //ease in/out animation for more natural look
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //add the animation to the view's layer
    [view.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    //create the height-scale animation just like the width one above
    //but slightly increased duration so they will not animate synchronously
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.05, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
}

- (IBAction)onlyCaller:(id)sender {
    CallerViewController *caller =[[CallerViewController alloc] init];
    [caller onlyCaller];
    [self.navigationController pushViewController:caller animated:YES];
}

@end
