//
//  CMBALTextView.h
//
//  Created by wusong on 15/2/2.
//  Copyright (c) 2015年 OctWu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMBALTextViewLinkHandler)(NSURL *link, NSRange characterRange);

@interface CMBALTextView : UITextView<UITextViewDelegate>

@property (nonatomic, readwrite, assign)  IBInspectable BOOL displayFitContents;
@property (nonatomic)  IBInspectable CGFloat displayWidth;
@property (nonatomic, readwrite, assign) IBInspectable CGFloat maxDisplayHeight;

- (void)setLinkHandler:(CMBALTextViewLinkHandler)linkHandler;

@end
