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
    TableViewType_BetInfo//酒水
};

typedef NS_ENUM(NSUInteger, CellLabelSType) {
    CellLabelSType_numberLabel = 8888,
    CellLabelSType_jialiLabel,
    CellLabelSType_managerLabel,
};


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    DeskInfoModel *selectedDeskInfo;//选中的桌信息(桌号、佳丽、客户经理)
    BetButton *selectedBetButton;//选中的下注按钮(下注类型、赔率、酒水、酒水数量)
    UIButton *maskButton;//阴影按钮（tableView阴影背景）
    UITableView *tableListView;//列表（桌信息列表、下注列表）
    
    UILabel *drinksNumLabel;//计数label
}

@property (nonatomic ,strong)NSMutableArray *deskInfoArray;
@property (nonatomic ,strong)NSMutableArray *betInfoArray;
@property (nonatomic ,strong)NSMutableArray *managerInfoArray;

@property (nonatomic, strong)UIToolbar  *toolBar;
@property (nonatomic, strong)UIPickerView *deskPickerView;
@property (nonatomic, strong)UIPickerView *beautyPickerView;
@property (nonatomic, strong)UIPickerView *managerPickerView;

@property (nonatomic, strong)UITextField *selectDeskTF;
@property (nonatomic, strong)UITextField *selectBeautyTF;
@property (nonatomic, strong)UITextField *selectManagerTF;
@property (nonatomic, strong)UIButton    *deskButton;
@property (nonatomic, strong)UIButton    *beautyButton;
@property (nonatomic, strong)UIButton    *managerButton;


@property (nonatomic, strong)NSMutableArray *drinkArray;


@end

@implementation MainViewController
- (UIPickerView *)deskPickerView
{
    if (_deskPickerView == nil) {
        _deskPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
        _deskPickerView.delegate = self;
        _deskPickerView.dataSource = self;
        _deskPickerView.tag = 10000;
    }
    return _deskPickerView;
    
}
- (UIPickerView *)beautyPickerView
{
    if (_beautyPickerView == nil) {
        _beautyPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
        _beautyPickerView.delegate = self;
        _beautyPickerView.dataSource = self;
        _beautyPickerView.tag = 20000;
    }
    return _beautyPickerView;
}
- (UIPickerView *)managerPickerView
{
    if (_managerPickerView == nil) {
        _managerPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216)];
        _managerPickerView.delegate = self;
        _managerPickerView.dataSource = self;
        _managerPickerView.tag = 30000;
    }
    return _managerPickerView;
}
//返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rows = 0;
    switch (pickerView.tag) {
        case 10000:
            rows = [self.deskInfoArray count];
            break;
        case 20000:
            rows = [self.betInfoArray count];
            break;
        case 30000:
            rows = [self.managerInfoArray count];
            break;
        default:
            break;
    }
    return rows;
}

//每行显示的文字样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 107, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14 * BILI_WIDTH];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *rowTitle = nil;
    
    switch (pickerView.tag) {
        case 10000:
            rowTitle = self.deskInfoArray[row][@"name"];
            break;
        case 20000:
            rowTitle = self.betInfoArray[row][@"workNumber"];
            break;
        case 30000:
            rowTitle = self.managerInfoArray[row][@"workNumber"];
            break;
        default:
            break;
    }
    titleLabel.text = rowTitle;
    return titleLabel;
    
}


