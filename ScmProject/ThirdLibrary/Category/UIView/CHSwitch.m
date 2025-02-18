//
// 文 件 名:CHSwitch.m
//
// 版权所有:Copyright © 2018 lelight. All rights reserved.
// 创 建 者:lelight
// 创建日期:2018/12/19.
// 文档说明:
// 修 改 人:
// 修改日期:
//

#import "CHSwitch.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kAnimateDuration = 0.3f;
static const CGFloat kHorizontalAdjustment = 0.f;
static const CGFloat kRectShapeCornerRadius = 4.0f;
static const CGFloat kThumbShadowOpacity = 0.3f;
static const CGFloat kThumbShadowRadius = 1.f;
static const CGFloat kSwitchBorderWidth = 1.75f;

@interface CHSwitch ()

@property (nonatomic, strong) UIView *onBackgroundView;
@property (nonatomic, strong) UIView *offBackgroundView;
@property (nonatomic, strong) UIImageView *thumbView;

@end

@implementation CHSwitch

@synthesize onBackgroundView = _onBackgroundView;
@synthesize offBackgroundView = _offBackgroundView;
@synthesize thumbView = _thumbView;
@synthesize on = _on;
@synthesize shape = _shape;
@synthesize onTintColor = _onTintColor;
@synthesize tintColor = _tintColor;
@synthesize thumbTintColor = _thumbTintColor;
@synthesize shadow = _shadow;
@synthesize onTintBorderColor = _onTintBorderColor;
@synthesize tintBorderColor = _tintBorderColor;

#pragma mark - View
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI {
    self.shape = CHSwitchShapeOval;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Background view for ON
    self.onBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - 15/2, self.frame.size.width, 15)];
    [self.onBackgroundView setBackgroundColor:[UIColor colorWithRed:(19.0f/255.0f) green:(121.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f]];
    [self.onBackgroundView.layer setCornerRadius:7.5];
    [self.onBackgroundView.layer setShouldRasterize:YES];
    [self.onBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.onBackgroundView];
    
    // Background view for OFF
    self.offBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - 15/2, self.frame.size.width, 15)];
    [self.offBackgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.offBackgroundView.layer setCornerRadius:7.5];
    [self.offBackgroundView.layer setShouldRasterize:YES];
    [self.offBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.offBackgroundView];
    
    // Round switch view
    self.thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height-kHorizontalAdjustment, self.frame.size.height-kHorizontalAdjustment)];
//    [self.thumbView setBackgroundColor:[UIColor redColor]];
    self.thumbView.contentMode = UIViewContentModeScaleToFill;
    self.thumbView.image = [UIImage imageNamed:@"open_circle"];
    [self.thumbView setUserInteractionEnabled:YES];
    [self addSubview:self.thumbView];
    self.shadow = YES;
    
    // Default to OFF position
    [self.thumbView setCenter:CGPointMake(self.thumbView.frame.size.width/2, self.frame.size.height/2)];
    
    // Handle Thumb Tap Gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
           action:@selector(handleSwitchTap:)];
    [tapGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:tapGestureRecognizer];
    
    // Handle Background Tap Gesture
    UITapGestureRecognizer *tapBgGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBgTap:)];
    [tapBgGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:tapBgGestureRecognizer];
    
    // Handle Thumb Pan Gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:panGestureRecognizer];
    
    [self setOn:NO];
}

#pragma mark - Accessor
- (BOOL)isOn {
    return _on;
}

- (void)setOn:(BOOL)on {
    if (_on != on)
        _on = on;
    
    if (_on) {
        [self.onBackgroundView setAlpha:1.0];
        [self.offBackgroundView setAlpha:0.0];

        self.thumbView.center = CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width + kHorizontalAdjustment)/2 + 10, self.thumbView.center.y);
    }
    else {
        [self.onBackgroundView setAlpha:0.0];
        [self.offBackgroundView setAlpha:1.0];

        self.thumbView.center = CGPointMake((self.thumbView.frame.size.width+kHorizontalAdjustment)/2 - 10, self.thumbView.center.y);
    }
}

- (void)setOnTintColor:(UIColor *)color
{
    if (_onTintColor != color)
        _onTintColor = color;
    
    [self.onBackgroundView setBackgroundColor:color];
}

- (void)setOnTintBorderColor:(UIColor *)color
{
    if (_onTintBorderColor != color)
        _onTintBorderColor = color;
    
    [self.onBackgroundView.layer setBorderColor:color.CGColor];
    
    if (color)
        [self.onBackgroundView.layer setBorderWidth:kSwitchBorderWidth];
    else
        [self.onBackgroundView.layer setBorderWidth:0.0];
}

- (void)setTintColor:(UIColor *)color
{
    if (_tintColor != color)
        _tintColor = color;
    
    [self.offBackgroundView setBackgroundColor:color];
}

