//
//  WelcomeView.h
//  Test
//
//  Created by wenbo li on 13-6-8.
//  Copyright (c) 2013年 wenbo li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeView : UIView<UIScrollViewDelegate>
{
    int width;
}
@property (strong, nonatomic) UIScrollView *page_scroll;
@property (strong, nonatomic) UIPageControl *page_control;
@property (nonatomic,strong) UIImageView *left;
@property (nonatomic,strong) UIImageView *right;
@property(strong,nonatomic) UIImageView* lastImageView;

@property(strong,nonatomic)void(^endEvent)(void);

-(id)initWithFrame:(CGRect)frame andPathArray:(NSArray*)array;

@end
