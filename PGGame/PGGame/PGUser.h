//
//  PGUser.h
//  PGGame
//
//  Created by RIMI on 15/9/30.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "BaseModel.h"

@interface PGUser : BaseModel

@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *gender;
@property (nonatomic ,strong)NSNumber *cardNumber;
@property (nonatomic ,assign)BOOL isFirstLogin;
@property (nonatomic ,strong)NSNumber *userID;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *nickName;
@property (nonatomic ,strong)NSNumber *workNumber;

@end
