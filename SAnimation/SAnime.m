//
//  SAnime.m
//  SAnimation
//
//  Created by Sacchy on 2013/10/12.
//  Copyright (c) 2013年 Sacchy. All rights reserved.
//

#import "SAnime.h"
#import <QuartzCore/QuartzCore.h>

#define TABBAR_OFFSET 44.0f

@interface SAnime()
@property (nonatomic,retain) NSString *text;
@property (nonatomic) NSInteger dispLen;
@property (nonatomic) NSInteger times;
@end

@implementation SAnime
@synthesize text = _text;
@synthesize dispLen = _dispLen;
@synthesize times = _times;

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]) != nil)
    {
		_dispLen = kLenShort;
	}
	return self;
}

- (void)__show
{
	[UIView animateWithDuration:2.0f
					 animations:^{
						 self.alpha = 1.0f;
					 }
					 completion:^(BOOL finished) {
						 [self performSelector:@selector(__hide) withObject:nil afterDelay:_dispLen];
					 }];
}

- (void)__hide {
	[UIView animateWithDuration:0.8f
					 animations:^{
						 self.alpha = 0.0f;
					 }
					 completion:^(BOOL finished) {

                         if (_times == ENDLESSMODE) {
                             [[[self subviews] lastObject] removeFromSuperview];
                             [SAnime showWithText:_text dispTime:_dispLen animationTimes:ENDLESSMODE];
                         }
                         else if (--_times) {
                             [[[self subviews] lastObject] removeFromSuperview];
                             [SAnime showWithText:_text dispTime:_dispLen animationTimes:_times];
                         }
                         else {
                             [self removeFromSuperview];
#if !__has_feature(objc_arc)
                             [self release];
#endif
                         }
					 }];
}

/**
 * @brief 画面にアニメーション付きテキストを表示
 * @param text 表示させるテキスト
 * @param dispLen 表示時間
 * @param animeTimes アニメーション回数
 */
+ (void)showWithText:(NSString *)text dispTime:(SAnimeLength)dispLen animationTimes:(NSInteger)animeTimes;
{
    SAnime *anime = [SAnime __createWithText:text dispTime:dispLen animationTimes:animeTimes];
    anime.text = text;
	anime.dispLen = dispLen;
    anime.times = animeTimes;
	
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	[mainWindow addSubview:anime];
	
	[anime __flipViewAccordingToStatusBarOrientation];
	[anime __show];
}

+ (SAnime *)__createWithText:(NSString *)text dispTime:(SAnimeLength)dispLen animationTimes:(NSInteger)animeTimes
{
	float screenWidth, screenHeight;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown: {
			screenWidth = MIN(screenSize.width, screenSize.height);
			screenHeight = MAX(screenSize.width, screenSize.height);
            break;
		}
        case UIInterfaceOrientationLandscapeLeft: {
            screenWidth = MAX(screenSize.width, screenSize.height);
			screenHeight = MIN(screenSize.width, screenSize.height);
            break;
		}
        case UIInterfaceOrientationLandscapeRight: {
			screenWidth = MAX(screenSize.width, screenSize.height);
			screenHeight = MIN(screenSize.width, screenSize.height);
            break;
		}
        default: {
            screenWidth = MIN(screenSize.width, screenSize.height);
			screenHeight = MAX(screenSize.width, screenSize.height);
            break;
		}
    }
	
    // 表示させるラベル
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,screenHeight-40,screenWidth,40)];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
	label.textColor = RGB(0, 0, 0);
    label.center = CGPointMake(screenWidth*1.5, screenHeight-25);

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:dispLen];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    label.center = CGPointMake(-screenWidth, screenHeight-25);
    [UIView commitAnimations];
    
#if !__has_feature(objc_arc)
	[label release];
#endif
    
	SAnime *anime = [[SAnime alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
	[anime addSubview:label];
	
	anime.alpha = 0.0f;
	return anime;
}

- (void)__flipViewAccordingToStatusBarOrientation
{
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = 0.0;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	float x, y;
	float screenWidth, screenHeight;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown: {
            angle = M_PI;
			screenWidth = MIN(screenSize.width, screenSize.height);
			screenHeight = MAX(screenSize.width, screenSize.height);
			x = floor((screenWidth - self.bounds.size.width) / 2.0f);
			y = 15.0f + TABBAR_OFFSET;
            break;
		}
        case UIInterfaceOrientationLandscapeLeft: {
            angle = - M_PI / 2.0f;
			screenWidth = MAX(screenSize.width, screenSize.height);
			screenHeight = MIN(screenSize.width, screenSize.height);
			x = screenHeight - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
			y = floor((screenWidth - self.bounds.size.width) / 2.0f);
            break;
		}
        case UIInterfaceOrientationLandscapeRight: {
            angle = M_PI / 2.0f;
			screenWidth = MAX(screenSize.width, screenSize.height);
			screenHeight = MIN(screenSize.width, screenSize.height);
			x = 15.0f + TABBAR_OFFSET;
			y = floor((screenWidth - self.bounds.size.width) / 2.0f);
            break;
		}
        default: {
            angle = 0.0;
			screenWidth = MIN(screenSize.width, screenSize.height);
			screenHeight = MAX(screenSize.width, screenSize.height);
			x = floor((screenWidth - self.bounds.size.width) / 2.0f);
			y = screenHeight - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
            break;
		}
    }
    
    self.transform = CGAffineTransformMakeRotation(angle);
    
	CGRect f = self.frame;
	f.origin = CGPointMake(x, y);
	self.frame = f;
}
@end
