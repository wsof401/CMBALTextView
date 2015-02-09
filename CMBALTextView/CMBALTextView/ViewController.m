//
//  ViewController.m
//  CMBALTextView
//
//  Created by wusong on 15/2/9.
//  Copyright (c) 2015年 wusong. All rights reserved.
//

#import "ViewController.h"
#import <PureLayout.h>
#import "CMBALTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CMBALTextView *textView = [CMBALTextView newAutoLayoutView];
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor lightGrayColor];
    [textView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [textView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    textView.displayWidth = 100;
    textView.editable = YES;
textView.text = @"请输入你所需要的文本，当然这是一个可以自增高的textView,你也可以输入内容，这是一个可以自增高的～～";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
