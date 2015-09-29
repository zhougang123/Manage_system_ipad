//
//  BetButton.h
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetModel.h"

@interface BetButton : UIButton

@property (nonatomic ,strong)UILabel *betTypeLabel;
@property (nonatomic ,strong)UILabel *oddsLabel;

@property (nonatomic ,strong)BetModel *betmodel;

@end
