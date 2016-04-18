//
//  ListView.m
//  ZCDropDownDemo
//
//  Created by wj on 15/7/16.
//  Copyright (c) 2015年 wj. All rights reserved.
//

#import "ListView.h"
#import "listCell.h"
@interface ListView ()
@property(nonatomic, retain) UITableView *tableV;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSMutableArray *list;
@property(nonatomic, retain) NSMutableArray *delArr;
@end

@implementation ListView

- (id)initWithShowDropDown:(UIButton *)button:(CGFloat )height:(NSArray *)arr{
    _btnSender = button;
    self = [super init];
    if (self) {
        CGRect btn = button.frame;
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        self.list = [NSMutableArray arrayWithArray:arr];
        self.delArr = [NSMutableArray arrayWithArray:self.list];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
//        self.layer.shadowOffset = CGSizeMake(-5, 5);
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOpacity = 0.5;
        
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.layer.cornerRadius = 5;
        _tableV.backgroundColor = [UIColor colorWithRed:0.619 green:0.239 blue:0.239 alpha:1];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.rowHeight = 40;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, height);
        _tableV.frame = CGRectMake(0, 0, btn.size.width, height);
        [UIView commitAnimations];
        [button.superview addSubview:self];
        //解决tableView线不能铺满的问题
        if ([self.tableV respondsToSelector:@selector(setSeparatorInset:)]){
            [self.tableV setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableV respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableV setLayoutMargins:UIEdgeInsetsZero];
        }
        [self addSubview:_tableV];
    }
    return self;
}
-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    _tableV.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* indentifier = @"cell";
    ListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = self.list[indexPath.row];
    cell.imageV.tag = indexPath.row;
    cell.imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [cell.imageV addGestureRecognizer:tap];
    return cell;
}
- (void)tap:(UITapGestureRecognizer *)tap{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"删除账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    alert.tag = tap.view.tag;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 1) {
        if ([self.list[alertView.tag] isEqualToString:_btnSender.titleLabel.text]) {
            [_btnSender setTitle:@"" forState:UIControlStateNormal];
        }
        [self.list removeObjectAtIndex:alertView.tag];
        //发送广播通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTI" object:self.list];
        CGFloat f;
        //刷新下拉视图的size
        if (self.list.count < 4) {
            f = 40*self.list.count;
        }else{
            f = 120;
        }
        _tableV.frame = CGRectMake(0, 0, _btnSender.frame.size.width, f);
        [_tableV reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:_btnSender];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [_btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate dropDownDelegateMethod:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
