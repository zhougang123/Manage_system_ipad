//
//  DrinksModel.h
//  PGGame
//
//  Created by RIMI on 15/10/3.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "BaseModel.h"

@interface DrinksModel : BaseModel

@property (nonatomic ,assign)NSInteger drinksID;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSNumber *price;
@property (nonatomic ,assign)NSInteger buyLimit;

@end
