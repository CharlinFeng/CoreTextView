//
//  ViewController.m
//  CoreTextView
//
//  Created by 冯成林 on 16/1/3.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString  *placeholder;       // default is nil.
@property (nonatomic, strong) UIColor   *placeholderColor;  // default is [UIColor grayColor];
@property (nonatomic, strong) UIFont    *placeholderFont;   // default is TextView Font
@property (nonatomic, assign) CGPoint   placeholderPoint;   // default is (8,8)
@property (nonatomic,assign) NSInteger  maxInputCount;      //最大输入限制
@end
