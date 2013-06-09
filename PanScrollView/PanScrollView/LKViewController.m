//
//  LKViewController.m
//  PanScrollView
//
//  Created by upin on 13-5-16.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import "LKViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LKViewController ()
{
    //是否从scrollview 中转换成拖动
    BOOL isPaning;
    BOOL isLeftShow,isLeftDragging;
    BOOL isRightShow,isRightDragging;
    
}
@property(strong,nonatomic)UIImageView* maskView;
@end

@implementation LKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]init];
    [pan addTarget:self action:@selector(handlePan:)];
    
    [self.view_content addGestureRecognizer:pan];
    
    self.view_banner.frame = CGRectMake(0,50, 320, 150);
    
    //
    UIImageView* img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img1"]];
    img1.frame = CGRectMake(0, 0, 320, 150);
    [self.view_banner addSubview:img1];
    
    UIImageView* img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img2"]];
    img1.frame = CGRectMake(320, 0, 320,150);
    [self.view_banner addSubview:img2];
    
    UIImageView* img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img1"]];
    img3.frame = CGRectMake(640, 0, 320, 150);
    [self.view_banner addSubview:img3];
    
    
    self.view_banner.pagingEnabled = YES;
    self.view_banner.contentSize = CGSizeMake(960, 150);
    [self.view_banner.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    self.maskView = [[UIImageView alloc]initWithFrame:self.view_banner.frame];
    self.maskView.hidden = YES;
    [self.view_content addSubview:self.maskView];
}
-(void)showMask
{
    UIGraphicsBeginImageContext(self.view_banner.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view_banner.layer renderInContext:context];
    self.maskView.image  =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.maskView.hidden = NO;
}
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    if(self.view_banner.contentOffset.x < 0)
    {
        isPaning = YES;
        isLeftDragging = YES;
        [self showMask];
    }
    // 因为 我知道 我宽是  960 所以 就没去算了
    else if(self.view_banner.contentOffset.x> 640)
    {
        isPaning = YES;
        isRightDragging = YES;
        [self showMask];
    }
    if(isPaning)
    {
        [self handlePan:panParam];
    }
}

-(void)handlePan:(UIPanGestureRecognizer*) panParam
{
    if(isLeftShow)
    {
        isLeftDragging = YES;
    }
    else if(isRightShow)
    {
        isRightDragging = YES;
    }
    else if(!isLeftDragging&&!isRightDragging)
    {
        float v_X = [panParam velocityInView:panParam.view].x;
        if(v_X>0)
        {
            isLeftDragging = YES;
        }
        else
        {
            isRightDragging = YES;
        }
    }
    CGPoint point = [panParam translationInView:panParam.view];
    [panParam setTranslation:CGPointZero inView:panParam.view];
    
    float contentX = self.view_content.frame.origin.x;
    if(isLeftDragging)
    {
        contentX +=point.x;
        if(contentX > 250)
        {
            contentX = 250;
        }
        else if(contentX < 0)
        {
            contentX = 0;
        }
    }
    else if(isRightDragging)
    {
        contentX += point.x;
        if(contentX < -250)
        {
            contentX = -250;
        }
        else if(contentX > 0)
        {
            contentX = 0;
        }
    }
    
    CGRect frame = self.view_content.frame;
    frame.origin.x = contentX;
    self.view_content.frame= frame;
    
    if(panParam.state == UIGestureRecognizerStateCancelled || panParam.state == UIGestureRecognizerStateEnded)
    {
        float v_X = [panParam velocityInView:panParam.view].x;
        float diff = 0;
        float finishedX = 0;
        if(isLeftDragging)
        {
            if(v_X > 0)
            {
                diff = 250 - contentX;
                finishedX = 250;
                self.view_banner.scrollEnabled = NO;
                   isLeftShow = YES;
            }
            else
            {
                diff = contentX;
                finishedX = 0;
                self.view_banner.scrollEnabled = YES;
                isLeftShow = isRightShow = NO;
             
            }
        }
        else if(isRightDragging)
        {
            if(v_X > 0)
            {
                diff = contentX;
                finishedX = 0;
                self.view_banner.scrollEnabled = YES;
                isLeftShow = isRightShow = NO;
            }
            else
            {
                diff = contentX + 250;
                finishedX = -250;
                self.view_banner.scrollEnabled = NO;
                isRightShow = YES;
            }
        }
        //防止出现 抖动
        NSTimeInterval duration = MIN(0.3f,ABS(diff/v_X));
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             CGRect frame = self.view_content.frame;
                             frame.origin.x = finishedX;
                             self.view_content.frame= frame;
                         }
                         completion:^(BOOL finished) {
                             isPaning = NO;
                             isLeftDragging = NO;
                             isRightDragging = NO;
                             self.maskView.image = nil;
                             self.maskView.hidden = YES;
                         }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
