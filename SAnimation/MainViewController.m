//
//  MainViewController.m
//  SAnimation
//
//  Created by Sacchy on 2013/10/11.
//  Copyright (c) 2013年 Sacchy. All rights reserved.
//

#import "MainViewController.h"
#import "SAnime.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(WINSIZE.width/2-100, 100, 200, 30);
        [btn setTitle:@"Short Animation" forState:UIControlStateNormal];
        [btn setTitle:@"Push!!" forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(shortAnime) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(WINSIZE.width/2-100, 200, 200, 30);
        [btn setTitle:@"EndlessAnimation" forState:UIControlStateNormal];
        [btn setTitle:@"Push!!" forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(endlessAnime) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)shortAnime
{
    NSString *text = @"I am the bone of my sword";
    [SAnime showWithText:text dispTime:kLenShort animationTimes:2];          // NormalMode
}

- (void)endlessAnime
{
    NSString *text = @"I am the bone of my sword. Steel is my body,and fire is my blood...So as I pray,unlimited blade works.";
    [SAnime showWithText:text dispTime:kLenLong animationTimes:ENDLESSMODE]; // EndlessMode
}
@end
