//
//  JsonParser.h
//  PGGame
//
//  Created by RIMI on 15/9/29.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+ (PGUser *)parserUserDic:(NSDictionary *)userDic;


+ (NSMutableArray *)parserBetAndOddsArray:(NSArray *)betArray;


+ (NSMutableArray *)parserDrinksArray:(NSArray *)dataArray;

@end
