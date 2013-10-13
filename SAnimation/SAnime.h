//
//  SAnime.h
//  SAnimation
//
//  Created by Sacchy on 2013/10/12.
//  Copyright (c) 2013年 Sacchy. All rights reserved.
//

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]
#define WINSIZE [UIScreen mainScreen].bounds.size
#define ENDLESSMODE -1

typedef enum
{
	kLenShort=5,
	kLenLong=10,
} SAnimeLength;

@interface SAnime : UIView

+ (void)showWithText:(NSString *)text dispTime:(SAnimeLength)dispLen animationTimes:(NSInteger)animeTimes;

@end
