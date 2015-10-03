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



+(NSMutableArray *)parserBetAndOddsArray:(NSArray *)betArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in betArray) {
        
        BetModel * model = [[BetModel alloc]init];
        model.typeID = [[dic objectForKey:@"id"] integerValue];
        model.betType = [dic objectForKey:@"name"];
        
        model.odds = [NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"numerator"],[dic objectForKey:@"denominator"]];
        [array addObject:model];
        
    }
    
    return array;
}




+ (NSMutableArray *)parserDrinksArray:(NSArray *)dataArray{
    
    NSMutableArray *drinksArray = [NSMutableArray array];
    
    for (NSDictionary *dic in dataArray) {
        
        DrinksModel *model = [[DrinksModel alloc]init];
        model.name = [dic objectForKey:@"name"];
        model.drinksID = [[dic objectForKey:@"id"] integerValue];
        model.buyLimit = [[dic objectForKey:@"buyLimit"] integerValue];
        model.price = [dic objectForKey:@"price"];
        
        [drinksArray addObject:model];
    }
    
    return drinksArray;
}

@end
