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

#define APIaddress  @"http://123.57.237.43:8080/api"//接口主路径
#define APIdeskList          @"/desk/list"          //桌信息
#define APIbeautyList        @"/user/beauty/list"   // 佳丽
#define APImanagerList       @"/user/manager/list"  //客户经理
#define APIdrinksList        @"/drink/list"     //酒水
#define APIsubmitGuessInfo   @"/order/save"     //提交竞猜
#define APIhistoryGuessOrder @"/order/list"    //获取历史竞猜
#define APIcancelGuessOrder  @"/order/cancel"  //取消竞猜
#define APIlogin             @"/user/login"    //登录
#define APIoddsList          @"/odds/list"     //
#define APImodifyPassword    @"/user/changePwd"//修改密码

@interface GMNetWorking : NSObject


//- (AFHTTPRequestOperationManager *)getManagerWithTimeout:(NSTimeInterval)secennd;

/**
 *  登陆
 *
 *  @param userName    用户名
 *  @param password    密码
 *  @param callBack    返回数据
 *  @param errorString 错误描述
 */
+ (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password completion:(callBack)callBack fail:(ErrorString)errorString;



/**
 *  获取桌信息
 *
 *  @param timeout     超时时间
 *  @param callBack    返回数据
 *  @param errorString 错误描述
 */
+ (void)getDeskListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString;

+ (void)getBeautyListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString;

+ (void)getManagerListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString;


/**
 *  获取赔率列表
 *
 *  @param timeout     超时
 *  @param callBack    返回数据
 *  @param errorString 错误描述
 */
+ (void)getBetTypeAndOddsListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString;




/**
 *  获取酒水列表
 *
 *  @param timeout     超时
 *  @param callBack    返回数据
 *  @param errorString 错误描述
 */
+ (void)getDrinksListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString;


+ (void)submitGuessToServer:(NSDictionary *)param completion:(callBack)callBack fail:(ErrorString)errorString;

+ (void)modifPasswordWithTimeout:(NSTimeInterval)timeout password:(NSString *)pwd waiterId:(NSString *)waterId completion:(callBack)callBack fail:(ErrorString)errorString;

@end
