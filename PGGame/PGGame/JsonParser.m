//
//  JsonParser.m
//  PGGame
//
//  Created by RIMI on 15/9/29.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser


+ (PGUser *)parserUserDic:(NSDictionary *)userDic{
    PGUser *user = [[PGUser alloc]init];
    
    user.address = [userDic objectForKey:@"address"];
    user.gender = [userDic objectForKey:@"gender"];
    user.userID = [userDic objectForKey:@"id"];
    user.isFirstLogin = [[userDic objectForKey:@"isFirstLogin"] boolValue];
    user.cardNumber = [userDic objectForKey:@"idCardNo"];
    user.name = [userDic objectForKey:@"name"];
    user.nickName = [userDic objectForKey:@"nickname"];
    user.workNumber = [userDic objectForKey:@"workNumber"];
    
    return user;
}

@end