- (void)setTintBorderColor:(UIColor *)color
{
    if (_tintBorderColor != color)
        _tintBorderColor = color;
    
    [self.offBackgroundView.layer setBorderColor:color.CGColor];
    
    if (color)
        [self.offBackgroundView.layer setBorderWidth:kSwitchBorderWidth];
    else
        [self.offBackgroundView.layer setBorderWidth:0.0];
}

- (void)setThumbTintColor:(UIColor *)color
{
    if (_thumbTintColor != color)
        _thumbTintColor = color;
    
    [self.thumbView setBackgroundColor:color];
}

- (void)setShape:(CHSwitchShape)newShape
{
    if (_shape != newShape)
        _shape = newShape;
    
    if (newShape == CHSwitchShapeOval)
    {
//        [self.onBackgroundView.layer setCornerRadius:7.5];
//        [self.offBackgroundView.layer setCornerRadius:7.5];
        [self.thumbView.layer setCornerRadius:(self.frame.size.height-kHorizontalAdjustment)/2];
    }
    else if (newShape == CHSwitchShapeRectangle)
    {
        [self.onBackgroundView.layer setCornerRadius:kRectShapeCornerRadius];
        [self.offBackgroundView.layer setCornerRadius:kRectShapeCornerRadius];
        [self.thumbView.layer setCornerRadius:kRectShapeCornerRadius];
    }
    else if (newShape == CHSwitchShapeRectangleNoCorner)
    {
        [self.onBackgroundView.layer setCornerRadius:0];
        [self.offBackgroundView.layer setCornerRadius:0];
        [self.thumbView.layer setCornerRadius:0];
    }
}

- (void)setShadow:(BOOL)showShadow
{
    if (_shadow != showShadow)
        _shadow = showShadow;
    
    if (showShadow)
    {
        [self.thumbView.layer setShadowOffset:CGSizeMake(2, 2)];
        [self.thumbView.layer setShadowRadius:kThumbShadowRadius];
        [self.thumbView.layer setShadowOpacity:kThumbShadowOpacity];
    }
    else
    {
        [self.thumbView.layer setShadowRadius:0.0];
        [self.thumbView.layer setShadowOpacity:0.0];
    }
}

#pragma mark - Animation
- (void)animateToDestination:(CGPoint)centerPoint withDuration:(CGFloat)duration switch:(BOOL)on
{
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.thumbView.center = centerPoint;
        if (on) {
            [self.onBackgroundView setAlpha:1.0];
            self.thumbView.centerX = centerPoint.x + 10;
        }else{
            [self.onBackgroundView setAlpha:0.0];
            self.thumbView.centerX = centerPoint.x - 10;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self updateSwitch:on];
        }
    }];
    
    [UIView animateWithDuration:duration
                          delay:0.075f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        if (!on){
            [self.offBackgroundView setAlpha:1.0];
        }else{
            [self.offBackgroundView setAlpha:0.0];
        }
    } completion:^(BOOL finished) {
    }];
}



#pragma mark - Gesture Recognizers
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.thumbView];
    
    // Check the new center to see if within the boud
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                    recognizer.view.center.y);
    if (newCenter.x < (recognizer.view.frame.size.width+kHorizontalAdjustment)/2 || newCenter.x > self.onBackgroundView.frame.size.width-(recognizer.view.frame.size.width+kHorizontalAdjustment)/2)
    {
        // New center is Out of bound. Animate to left or right position
        if(recognizer.state == UIGestureRecognizerStateBegan ||
           recognizer.state == UIGestureRecognizerStateChanged)
        {
            CGPoint velocity = [recognizer velocityInView:self.thumbView];
            
            if (velocity.x >= 0)
            {
                // Animate move to right
                [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
            }
            else
            {
                // Animate move to left
                [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
            }
            
        }
        
        return;
    }
    
    // Only allow vertical pan
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.thumbView];
    
    CGPoint velocity = [recognizer velocityInView:self.thumbView];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (velocity.x >= 0)
        {
            if (recognizer.view.center.x < self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+kHorizontalAdjustment)/2)
            {
                // Animate move to right
                [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
            }
        }
        else
        {
            // Animate move to left
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
        }
    }
}

- (void)handleSwitchTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            // Animate move to left
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
        }
        else
        {
            // Animate move to right
            [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+kHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
        }
    }
}

- (void)handleBgTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            // Animate move to left
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+kHorizontalAdjustment)/2, self.thumbView.center.y) withDuration:kAnimateDuration switch:NO];
        }
        else
        {
            // Animate move to right
            [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+kHorizontalAdjustment)/2, self.thumbView.center.y) withDuration:kAnimateDuration switch:YES];
        }
    }
}

#pragma mark -
- (void)updateSwitch:(BOOL)on
{
    if (_on != on)
        _on = on;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
