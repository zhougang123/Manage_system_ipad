//
//  MainViewController.m
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#define LabelTag 1001

#import "MainViewController.h"
#import "BetButton.h"
#import "DeskInfoModel.h"


#define TableViewCellHeight 30 * BILI_WIDTH
#define TableViewCellFontSize 9 *BILI_WIDTH

typedef NS_ENUM(NSUInteger, TableViewType) {
    TableViewType_DeskInfo,
    TableViewType_BetInfo,
};

typedef NS_ENUM(NSUInteger, CellLabelSType) {
    CellLabelSType_numberLabel = 8888,
    CellLabelSType_jialiLabel,
    CellLabelSType_managerLabel,
};


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    DeskInfoModel *selectedDeskInfo;//选中的桌信息(桌号、佳丽、客户经理)
    BetButton *selectedBetButton;//选中的下注按钮(下注类型、赔率、酒水、酒水数量)
    UIButton *maskButton;//阴影按钮（tableView阴影背景）
    UITableView *tableListView;//列表（桌信息列表、下注列表）
}

@property (nonatomic ,strong)NSMutableArray *deskInfoArray;
@property (nonatomic ,strong)NSMutableArray *betInfoArray;

@end

@implementation MainViewController

#pragma mark - configur UI

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI{
    
    
//    self.view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"酒水竞猜";
   
    UIView *hederView = [self createHederView];
    maskButton = [self createMaskBut];
    tableListView = [self createDeskTableView];
    
    CGFloat leftMargin = 10 * BILI_WIDTH;
    CGFloat topMargin = 16 * BILI_WIDTH;
    CGFloat margin = 18 * BILI_WIDTH;
    CGFloat buttonWidth = (SCREEN_WIDTH - (leftMargin * 2 +margin * 3))/4;
    CGFloat buttonHeight = 30 * BILI_WIDTH;
    //创建投注按钮
    for (int i = 0 ; i < 20 ; i ++) {
        BetButton *button = [[BetButton alloc]initWithFrame:CGRectMake(leftMargin + i%4*(margin + buttonWidth) , CGRectGetMaxY(hederView.frame) + topMargin + i/4*(topMargin + buttonHeight), buttonWidth, buttonHeight)];
    
        button.tag = LabelTag + i;
        
        button.betTypeLabel.text = [button.betmodel.betType betTypeForBetTypeID:button.tag];
        
        [button setBackgroundImage:[UIImage imageNamed:@"jincai_button_default"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(betButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.view addSubview:button.betTypeLabel];
        [self.view addSubview:button.oddsLabel];
    }
    
    CGFloat confirmButWidth = 150 *BILI_WIDTH;
    CGFloat confirmButHeight = 25 *BILI_WIDTH;
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - confirmButWidth)/2, SCREEN_HEIGHT - confirmButHeight - 10 *BILI_WIDTH , confirmButWidth, confirmButHeight)];
    [confirm setBackgroundImage:[UIImage imageNamed:@"jingcai_button_submita"] forState:UIControlStateNormal];
    [confirm setTitle:@"确定竞猜" forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont systemFontOfSize:9 * BILI_WIDTH];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [self.view addSubview:confirm];
    [self.view addSubview:hederView];
    [self.view addSubview:maskButton];
    [self.view addSubview:tableListView];

    
}

- (UIView *)createHederView{
    
    UIButton *historyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBut.frame = CGRectMake(0, 0, 30 * BILI_WIDTH, 20 * BILI_WIDTH);
    [historyBut setTitle:@"竞猜历史" forState:UIControlStateNormal];
    [historyBut setTitleColor:TextGrayColor forState:UIControlStateNormal];
    historyBut.titleLabel.font = [UIFont systemFontOfSize:17];
    [historyBut addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:historyBut];
    self.navigationItem.rightBarButtonItem = item;
    
    CGFloat hederViewHeight = 42 * BILI_WIDTH;
    UIView *hederView = [[UIView alloc]initWithFrame:CGRectMake(0, 68 , SCREEN_WIDTH, hederViewHeight)];
    hederView.backgroundColor = [UIColor whiteColor];
    //创建hederView按钮
    
    UIButton *hederButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(hederView.frame), CGRectGetHeight(hederView.frame))];
    [hederButton addTarget:self action:@selector(hederButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [hederView addSubview:hederButton];

    
    return hederView;
    
}


- (UITableView *)createDeskTableView{
    UITableView *deskTabV = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 160 * BILI_WIDTH) style:UITableViewStylePlain];
    deskTabV.tableFooterView = [[UIView alloc]init];
    deskTabV.delegate = self;
    deskTabV.dataSource = self;
    
    return deskTabV;
}

