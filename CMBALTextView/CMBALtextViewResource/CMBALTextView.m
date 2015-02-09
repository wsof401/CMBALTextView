//
//  CMBALTextView.m
//
//  Created by wusong on 15/2/2.
//  Copyright (c) 2015年 OctWu. All rights reserved.
//

#import "CMBALTextView.h"

@interface CMBALTextView ()

@property(nonatomic, copy) CMBALTextViewLinkHandler linkHandler;

@end

@implementation CMBALTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self _initializationConfig];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initializationConfig];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initializationConfig];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _initializationConfig];
    }
    return self;
}

- (void)_initializationConfig{
    self.editable = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.displayWidth = CGFLOAT_MAX;
    self.displayFitContents = YES;
    self.maxHeight = CGFLOAT_MAX;
    
}



- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if (self.linkHandler) {
        self.linkHandler(URL,characterRange);
    }    return NO;
}

#pragma mark - AutoLayout Core

- (void)layoutSubviews{
    [super layoutSubviews];
    if (CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) return;
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize{
    CGSize expectSize = [super intrinsicContentSize];
    if (self.displayFitContents ) {
        expectSize = self.contentSize;
        if (self.displayWidth != CGFLOAT_MAX ) {
            expectSize = [self sizeThatFits:CGSizeMake(self.displayWidth, CGFLOAT_MAX)];
            if (self.maxHeight != CGFLOAT_MAX) {
                expectSize.height = self.maxHeight;
            }
            
        }
    }
    return expectSize;
}

#pragma mark - Custom Associate


- (void)setDisplayFitContents:(BOOL)displayFitContents{
    _displayFitContents = displayFitContents;
    self.scrollEnabled = !displayFitContents;
}


@end