- (UIToolbar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [[ UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30 * BILI_WIDTH)];
        _toolBar.barStyle = UIBarStyleDefault;
        

        
        UIBarButtonItem *doneButton   = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(surePickerAction)];
        UIBarButtonItem *cancleButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPickerAction)];
        
        UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:@"选择房间信息"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
        titleButton.tintColor = [UIColor lightGrayColor];
        
        UIBarButtonItem *spaceButton1  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        UIBarButtonItem *spaceButton2  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        
        [_toolBar setItems:@[cancleButton, spaceButton1 ,titleButton, spaceButton2, doneButton]];
    }
    return _toolBar;
}
- (void)surePickerAction{
    if ([self.selectDeskTF isFirstResponder]) {
        NSInteger row1 = [self.deskPickerView selectedRowInComponent:0];
        [self.deskButton setTitle:self.deskInfoArray[row1][@"name"] forState:UIControlStateNormal];
    }
    if ([self.selectBeautyTF isFirstResponder]) {
        NSInteger row2 = [self.beautyPickerView selectedRowInComponent:0];
        [self.beautyButton setTitle:self.betInfoArray[row2][@"workNumber"] forState:UIControlStateNormal];


    }
    if ([self.selectManagerTF isFirstResponder]) {
        NSInteger row3 = [self.managerPickerView selectedRowInComponent:0];
        [self.managerButton setTitle:self.managerInfoArray[row3][@"workNumber"] forState:UIControlStateNormal];

    }
    
    [self.selectDeskTF resignFirstResponder];
    [self.selectBeautyTF resignFirstResponder];
    [self.selectManagerTF resignFirstResponder];
}
- (void)cancelPickerAction
{
    [self.selectDeskTF resignFirstResponder];
    [self.selectBeautyTF resignFirstResponder];
    [self.selectManagerTF resignFirstResponder];

}
#pragma mark - configur UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deskInfoArray = [[NSMutableArray alloc] init];
    self.betInfoArray = [[NSMutableArray alloc] init];
    self.managerInfoArray = [[NSMutableArray alloc] init];
    self.drinkArray = [[NSMutableArray alloc] init];
    
    
    self.selectDeskTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.selectDeskTF.inputView = self.deskPickerView;
    self.selectDeskTF.inputAccessoryView = self.toolBar;
    
    self.selectBeautyTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.selectBeautyTF.inputView = self.beautyPickerView;
    self.selectBeautyTF.inputAccessoryView = self.toolBar;
    
    self.selectManagerTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.selectManagerTF.inputView = self.managerPickerView;
    self.selectManagerTF.inputAccessoryView = self.toolBar;
    
    
    [self.view addSubview:self.selectDeskTF];
    [self.view addSubview:self.selectBeautyTF];
    [self.view addSubview:self.selectManagerTF];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI{
    
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
    
    CGFloat hederViewHeight = 44 * BILI_WIDTH;
    UIView *hederView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAVI_BAR , SCREEN_WIDTH, hederViewHeight)];
    hederView.backgroundColor = [UIColor whiteColor];
    //创建hederView按钮
    
    CGFloat width = SCREEN_WIDTH/3.0;
    UIImageView *deskIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30 , 15 * BILI_WIDTH, 14 * BILI_WIDTH, 14 * BILI_WIDTH)];
    [deskIcon setImage:[UIImage imageNamed:@"jincai_icon_jiuzhuo"]];
    
    
    self.deskButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deskIcon.frame), 7 * BILI_WIDTH, width - 20 * BILI_WIDTH - 30 * BILI_WIDTH, 30 * BILI_WIDTH)];
    self.deskButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deskButton.layer.borderWidth = 1.0;
    [self.deskButton setTitle:@"桌号" forState:UIControlStateNormal];
    [self.deskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deskButton addTarget:self action:@selector(deskButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *beautyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30 + width, 15 * BILI_WIDTH, 14 * BILI_WIDTH, 14 * BILI_WIDTH)];
    [beautyIcon setImage:[UIImage imageNamed:@"jincai_icon_jiali"]];
    
    self.beautyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beautyIcon.frame), 7 * BILI_WIDTH, width - 20 * BILI_WIDTH - 30 * BILI_WIDTH, 30 * BILI_WIDTH)];
    self.beautyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.beautyButton.layer.borderWidth = 1.0;
    [self.beautyButton setTitle:@"佳丽" forState:UIControlStateNormal];
    [self.beautyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.beautyButton addTarget:self action:@selector(beautyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *managerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30 + width*2.0, 15 * BILI_WIDTH, 14 * BILI_WIDTH, 14 * BILI_WIDTH)];
    [managerIcon setImage:[UIImage imageNamed:@"jincai_icon_manager"]];
    
    self.managerButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(managerIcon.frame), 7 * BILI_WIDTH, width - 20 * BILI_WIDTH - 30 * BILI_WIDTH, 30 * BILI_WIDTH)];
    self.managerButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.managerButton.layer.borderWidth = 1.0;
    [self.managerButton setTitle:@"经理" forState:UIControlStateNormal];
    [self.managerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.managerButton addTarget:self action:@selector(managerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [hederView addSubview:deskIcon];
    [hederView addSubview:self.deskButton];
    
    [hederView addSubview:beautyIcon];
    [hederView addSubview:self.beautyButton];
    
    [hederView addSubview:managerIcon];
    [hederView addSubview:self.managerButton];
    return hederView;
    
}
- (void)deskButtonAction{
    
    WS(weakSelf);
    
    [GMNetWorking getDeskListWithTimeout:30 completion:^(id respDesk) {
        NSDictionary *resDictDesk = (NSDictionary *)respDesk;
        if ([resDictDesk count] > 0) {
            NSArray *desks = resDictDesk[@"data"];
            [weakSelf.deskInfoArray removeAllObjects];
            [weakSelf.deskInfoArray addObjectsFromArray:desks];
            [weakSelf.selectDeskTF becomeFirstResponder];
        }else{
            [SVProgressHUD showErrorWithStatus:@"未获取到桌号列表"];
        }
        
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error.lowercaseString];
        
    }];

    
    
}
- (void)beautyButtonAction{
    WS(weakSelf);
    [GMNetWorking getBeautyListWithTimeout:30 completion:^(id respBeauty) {
        NSDictionary *resDictBeauty = (NSDictionary *)respBeauty;
        if ([resDictBeauty count] > 0) {
            NSArray *brauties = resDictBeauty[@"data"];
            [weakSelf.betInfoArray removeAllObjects];
            [weakSelf.betInfoArray addObjectsFromArray:brauties];
            
            [weakSelf.selectBeautyTF becomeFirstResponder];
        }else{
            [SVProgressHUD showErrorWithStatus:@"未获取到佳丽列表"];
        }
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error.lowercaseString];
    }];

    

}
- (void)managerButtonAction{
    WS(weakSelf);
    [GMNetWorking getManagerListWithTimeout:30.0 completion:^(id respManager) {
        NSDictionary *resDictManager = (NSDictionary *)respManager;
        if ([resDictManager count] > 0) {
            NSArray *managers = resDictManager[@"data"];
            [weakSelf.managerInfoArray removeAllObjects];
            [weakSelf.managerInfoArray addObjectsFromArray:managers];
            
            
            [self.selectManagerTF becomeFirstResponder];

        }else{
            [SVProgressHUD showErrorWithStatus:@"未获取到经理列表"];
        }
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error.lowercaseString];
    }];
    

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
    [maskBut addTarget:self action:@selector(hiddenList) forControlEvents:UIControlEventTouchUpInside];
    maskBut.frame = self.view.frame;
    maskBut.backgroundColor = [UIColor blackColor];
    maskBut.alpha = 0.5;
    maskBut.hidden = YES;
    
    return maskBut;
}