- (UIButton *)createMaskBut{
    UIButton *maskBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [maskBut addTarget:self action:@selector(hiddenList:) forControlEvents:UIControlEventTouchUpInside];
    maskBut.frame = self.view.frame;
    maskBut.backgroundColor = [UIColor blackColor];
    maskBut.alpha = 0.5;
    maskBut.hidden = YES;
    
    return maskBut;
}




- (void)updateBetButton:(BetButton *)but{
    
    if (but.selected) {
        [but setBackgroundImage:[UIImage imageNamed:@"jincai_button_default"] forState:UIControlStateNormal];
        but.betTypeLabel.textColor = TextGrayColor;
        but.oddsLabel.textColor = TextRedColor;

    }else{
       [but setBackgroundImage:[UIImage imageNamed:@"jincai_button_press"] forState:UIControlStateNormal];
        but.betTypeLabel.textColor = [UIColor whiteColor];
        but.oddsLabel.textColor = [UIColor whiteColor];
    }
    
    but.selected = !but.isSelected;
}


#pragma mark - 事件响应

//点击了下注按钮
- (void)betButtonAction:(BetButton *)button{
   
    selectedBetButton = button;
    [self showTableViewListWithType:TableViewType_BetInfo];
    [self updateBetButton:button];
}


//点击了头部按钮
- (void)hederButtonAction{
    NSLog(@"选择佳丽");
    [self showTableViewListWithType:TableViewType_DeskInfo];
}



//点击了竞猜历史按钮
- (void)historyButtonAction:(UIButton *)but{
    
}



#pragma  mark - Custom Methon

