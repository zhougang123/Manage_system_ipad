//
//  BetModel.h
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "BaseModel.h"

@class BetTypeSourceModel;

//交易类型枚举
typedef NS_ENUM(NSUInteger, BetTypeID) {
    BetTypeID_da = 1001,
    BetTypeID_he,
    BetTypeID_xiao,
    BetTypeID_2dian,
    BetTypeID_3dian,
    BetTypeID_4dian,
    BetTypeID_5dian,
    BetTypeID_6dian,
    BetTypeID_8dian,
    BetTypeID_9dian,
    BetTypeID_10dian,
    BetTypeID_11dian,
    BetTypeID_12dian,
    BetTypeID_4jia3,
    BetTypeID_5jia2,
    BetTypeID_6jia1,
    BetTypeID_2duizi,
    BetTypeID_3duizi,
    BetTypeID_4duizi,
    BetTypeID_5dianzi
};


@interface BetModel : BaseModel

@property (nonatomic , strong)NSString *odds;//赔率

@property (nonatomic , strong)BetTypeSourceModel *betType;//押注类型
@property (nonatomic , assign)BetTypeID typeID;
@property (nonatomic , strong)NSString *drinksName; //下注酒水的名字
@property (nonatomic , strong)NSNumber *drinksNumber;//下注酒水数量

@end








@interface BetTypeSourceModel : BaseModel


+ (instancetype)shared;
- (NSString *)betTypeForBetTypeID:(NSInteger )betTypeID;

@end