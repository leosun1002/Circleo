//
//  NIMSessionMessageContentView.m
//  NIMKit
//
//  Created by chris.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NIMSessionMessageContentView.h"
#import "NIMMessageModel.h"
#import "UIImage+NIMKit.h"
#import "NIMKitUIConfig.h"
#import "NIMGlobalMacro.h"

@interface NIMSessionMessageContentView()

@end

@implementation NIMSessionMessageContentView

- (instancetype)initSessionMessageContentView
{
    CGSize defaultBubbleSize = CGSizeMake(60, 35);
    if (self = [self initWithFrame:CGRectMake(0, 0, defaultBubbleSize.width, defaultBubbleSize.height)]) {
        
        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,defaultBubbleSize.width,defaultBubbleSize.height)];
        _bubbleImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _bubbleImageView.layer.masksToBounds = YES;
        _bubbleImageView.layer.cornerRadius = 8;
        [self addSubview:_bubbleImageView];
    }
    return self;
}

- (void)refresh:(NIMMessageModel*)data{
    _model = data;
    
    CGSize size = [self bubbleViewSize:data];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    [_bubbleImageView setImage:[self createImageWithColor:data.message.isOutgoingMsg?NIMKit_UIColorFromRGB(0x333333):NIMKit_UIColorFromRGB(0xECEAEE)]];
    [_bubbleImageView setImage:[self createImageWithColor:data.message.isOutgoingMsg?NIMKit_UIColorFromRGB(0x333333):NIMKit_UIColorFromRGB(0xECEAEE)]];
    //    [_bubbleImageView setHighlightedImage:[self chatBubbleImageForState:UIControlStateHighlighted outgoing:data.message.isOutgoingMsg]];
    //    [_bubbleImageView setImage:[self chatBubbleImageForState:UIControlStateNormal outgoing:data.message.isOutgoingMsg]];
    _bubbleImageView.frame = self.bounds;
    [self setNeedsLayout];
}


- (void)layoutSubviews{
    [super layoutSubviews];
}


- (void)updateProgress:(float)progress
{
    
}

- (void)onTouchDown:(id)sender
{
    
}

- (void)onTouchUpInside:(id)sender
{
    
}

- (void)onTouchUpOutside:(id)sender{
    
}


#pragma mark - Private
- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    
    NIMKitBubbleConfig *config = [[NIMKitUIConfig sharedConfig] bubbleConfig:self.model.message];
    return [config bubbleImage:state];
}


- (CGSize)bubbleViewSize:(NIMMessageModel *)model
{
    CGSize bubbleSize;
    CGSize contentSize  = model.contentSize;
    UIEdgeInsets insets = model.contentViewInsets;
    bubbleSize.width  = contentSize.width + insets.left + insets.right;
    bubbleSize.height = contentSize.height + insets.top + insets.bottom;
    return bubbleSize;
}


- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    _bubbleImageView.highlighted = highlighted;
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);

    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return theImage;

}
@end