//展现tableView
- (void)showTableViewListWithType:(TableViewType)tableViewType{
    
    tableListView.tag = tableViewType;
    maskButton.alpha = 0;
    maskButton.hidden = NO;
    CGRect frame = tableListView.frame;
    frame.origin.y = SCREEN_HEIGHT - frame.size.height;
    [tableListView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        maskButton.alpha = 0.5;
        tableListView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

//点击了阴影按钮
- (void)hiddenList:(UIButton *)deskBut{
    
    CGRect frame = tableListView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.25 animations:^{
        tableListView.frame = frame;
        maskButton.alpha = 0;
        
    } completion:^(BOOL finished) {
        maskButton.hidden = YES;
    }];
    
}

- (void)getList{
    
    [GMNetWorking getDeskListWithTimeout:15 CallBack:^(id obj) {
        
    } AndErrorString:^(NSString *error) {
        
    }];
}


#pragma  mark - tableViewMethon

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger row;
    
    if (tableView.tag == TableViewType_DeskInfo) {
        //选择桌号、佳丽、客户经理
        
        row = self.deskInfoArray.count;
    }else{
        //选择下注酒水
        row = self.betInfoArray.count;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = tableView.tag == TableViewType_DeskInfo? @"DeskInfoCell" : @"BetInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (tableView.tag == TableViewType_DeskInfo) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeskInfoCell"];
        }else{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BetInfoCell"];
        }
    }
    
    if (tableView.tag == TableViewType_DeskInfo) {
        DeskInfoModel *deskinfo = self.deskInfoArray[indexPath.row];
        CGFloat labelW = (SCREEN_WIDTH ) / 3;
        
        UILabel *deskNumberLb =(UILabel *) [cell.contentView viewWithTag:CellLabelSType_numberLabel];
        if (!deskinfo) {
        
            deskNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelW, TableViewCellHeight)];
            deskNumberLb.textAlignment = NSTextAlignmentCenter;
            deskNumberLb.font = [UIFont systemFontOfSize:TableViewCellFontSize];
            deskNumberLb.tag = CellLabelSType_numberLabel;
            [cell.contentView addSubview:deskNumberLb];
        }
        
        UILabel *jialiLabel = (UILabel *)[cell.contentView viewWithTag:CellLabelSType_jialiLabel];
        if (!jialiLabel) {
            jialiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deskNumberLb.frame), 0, labelW, TableViewCellHeight)];
            jialiLabel.textAlignment = NSTextAlignmentCenter;
            jialiLabel.font = [UIFont systemFontOfSize:TableViewCellFontSize];
            jialiLabel.tag = CellLabelSType_jialiLabel;
            [cell.contentView addSubview:jialiLabel];
        }
        
        UILabel *managerNumberLb = (UILabel *)[cell.contentView viewWithTag:CellLabelSType_managerLabel];
        if (!managerNumberLb) {
            managerNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jialiLabel.frame), 0, labelW, TableViewCellHeight)];
            managerNumberLb.textAlignment = NSTextAlignmentCenter;
            managerNumberLb.font = [UIFont systemFontOfSize:TableViewCellFontSize];
            managerNumberLb.tag = CellLabelSType_managerLabel;
            [cell.contentView addSubview:managerNumberLb];
            [cell layoutIfNeeded];
        }
        
        deskNumberLb.text = deskinfo.deskNumber;
        jialiLabel.text = deskinfo.jiali;
        NSString *manager = deskinfo.manager;
        managerNumberLb.text = @"0121";

        
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        cell.textLabel.text = self.betInfoArray[indexPath.row];
    }
    
    
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hederView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TableViewCellHeight)];
    hederView.backgroundColor = [UIColor whiteColor];
    if (tableView.tag == TableViewType_DeskInfo) {
        //选择桌信息列表
        CGFloat labelW = SCREEN_WIDTH / 3;
        UILabel *deskNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, labelW, TableViewCellHeight)];
        deskNumberLb.textAlignment = NSTextAlignmentCenter;
        deskNumberLb.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        
        UILabel *jialiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deskNumberLb.frame), 0, labelW, TableViewCellHeight)];
        jialiLabel.textAlignment = NSTextAlignmentCenter;
        jialiLabel.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        
        UILabel *managerNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jialiLabel.frame), 0, labelW, TableViewCellHeight)];
        managerNumberLb.textAlignment = NSTextAlignmentCenter;
        managerNumberLb.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        
        deskNumberLb.text = @"桌号";
        jialiLabel.text = @"佳丽";
        managerNumberLb.text = @"客户经理";
        
        [hederView addSubview:deskNumberLb];
        [hederView addSubview:jialiLabel];
        [hederView addSubview:managerNumberLb];
    }else{
        UILabel *lable = [[UILabel alloc]init];
        lable.frame = hederView.frame;
        lable.text = @"我是下注列表头";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        [hederView addSubview:lable];
    }
    
    
    return hederView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return TableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableViewCellHeight;
}






//======================
- (NSMutableArray *)deskInfoArray{
    if (!_deskInfoArray) {
        _deskInfoArray = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            DeskInfoModel *model = [[DeskInfoModel alloc]init];
            model.deskNumber = [NSString stringWithFormat:@"%@",@(i+15)];
            model.jiali = [NSString stringWithFormat:@"%@",@(i + 9660)];
            model.manager = [NSString stringWithFormat:@"0%@",@(i + 121)];
            [_deskInfoArray addObject:model];
        }
    }
    
    return _deskInfoArray;
}

- (NSMutableArray *)betInfoArray{
    if (_betInfoArray) {
        _betInfoArray = [@[@"黄鸡礼炮",@"XO",@"威士忌",@"贵州茅台",@"五粮液"] mutableCopy];
    }
    return _betInfoArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
