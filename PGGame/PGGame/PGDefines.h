//
//  XYTDefines.h
//  XiaoYouTong
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#ifndef XYTDefines
#define XYTDefines

/***
 ***
 ***/


/***
 ***DEBUG模式下打印日志
 ***/
#ifdef DEBUG
#    define XYTLog(...) NSLog(__VA_ARGS__)
#else
#    define XYTLog(...)
#endif


/***
 ***弱引用
 ***/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/***
 ***状态栏的高度
 ***/
#define STATUS_BAR_HEIGHT CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)

/***
 ***导航栏的高度
 ***/
#define ZG_NAVIGATION_BAR_HEIGHT CGRectGetHeight(self.navigationController.navigationBar.frame)


#define STATUS_AND_NAVI_BAR (STATUS_BAR_HEIGHT + ZG_NAVIGATION_BAR_HEIGHT)
/***
 ***屏幕宽度
 ***/
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

/***
 ***屏幕高度
 ***/
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

/***
 ***不同屏幕相对320的比例
 ***/
#define BILI_WIDTH (CGRectGetWidth([UIScreen mainScreen].bounds)/320.0)

/***
 ***rgb颜色转换（16进制->10进制）
 ***/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define UIColorFromRGBWithAlpha(rgbValue, alpha) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:(alpha)]

#define TextGrayColor UIColorFromRGB(0x545454)

#define TextRedColor UIColorFromRGB(0xff2b2b)


/***
 ***理财家通用颜色
 ***/
#define PG_BG_GREY UIColorFromRGB(0xFAFAFB)  //背景灰

#define PG_TOPIC_GREEN_COLOR UIColorFromRGB(0x305E35) //科大绿
/***
 ***
 ***/
#define SECTION_SEPRARATE_HEIGTH (16.0 * BILI_WIDTH)
/***
 ***
 ***/

/***
 ***
 ***/





#endif
