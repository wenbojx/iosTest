//
//  WelcomeViewController.m
//  WelPage
//
//  Created by wenbo li on 13-6-9.
//  Copyright (c) 2013年 wenbo li. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize page_scroll;
@synthesize page_control;
@synthesize lastImageView;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        self.page_scroll = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-36, frame.size.width, 36)];
        
        [self addSubview:pageControl];
        self.page_control = pageControl;
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andPathArray:(NSArray *)array{
    self = [self initWithFrame:frame];
    if (self) {
        int count = array.count;
        self.page_control.numberOfPages = count;
        width = frame.size.width;
        int height = frame.size.height;
        
        for (int i=0; i<count; i++) {
            NSString *path = [array objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] init];
            //视图对象上的按钮可以用
            imageView.userInteractionEnabled = YES;
            
            imageView.frame = CGRectMake(i*width, 0, width, height);
            imageView.image = [UIImage imageWithContentsOfFile:path];
            imageView.tag = i;
            if(i+1==count){
                UIButton *startBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                startBt.userInteractionEnabled = YES;
                startBt.frame = CGRectMake(width/2-50, height-100, 100, 30);
                [startBt setTitle:@"进入" forState:UIControlStateNormal];
                [startBt addTarget:self action:@selector(btPressed:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:startBt];
                self.lastImageView = imageView;
            }
            [page_scroll addSubview:imageView];
        }
        page_scroll.contentSize = CGSizeMake(count*width, height);
        page_scroll.contentOffset = CGPointMake(0,0);
    }
    return self;
}

-(void)btPressed:(id)sender{
    NSLog(@"asdfsdfdf");
    self.endEvent();
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offsetx = scrollView.contentOffset.x;
    int pageindex = offsetx/width;
    self.page_control.currentPage = pageindex;
}

-(void)dealloc{
    [page_control release];
    [page_scroll release];
    [lastImageView release];
    [super release];
}


@end
