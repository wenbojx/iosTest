//
//  WelcomeViewController.h
//  WelPage
//
//  Created by wenbo li on 13-6-9.
//  Copyright (c) 2013年 wenbo li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIView<UIScrollViewDelegate>{
    int width;
}

@property(strong,nonatomic) UIScrollView *page_scroll;
@property(strong, nonatomic) UIPageControl *page_control;

@property(strong, nonatomic)UIImageView *lastImageView;

@property(strong,nonatomic)void(^endEvent)(void);


-(id)initWithFrame:(CGRect)frame andPathArray:(NSArray *)array;

@end
