//
//  BetModel.m
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "BetModel.h"

static BetTypeSourceModel *sharedBetTypeSouce = nil;


@implementation BetModel

-(instancetype)init{
    if (self = [super init]) {
        self.betType = [BetTypeSourceModel shared];
        
    }
    
    return self;
}

@end





@implementation BetTypeSourceModel
{
    NSMutableDictionary * sourceDic;
}
+(instancetype)shared{
    if (!sharedBetTypeSouce) {
        sharedBetTypeSouce = [[self alloc]init];
    }
    
    return sharedBetTypeSouce;
}



-(instancetype)init{
    if (self = [super init]) {
        sourceDic = [@{@((1001)):@"大 (8点-12点)",
                       (@(1002)):@"和 (7点)",
                       (@(1003)):@"小 (2点-6点)",
                       (@(1004)):@"2点",
                       (@(1005)):@"3点",
                       (@(1006)):@"4点",
                       (@(1007)):@"5点",
                       (@(1008)):@"6点",
                       (@(1009)):@"8点",
                       (@(1010)):@"9点",
                       (@(1011)):@"10点",
                       (@(1012)):@"11点",
                       (@(1013)):@"12点",
                       (@(1014)):@"4+3",
                       (@(1015)):@"5+2",
                       (@(1016)):@"6+1",
                       (@(1017)):@"对子 (2+2)",
                       (@(1018)):@"对子 (3+3)",
                       (@(1019)):@"对子 (4+4)",
                       (@(1020)):@"对子 (5+5)"}mutableCopy];
        
    }
    
    return self;
}

- (NSString *)betTypeForBetTypeID:(NSInteger)betTypeID{
    
    return [sourceDic objectForKey:@(betTypeID)];
}

@end