//
//  ViewController.m
//  CoreTextView
//
//  Created by 冯成林 on 16/1/3.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "CoreTextView.h"

#define OSVersionIsAtLeastiOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

@implementation CoreTextView

- (id)init
{
    self = [super init];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (void)dealloc
{
    [self removeTextChangeObserver];
}

- (void)addTextChangeObserver
{
    self.placeholderColor = [UIColor grayColor];
    self.placeholderPoint = CGPointMake(8, 8);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)removeTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIFont *font = self.placeholderFont ? self.placeholderFont : self.font;
    
    if (self.placeholder && self.placeholder.length > 0 && self.text.length == 0)
    {
        CGRect rect = CGRectMake(self.placeholderPoint.x,
                                 self.placeholderPoint.y,
                                 self.bounds.size.width - self.placeholderPoint.x,
                                 self.bounds.size.height - self.placeholderPoint.y);
        if (OSVersionIsAtLeastiOS7)
        {
            NSDictionary* attributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:self.placeholderColor};
            [self.placeholder drawInRect:rect withAttributes:attributes];
            

        }
        else
        {
            CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
            [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
        }
    }
    
    if(self.maxInputCount==0){return;}
    
    NSDictionary* tipAttr = @{NSFontAttributeName:font,NSForegroundColorAttributeName:self.placeholderColor};
    
    NSString *str = [NSString stringWithFormat:@"剩余%@字",@(self.maxInputCount - self.text.length)];
    
    CGSize tipSize =[str sizeWithFont:font];
    
    CGFloat x = rect.size.width - tipSize.width - 5;
    CGFloat y = rect.size.height - tipSize.height - 5;
    
    CGRect tipRect = CGRectMake(x, y, tipSize.width, tipSize.height);
    
    [str drawInRect:tipRect withAttributes:tipAttr];
}

#pragma mark - Set Method

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderPoint:(CGPoint)placeholderPoint
{
    _placeholderPoint = placeholderPoint;
    
    [self setNeedsDisplay];
}

- (void)textChanged:(NSNotification *)notification
{
    
    if (self.placeholder.length != 0)
    {
        [self setNeedsDisplay];
    }
    
    if(self.maxInputCount == 0) return;
    
    NSString *lang = [[self.nextResponder textInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.text.length > self.maxInputCount) {
                self.text = [self.text substringToIndex:self.maxInputCount];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (self.text.length > self.maxInputCount) {
            self.text = [ self.text substringToIndex:self.maxInputCount];
        }
    }
}

@end