- (void)updateBetButton:(BetButton *)but{
    
    but.betmodel.drinksNumber = [NSNumber numberWithInteger:[drinksNumLabel.text integerValue]];
    
    if ([but.betmodel.drinksNumber intValue]==0) {
        
        [but setBackgroundImage:[UIImage imageNamed:@"jincai_button_default"] forState:UIControlStateNormal];
        but.betTypeLabel.textColor = TextGrayColor;
        but.oddsLabel.textColor = TextRedColor;


    }else{
        
        [but setBackgroundImage:[UIImage imageNamed:@"jincai_button_press"] forState:UIControlStateNormal];
        but.betTypeLabel.textColor = [UIColor whiteColor];
        but.oddsLabel.textColor = [UIColor whiteColor];
    }
    
   
}


#pragma mark - 事件响应

//点击了下注按钮
- (void)betButtonAction:(BetButton *)button{
   
    selectedBetButton = button;
    [GMNetWorking getDrinkListWithTimeout:30 completion:^(id obj) {
        NSDictionary *dict = (NSDictionary *)obj;
        if ([dict count] > 0) {
            [self.drinkArray removeAllObjects];
            NSArray *drinks = dict[@"data"];
            if ([drinks count] > 0) {
                [self.drinkArray addObjectsFromArray:drinks];
            }else{
                [SVProgressHUD showErrorWithStatus:@"没有获取到酒水信息"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有获取到酒水信息"];
        }
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error.lowercaseString];

    }];
    
    
    
//    [self showTableViewListWithType:TableViewType_BetInfo];
//    [self updateBetButton:button];
}




//点击了竞猜历史按钮
- (void)historyButtonAction:(UIButton *)but{
    
}

//点击了阴影按钮
- (void)hiddenList{
    
    CGRect frame = tableListView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.25 animations:^{
        tableListView.frame = frame;
        maskButton.alpha = 0;
        
    } completion:^(BOOL finished) {
        maskButton.hidden = YES;
    }];
    
}

