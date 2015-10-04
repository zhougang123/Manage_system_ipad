//
//  ModifyPwdViewController.m
//  PGGame
//
//  Created by mac on 15/10/4.
//  Copyright © 2015年 qfpay. All rights reserved.
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()

@property (nonatomic, strong) UITextField *pwdTF1;
@property (nonatomic, strong) UITextField *pwdTF2;

@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首次登录修改密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = UIColorFromRGB(0xECECEF);
    
    UIView *loginBGView = [[UIView alloc] initWithFrame:CGRectMake(-2, 60, SCREEN_WIDTH + 4, 140)];
    loginBGView.backgroundColor = [UIColor whiteColor];
    loginBGView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginBGView.layer.borderWidth = 0.5;
    
    UIView *greyLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(loginBGView.frame)/2.0, SCREEN_WIDTH+4, 1)];
    greyLine.backgroundColor = UIColorFromRGB(0xECECEF);
    
    
    
    UILabel *accountTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 120, 70)];
    accountTitle.textColor = [UIColor blackColor];
    accountTitle.textAlignment = NSTextAlignmentLeft;
    accountTitle.font = [UIFont systemFontOfSize:20];
    accountTitle.text = @"新密码:";
    
    UILabel *pwdTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 70, 120, 70)];
    pwdTitle.textColor = [UIColor blackColor];
    pwdTitle.textAlignment = NSTextAlignmentLeft;
    pwdTitle.font = [UIFont systemFontOfSize:20];
    pwdTitle.text = @"确定密码:";
    
    
    self.pwdTF1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTitle.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(accountTitle.frame) - 30, 70)];
    self.pwdTF1.borderStyle = UITextBorderStyleNone;
    self.pwdTF1.font = [UIFont systemFontOfSize:15 * BILI_WIDTH];
    self.pwdTF1.secureTextEntry = YES;
    
    self.pwdTF2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTitle.frame), 70, SCREEN_WIDTH - CGRectGetMaxX(accountTitle.frame) - 30, 70)];
    self.pwdTF2.borderStyle = UITextBorderStyleNone;
    self.pwdTF2.font = [UIFont systemFontOfSize:15 * BILI_WIDTH];
    self.pwdTF2.secureTextEntry = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyBoard)];
    
    [loginBGView addSubview:accountTitle];
    [loginBGView addSubview:self.pwdTF1];
    [loginBGView addSubview:pwdTitle];
    [loginBGView addSubview:self.pwdTF2];
    
    [loginBGView addSubview:greyLine];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:loginBGView];
    
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)saveAction{
    if (self.pwdTF1.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (self.pwdTF1.text.length > 18) {
        [SVProgressHUD showErrorWithStatus:@"密码不能大于18位"];
        return;
    }
    
    if (self.pwdTF2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请确认密码"];
        return;
    }
    if (self.pwdTF2.text.length > 18) {
        [SVProgressHUD showErrorWithStatus:@"密码不能大于18位"];
        return;
    }
    WS(weakSelf);
    
    [SVProgressHUD show];

    if ([self.pwdTF1.text isEqualToString:self.pwdTF2.text]) {
        [GMNetWorking modifPasswordWithTimeout:30 password:self.pwdTF1.text waiterId:[NSString stringWithFormat:@"%@", self.user.userID] completion:^(id obj) {
            [SVProgressHUD  showSuccessWithStatus:@"修改密码成功, 请重新登录"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        } fail:^(NSString *error) {
            [SVProgressHUD  showSuccessWithStatus:@"修改密码失败"];

        }];
    }
    
    
    [self.view endEditing:YES];
}
- (void)cancelKeyBoard
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
