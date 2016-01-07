//
//  ViewController.m
//  CoreTextView
//
//  Created by 冯成林 on 16/1/3.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CoreTextView *textView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.layer.borderWidth = 0.5f;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.placeholder = @"请输入您的评价";
    self.textView.maxInputCount = 10;
    
}

@end