//点击了列表里面-
- (void)deleteButtonAction{
    
    NSInteger number = [drinksNumLabel.text integerValue];
    if (number <= 0) {
        [SVProgressHUD showErrorWithStatus:@"已经不能再减少了哦 - -!"];
        return;
    }
    
//    selectedBetButton.betmodel.drinksNumber = [NSNumber numberWithInteger:number - 1];
    drinksNumLabel.text = [[NSNumber numberWithInteger:number - 1] description];
    
}

//点击了列表里面的+
- (void)addbuttonAction{
    
    NSInteger number = [drinksNumLabel.text integerValue];
    if (number >= 99) {
        [SVProgressHUD showErrorWithStatus:@"已经投得够多了哦 - -!"];
        return;
    }
    
//    selectedBetButton.betmodel.drinksNumber = [NSNumber numberWithInteger:number + 1];
    drinksNumLabel.text = [[NSNumber numberWithInteger:number + 1] description];
    
    
}

//点击了列表里的确定按钮
- (void)confirmButtonAction{
    [self updateBetButton:selectedBetButton];
    [self hiddenList];
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

//配置选择桌信息HederView
- (void)configurationDeskTableHederView:(UIView *)hederView{
    
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

    
}

//配置下注HederView
- (void)configurationBetTableHederView:(UIView *)hederView{
    
    CGFloat buttonTopMargin = 8 * BILI_WIDTH;
    UIButton *deletebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 *BILI_WIDTH, buttonTopMargin, 14 *BILI_WIDTH, 14 * BILI_WIDTH)];
    [deletebutton setBackgroundImage:[UIImage imageNamed:@"jiushui_icon_-"] forState:UIControlStateNormal];
    [deletebutton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    drinksNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deletebutton.frame)+ 10 * BILI_WIDTH, 10, 40 * BILI_WIDTH, TableViewCellHeight - 21)];
    drinksNumLabel.text = [selectedBetButton.betmodel.drinksNumber description];
    drinksNumLabel.textAlignment = NSTextAlignmentCenter;
    drinksNumLabel.font = [UIFont systemFontOfSize:10 *BILI_WIDTH];
    drinksNumLabel.layer.borderWidth = 1.0;
    drinksNumLabel.layer.borderColor = UIColorFromRGB(0xe0e0e0).CGColor;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(drinksNumLabel.frame) + 10 *BILI_WIDTH, buttonTopMargin, CGRectGetWidth(deletebutton.frame), CGRectGetHeight(deletebutton.frame))];
    [addButton setBackgroundImage:[UIImage imageNamed:@"jiushui_icon_+"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addbuttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *oddsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame) +15*BILI_WIDTH, 10, 70 *BILI_WIDTH, TableViewCellHeight -21)];
    NSString *betType = [selectedBetButton.betmodel.betType betTypeForBetTypeID:selectedBetButton.tag];
    oddsLabel.text = [NSString stringWithFormat:@"%@ (%@)",betType,selectedBetButton.betmodel.odds];
    oddsLabel.textColor = UIColorFromRGB(0xffa30b);
    oddsLabel.font = [UIFont systemFontOfSize:8 *BILI_WIDTH];
    oddsLabel.textAlignment = NSTextAlignmentCenter;
    oddsLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    
    UIButton* cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - CGRectGetWidth(drinksNumLabel.frame)*2 - 8*BILI_WIDTH - 10, 10,CGRectGetWidth(drinksNumLabel.frame), CGRectGetHeight(drinksNumLabel.frame))];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10 *BILI_WIDTH];
    [cancelButton setTitleColor:UIColorFromRGB(0x545454) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hiddenList) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundColor:UIColorFromRGB(0xe0e0e0)];
    cancelButton.layer.cornerRadius = 8.0;
    
    UIButton *domeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame) + 8 *BILI_WIDTH, 10, CGRectGetWidth(cancelButton.frame), CGRectGetHeight(cancelButton.frame))];
    
    [domeButton setTitle:@"确定" forState:UIControlStateNormal];
    [domeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [domeButton setBackgroundColor:UIColorFromRGB(0xffa30b)];
    [domeButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    domeButton.layer.cornerRadius = 8.0;
    
    [hederView addSubview:domeButton];
    [hederView addSubview:cancelButton];
    [hederView addSubview:oddsLabel];
    [hederView addSubview:addButton];
    [hederView addSubview:drinksNumLabel];
    [hederView addSubview:deletebutton];
}



#pragma  mark - tableViewMethon

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger row;
    
    if (tableView.tag == TableViewType_DeskInfo) {
        //选择桌号、佳丽、客户经理
        
        row = self.deskInfoArray.count;
    }else{
        //选择下注酒水
        row = self.drinkArray.count;
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
        managerNumberLb.text = manager;

        
    }else{
        
        cell.textLabel.font = [UIFont systemFontOfSize:TableViewCellFontSize];
        cell.textLabel.text = self.drinkArray[indexPath.row][@"name"];
    }
    
    
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hederView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TableViewCellHeight+1)];
    hederView.backgroundColor = [UIColor whiteColor];
    if (tableView.tag == TableViewType_DeskInfo) {
        //选择桌信息列表
        [self configurationDeskTableHederView:hederView];
        
    }else{
        [self configurationBetTableHederView:hederView];
        
    }
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, TableViewCellHeight, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xd0d0d0);
    [hederView addSubview:lineView];
    
    return hederView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return TableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableViewCellHeight;
}






////======================
//- (NSMutableArray *)deskInfoArray{
//    if (!_deskInfoArray) {
//        _deskInfoArray = [NSMutableArray array];
//        for (int i = 0; i < 20; i ++) {
//            DeskInfoModel *model = [[DeskInfoModel alloc]init];
//            model.deskNumber = [NSString stringWithFormat:@"%@",@(i+15)];
//            model.jiali = [NSString stringWithFormat:@"%@",@(i + 9660)];
//            model.manager = [NSString stringWithFormat:@"0%@",@(i + 121)];
//            [_deskInfoArray addObject:model];
//        }
//    }
//    
//    return _deskInfoArray;
//}
//
//- (NSMutableArray *)betInfoArray{
//    if (!_betInfoArray) {
//        _betInfoArray = [@[@"黄鸡礼炮",@"XO",@"威士忌",@"贵州茅台",@"五粮液"] mutableCopy];
//    }
//    return _betInfoArray;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
