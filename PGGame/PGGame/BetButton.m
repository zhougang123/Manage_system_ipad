//
//  BetButton.m
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "BetButton.h"

@implementation BetButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat labelH = frame.size.height * 2/5;
        self.betTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, labelH)];
        self.oddsLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, labelH + frame.origin.y, frame.size.width,frame.size.height - labelH )];

        self.betTypeLabel.font = [UIFont systemFontOfSize:17];
        self.betTypeLabel.textAlignment = NSTextAlignmentCenter;
        self.betTypeLabel.textColor = TextGrayColor;
        
        self.oddsLabel.text = @"1:20";
        [self.oddsLabel setTextColor:TextRedColor];
        self.oddsLabel.font = [UIFont fontWithName:@"BigYoungMediumGB2.0" size:22];
        self.oddsLabel.textAlignment = NSTextAlignmentCenter;
        
        
        self.betmodel = [[BetModel alloc]init];
        self.betmodel.drinksNumber = [NSNumber numberWithInteger:0];
        
    }
    
    return self;
}

@end
