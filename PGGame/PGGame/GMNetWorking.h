//
//  GMNetWorking.h
//  PGGame
//
//  Created by RIMI on 15/9/29.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^callBack)(id obj);
typedef void (^ErrorString)(NSString* error);

#define address @"http://123.57.237.43:8080/api"//接口主路径

#define deskList @"/desk/list"  //桌信息（桌号、佳丽、客户经理）

@interface GMNetWorking : NSObject

+ (void)getDeskListWithTimeout:(NSTimeInterval)timeout CallBack:(callBack)callBack AndErrorString:(ErrorString)errorString;


@end
