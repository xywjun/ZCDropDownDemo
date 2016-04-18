//
//  ListView.h
//  ZCDropDownDemo
//
//  Created by wj on 15/7/16.
//  Copyright (c) 2015年 wj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListView;
@protocol ZCDropDownDelegate
- (void)dropDownDelegateMethod: (ListView *) sender;
@end
@class ListView;
@interface ListView : UIView<UITableViewDelegate, UITableViewDataSource>
- (void)hideDropDown:(UIButton *)button;
- (id)initWithShowDropDown:(UIButton *)button:(CGFloat )height:(NSArray *)arr;
@property (nonatomic, retain) id <ZCDropDownDelegate> delegate;

@end
