//
//  ViewController.h
//  ZCDropDownDemo
//
//  Created by wj on 15/7/15.
//  Copyright (c) 2015年 wj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListView.h"
@interface ViewController : UIViewController<ZCDropDownDelegate>{
    ListView *listView;
}
@property (nonatomic, retain)NSMutableArray *dataArr;

@end

