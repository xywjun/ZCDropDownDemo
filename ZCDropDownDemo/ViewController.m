//
//  ViewController.m
//  ZCDropDownDemo
//
//  Created by wj on 15/7/15.
//  Copyright (c) 2015年 wj. All rights reserved.
//

#import "ViewController.h"
#import "ListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, 200, 40)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    self.dataArr = [NSMutableArray array];
    [_dataArr addObject:@"111111"];
    [_dataArr addObject:@"222222"];
    [_dataArr addObject:@"333333"];
    [_dataArr addObject:@"444444"];
    [_dataArr addObject:@"555555"];
    [_dataArr addObject:@"666666"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listChanged:) name:@"NOTI" object:nil];
}

- (void)buttonClick:(UIButton *)btn{    
    CGFloat f;
    if(listView == nil) {
        if (_dataArr.count < 4) {
            f = 40*_dataArr.count;
        }else{
            f = 120;
        }
        listView = [[ListView alloc]initWithShowDropDown:btn :f :_dataArr];
        listView.delegate = self;
    }
    else {
        [listView hideDropDown:btn];
        listView = nil;
    }
}
- (void)listChanged:(NSNotification *)noti{
    self.dataArr = noti.object;
}
- (void)dropDownDelegateMethod: (ListView *) sender {
    listView = nil;

}
@end
