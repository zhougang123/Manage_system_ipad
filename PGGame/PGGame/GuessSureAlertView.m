//
//  GuessSureAlertView.m
//  PGGame
//
//  Created by mac on 15/10/4.
//  Copyright © 2015年 qfpay. All rights reserved.
//

#import "GuessSureAlertView.h"

@interface GuessSureAlertView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *oddsTableview;
@property (nonatomic, copy) NSArray *guessArray;
@end

@implementation GuessSureAlertView

- (id)initWithGuessArray:(NSArray *)infoArray {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.guessArray = infoArray;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        
        NSInteger rows = [self.guessArray count] > 4 ? 6 : [self.guessArray count] + 2;
        
        UIView *alertBGView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4.0, (SCREEN_HEIGHT - (60 * rows + 120))/2.0 - 100, SCREEN_WIDTH/2.0, 60 * rows)];
        alertBGView.backgroundColor = [UIColor whiteColor];
        alertBGView.layer.cornerRadius = 5.0;
        alertBGView.layer.masksToBounds = YES;
        alertBGView.userInteractionEnabled = YES;
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 60)];
        headLabel.font = [UIFont systemFontOfSize:24];
        headLabel.textColor = [UIColor whiteColor];
        headLabel.backgroundColor = UIColorFromRGB(0xF63D44);
        headLabel.text = @"竞猜确认";
        headLabel.textAlignment = NSTextAlignmentCenter;
        [alertBGView addSubview:headLabel];
        
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(alertBGView.frame) - 60 , SCREEN_WIDTH/2.0, 60)];
        footView.userInteractionEnabled = YES;
        UIView *greyLinv = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(footView.frame)/2.0, 0, 1, 60)];
        greyLinv.backgroundColor = [UIColor lightGrayColor];
        
        UIView *greyLinh = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 1)];
        greyLinh.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.frame = CGRectMake(20, 10, CGRectGetWidth(alertBGView.frame)/2.0 - 40, 40);
        buttonCancel.layer.cornerRadius = 3;
        buttonCancel.layer.masksToBounds = YES;
        [buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonCancel setTitle:@"取 消" forState:UIControlStateNormal];
        [buttonCancel addTarget:self action:@selector(cancelAlertView) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buttonSure = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSure.frame = CGRectMake(20 + CGRectGetWidth(footView.frame)/2.0, 10, CGRectGetWidth(footView.frame)/2.0 - 40, 40);
        [buttonSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonSure setTitle:@"确 定" forState:UIControlStateNormal];
        buttonSure.layer.cornerRadius = 3;
        buttonSure.layer.masksToBounds = YES;
        [buttonSure addTarget:self action:@selector(sureAlertView) forControlEvents:UIControlEventTouchUpInside];
        
        [footView addSubview:buttonCancel];
        [footView addSubview:buttonSure];
        [footView addSubview:greyLinv];
        [alertBGView addSubview:footView];
        [footView addSubview:greyLinh];
        self.oddsTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headLabel.frame), SCREEN_WIDTH/2.0, (rows - 2) * 60) style:UITableViewStylePlain];
        self.oddsTableview.delegate = self;
        self.oddsTableview.dataSource = self;
        self.oddsTableview.rowHeight = 60;
        self.oddsTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        [alertBGView addSubview:self.oddsTableview];
        [self addSubview:alertBGView];

    }
    return self;
}

- (void)cancelAlertView{
    [self dismiss];
}

- (void)sureAlertView
{
    [self dismiss];
}

- (void)show{
    [shareAppDelegate.window addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.guessArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"odds";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"1111111";
    cell.detailTextLabel.text = @"222222";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
