//
//  MainViewController.m
//  Test
//
//  Created by wenbo li on 13-6-8.
//  Copyright (c) 2013年 wenbo li. All rights reserved.
//

#import "MainViewController.h"
#import "CAPageView.h"

@interface MainViewController ()

@end

@implementation MainViewController

//@synthesize bt1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    NSMutableArray* pagearray = [NSMutableArray arrayWithCapacity:5];
    for (int i = 1 ; i <= 5; i++) {
        [pagearray addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"page_%d",i] ofType:@"jpg"]];
    }
    
    CAPageView* page = [[CAPageView alloc]initWithPathStringArray:pagearray andFrame:CGRectMake(0, 50, 320, 200)];
    [self.view addSubview:page];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
