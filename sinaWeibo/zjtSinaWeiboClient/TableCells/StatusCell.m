//
//  StatusCell.m
//  zjtSinaWeiboClient
//
//  Created by jianting zhu on 12-1-5.
//  Copyright (c) 2012年 Dunbar Science & Technology. All rights reserved.
//

#import "StatusCell.h"

#define IMAGE_VIEW_HEIGHT 80.0f

@implementation StatusCell
@synthesize retwitterBgImage;
@synthesize retwitterContentTF;
@synthesize retwitterContentImage;
@synthesize countLB;
@synthesize avatarImage;
@synthesize contentTF;
@synthesize userNameLB;
@synthesize bgImage;
@synthesize contentImage;
@synthesize retwitterMainV;
@synthesize delegate;
@synthesize cellIndexPath;
@synthesize fromLB;
@synthesize timeLB;

//
-(void)setupCell:(Status *)status avatarImageData:(NSData *)avatarData contentImageData:(NSData *)imageData
{
    self.contentTF.text = status.text;
    self.userNameLB.text = status.user.screenName;
    self.avatarImage.image = [UIImage imageWithData:avatarData];
    countLB.text = [NSString stringWithFormat:@"评论:%d 转发:%d",status.commentsCount,status.retweetsCount];
    fromLB.text = [NSString stringWithFormat:@"来自:%@",status.source];
    timeLB.text = status.timestamp;
    
    Status  *retwitterStatus    = status.retweetedStatus;
    
    //有转发
    if (retwitterStatus && ![retwitterStatus isEqual:[NSNull null]]) 
    {
        self.retwitterMainV.hidden = NO;
        self.retwitterContentTF.text = [NSString stringWithFormat:@"%@:%@",status.retweetedStatus.user.screenName,retwitterStatus.text];
        self.contentImage.hidden = YES;
        
        if (![imageData isEqual:[NSNull null]]) 
        {
            self.retwitterContentImage.image = [UIImage imageWithData:imageData];
        }
        
        NSString *url = status.retweetedStatus.thumbnailPic;
        self.retwitterContentImage.hidden = url != nil && [url length] != 0 ? NO : YES;
        [self setTFHeightWithImage:NO 
                haveRetwitterImage:url != nil && [url length] != 0 ? YES : NO];//计算cell的高度，以及背景图的处理
    }
    
    //无转发
    else
    {
        self.retwitterMainV.hidden = YES;
        if (![imageData isEqual:[NSNull null]]) {
            self.contentImage.image = [UIImage imageWithData:imageData];
        }
        
        NSString *url = status.thumbnailPic;
        self.contentImage.hidden = url != nil && [url length] != 0 ? NO : YES;
        [self setTFHeightWithImage:url != nil && [url length] != 0 ? YES : NO 
                haveRetwitterImage:NO];//计算cell的高度，以及背景图的处理
    }
}

//计算cell的高度，以及背景图的处理
-(CGFloat)setTFHeightWithImage:(BOOL)hasImage haveRetwitterImage:(BOOL)haveRetwitterImage
{
    [contentTF layoutIfNeeded];
    
    //博文Text
    CGRect frame = contentTF.frame;
    frame.size = contentTF.contentSize;
    contentTF.frame = frame;
    
    //转发博文Text
    frame = retwitterContentTF.frame;
    frame.size = retwitterContentTF.contentSize;
    retwitterContentTF.frame = frame;
    
    
    //转发的主View
    frame = retwitterMainV.frame;
    
    if (haveRetwitterImage) frame.size.height = retwitterContentTF.frame.size.height + IMAGE_VIEW_HEIGHT + 15;
    else frame.size.height = retwitterContentTF.frame.size.height + 15;
    
    if(hasImage) frame.origin.y = contentTF.frame.size.height + contentTF.frame.origin.y + IMAGE_VIEW_HEIGHT;
    else frame.origin.y = contentTF.frame.size.height + contentTF.frame.origin.y;
    
    retwitterMainV.frame = frame;
    
    
    //转发的图片
    frame = retwitterContentImage.frame;
    frame.origin.y = retwitterContentTF.frame.size.height;
    frame.size.height = IMAGE_VIEW_HEIGHT;
    retwitterContentImage.frame = frame;
    
    //正文的图片
    frame = contentImage.frame;
    frame.origin.y = contentTF.frame.size.height + contentTF.frame.origin.y - 5.0f;
    frame.size.height = IMAGE_VIEW_HEIGHT;
    contentImage.frame = frame;
    
    //背景设置
    bgImage.image = [[UIImage imageNamed:@"table_header_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    retwitterBgImage.image = [[UIImage imageNamed:@"timeline_rt_border_t.png"] stretchableImageWithLeftCapWidth:130 topCapHeight:7];
    
    return contentTF.contentSize.height;
}

-(IBAction)tapDetected:(id)sender
{
    UITapGestureRecognizer*tap = (UITapGestureRecognizer*)sender;
    
    UIImageView *imageView = (UIImageView*)tap.view;
    if ([imageView isEqual:contentImage]) {
        if ([delegate respondsToSelector:@selector(cellImageDidTaped:image:)]) 
        {
            [delegate cellImageDidTaped:self image:contentImage.image];
        }
    }
    else if ([imageView isEqual:retwitterContentImage])
    {
        if ([delegate respondsToSelector:@selector(cellImageDidTaped:image:)])
        {
            [delegate cellImageDidTaped:self image:retwitterContentImage.image];
        }
    }
}

- (void)dealloc {
    [avatarImage release];
    [contentTF release];
    [userNameLB release];
    [bgImage release];
    [contentImage release];
    [retwitterMainV release];
    [retwitterBgImage release];
    [retwitterContentTF release];
    [retwitterContentImage release];
    [cellIndexPath release];
    [countLB release];
    [fromLB release];
    [timeLB release];
    [super dealloc];
}
@end
