//
//  CMBALTextView.m
//
//  Created by wusong on 15/2/2.
//  Copyright (c) 2015年 OctWu. All rights reserved.
//

#import "CMBALTextView.h"
#import <ReactiveCocoa.h>

@interface CMBALTextView ()

@property(nonatomic, copy) CMBALTextViewLinkHandler linkHandler;

@property(nonatomic, copy) NSString *resizeString;

@property(nonatomic, strong) UITextView *resizeTV;

@end

@implementation CMBALTextView

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
    self.maxDisplayHeight = CGFLOAT_MAX;
    self.font = [KOStyleManager LatoFontWithSize:14];
    self.delegate = self;
}


- (UITextView *)resizeTV{
    if (!_resizeTV) {
        _resizeTV = [UITextView newAutoLayoutView];
    }
    return _resizeTV;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.resizeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([text isEqualToString:@"@"]) {
        
    }
    
    if (!CGSizeEqualToSize(self.frame.size, [self sizeForDetail:self.resizeString]))
    {
        [self invalidateIntrinsicContentSize];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if (self.linkHandler) {
        self.linkHandler(URL,characterRange);
    }
    return NO;
}


#pragma mark - AutoLayout Core

- (CGSize)intrinsicContentSize{
    return [self sizeForDetail:self.resizeString];
}


- (CGSize)sizeForDetail:(NSString *)detail{
    self.resizeTV.frame = self.frame;
    self.resizeTV.font = self.font;
    self.resizeTV.text = detail;
    self.resizeTV.attributedText = self.attributedText;
    CGSize expectSize = [self.resizeTV intrinsicContentSize];
    if (self.displayFitContents) {
        CGFloat displayWidth = CGRectGetWidth(self.frame);
        if (self.displayWidth != CGFLOAT_MAX ) {
            displayWidth = self.displayWidth;
        }

        expectSize  = [self.resizeTV sizeThatFits:CGSizeMake(displayWidth, CGFLOAT_MAX)];
        expectSize.height = ((NSInteger)expectSize.height * 100) / 100.0f;
        if (_maxDisplayHeight != CGFLOAT_MAX) {
            expectSize.height = expectSize.height < _maxDisplayHeight ? expectSize.height : _maxDisplayHeight;
        }
        expectSize.width = displayWidth;
    }
    return expectSize;
}



#pragma mark - Custom Associate


- (void)setDisplayFitContents:(BOOL)displayFitContents{
    _displayFitContents = displayFitContents;
    self.scrollEnabled = !displayFitContents;
}


- (void)loadAtAttrWithSource:(NSString *)source{
   __block NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:source];
    NSRegularExpression *expresion = [[NSRegularExpression alloc] initWithPattern:@"@[^@\\s]+" options:0 error:nil];
    [expresion enumerateMatchesInString:source options:0 range:NSMakeRange(0, source.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange linkRange = NSMakeRange(result.range.location, result.range.length + 1);
        NSString *linkString = [source substringWithRange:result.range];
     linkString = [linkString stringByReplacingOccurrencesOfString:@"@" withString:@""];
        [attr addAttribute:NSLinkAttributeName value:linkString range:linkRange];
    }];
    self.attributedText = attr;
}

@end
