//
//  HistoryTableViewCell.m
//  PGGame
//
//  Created by RIMI on 15/10/4.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "PGCustomView.h"

@interface HistoryTableViewCell ()

@property (nonatomic ,strong)UILabel *deskLabel;
@property (nonatomic ,strong)UILabel *roundLabel;
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *jialiLabel;
@property (nonatomic ,strong)UILabel *managerLabel;
@property (nonatomic ,strong)UIButton *modifyBut;
@property (nonatomic ,strong)UIButton *cancelBut;

@property (nonatomic ,strong)UILabel *statuLabel;


@property (nonatomic, strong) PGCustomView *containerView;

@property (nonatomic ,strong)UIView *rectView;

@end

@implementation HistoryTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self custom];
    }
    
    return self;
}


- (void)custom{
    
    self.deskLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 *BILI_WIDTH, 10, 50 *BILI_WIDTH, 20 *BILI_WIDTH)];
    self.deskLabel.text = @"D16";
    self.deskLabel.font = [UIFont systemFontOfSize:10 *BILI_WIDTH];
    
    
    self.roundLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.deskLabel.frame) +25 *BILI_WIDTH, 10, CGRectGetWidth(self.deskLabel.frame), CGRectGetHeight(self.deskLabel.frame))];
    self.roundLabel.text = @"第3轮";
    self.roundLabel.font = [UIFont systemFontOfSize:10 *BILI_WIDTH];
   
    
    CGFloat buttonW = 40 *BILI_WIDTH;
    self.modifyBut = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - buttonW*2 - 8*BILI_WIDTH*2, 10, buttonW, CGRectGetHeight(self.roundLabel.frame))];
    [self.modifyBut setTitle:@"修改" forState:UIControlStateNormal];
    [self.modifyBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.modifyBut.layer.borderColor = UIColorFromRGB(0xE4E4E4).CGColor;
    self.modifyBut.layer.borderWidth = 1.0;
    self.modifyBut.layer.cornerRadius = 5.0;
    [self.modifyBut addTarget:self action:@selector(modifyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBut = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.modifyBut.frame) + 8*BILI_WIDTH, 10, CGRectGetWidth(self.modifyBut.frame), CGRectGetHeight(self.modifyBut.frame))];
    [self.cancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBut.layer.borderWidth = 1.0;
    self.cancelBut.layer.borderColor = UIColorFromRGB(0xE4E4E4).CGColor;
    self.cancelBut.layer.cornerRadius = 5.0;
    [self.cancelBut addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.statuLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.modifyBut.frame) + 15*BILI_WIDTH, 10, 30* BILI_WIDTH , CGRectGetHeight(self.cancelBut.frame))];
    self.statuLabel.text = @"已取消";
    self.statuLabel.textColor = UIColorFromRGB(0xB0B0B0);
    self.statuLabel.font = [UIFont systemFontOfSize:7*BILI_WIDTH];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roundLabel.frame) +10 *BILI_WIDTH, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xE4E4E4);
    
    
    //FootView
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 *BILI_WIDTH, CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, 30 *BILI_WIDTH, 10 *BILI_WIDTH)];
    timeLabel.text = @"竞猜时间:";
    timeLabel.textColor = UIColorFromRGB(0x828282);
    timeLabel.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
   
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame) ,  CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, 40 *BILI_WIDTH, 10 *BILI_WIDTH)];
    self.timeLabel.textColor = UIColorFromRGB(0x828282);
    self.timeLabel.text = @"10-04 18:03";
    self.timeLabel.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
    
    
    UILabel *jiali = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 20 *BILI_WIDTH, CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, CGRectGetWidth(timeLabel.frame), 10 *BILI_WIDTH)];
    jiali.text = @"包房佳丽:";
    jiali.textColor = UIColorFromRGB(0x828282);
    jiali.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
    
    
    
    self.jialiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jiali.frame), CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, CGRectGetWidth(self.timeLabel.frame),  10 *BILI_WIDTH)];
    self.jialiLabel.textColor = UIColorFromRGB(0x828282);
    self.jialiLabel.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
    self.jialiLabel.text = @"983324";
    
    
    UILabel *manager = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jialiLabel.frame) +20 *BILI_WIDTH, CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, CGRectGetWidth(jiali.frame), 10 *BILI_WIDTH)];
    manager.text = @"客户经理:";
    manager.textColor = UIColorFromRGB(0x828282);
    manager.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
    
    
    self.managerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(manager.frame), CGRectGetMaxY(lineView.frame) + 5*BILI_WIDTH, CGRectGetWidth(manager.frame), 10*BILI_WIDTH)];
    self.managerLabel.textColor = UIColorFromRGB(0x828282);
    self.managerLabel.font = [UIFont systemFontOfSize:6.5 *BILI_WIDTH];
    self.managerLabel.text = @"0233";
    
    _rectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame) +5*BILI_WIDTH , SCREEN_WIDTH, 4)];
    self.rectView.backgroundColor = UIColorFromRGB(0xE4E4E4);
    
    self.containerView = [[PGCustomView alloc] initWithFrame:CGRectZero];
    
    
    
    [self addSubview:_rectView];
    [self addSubview:self.containerView];
    [self addSubview:self.managerLabel];
    [self addSubview:manager];
    [self addSubview:self.jialiLabel];
    [self addSubview:jiali];
    [self addSubview:self.timeLabel];
    [self addSubview:timeLabel];
    [self addSubview:lineView];
    [self addSubview:self.statuLabel];
    [self addSubview:self.cancelBut];
    [self addSubview:self.cancelBut];
    [self addSubview:self.modifyBut];
    [self addSubview:self.roundLabel];
    [self addSubview:self.deskLabel];
    
    self.cancelBut.hidden = YES;
    self.modifyBut.hidden = YES;
    
}




#pragma mark - buttonAction
- (void)modifyButtonAction{
    
    NSLog(@"点击了修改按钮");
    
}

- (void)cancelButtonAction{
    
    NSLog(@"点击了取消按钮");
}


- (CGFloat)drawTableCellWithDetials:(NSArray *)detials
{
    self.containerView.frame = CGRectMake(10 * BILI_WIDTH, CGRectGetMaxY(self.jialiLabel.frame) + 10*BILI_WIDTH, SCREEN_WIDTH - 20 *BILI_WIDTH, kOneLineHeight * [detials count] +kOneLineHeight);
    self.rectView.frame = CGRectMake(0, CGRectGetMaxY(self.containerView.frame) +kOneLineHeight, SCREEN_WIDTH, 4);
    
    self.containerView.detialsArray = detials;
    
    return CGRectGetMaxY(self.rectView.frame);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
