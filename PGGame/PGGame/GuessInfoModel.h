//
//  GuessInfoModel.h
//  PGGame
//
//  Created by mac on 15/10/4.
//  Copyright © 2015年 qfpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessInfoModel : NSObject

@property (nonatomic, strong) NSString *oddsID;
@property (nonatomic, strong) NSString *drinkNum;
@property (nonatomic, strong) NSString *drinkID;
@property (nonatomic, strong) NSString *drinkName;
@property (nonatomic, strong) BetModel *betModel;

@end
