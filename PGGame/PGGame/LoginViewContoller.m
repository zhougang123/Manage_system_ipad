//
//  LoginViewContoller.m
//  PGGame
//
//  Created by RIMI on 15/9/26.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "LoginViewContoller.h"
#import "MainViewController.h"

#define KdemoUserName @"pg001"
#define KdemoPassWord @"111111"

@interface LoginViewContoller ()<UITextFieldDelegate>
{
    UITextField *passwordTf;
    UITextField *userNameTf;
}
@end

@implementation LoginViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI{
    
    self.view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    self.title = @"登陆";
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 20 * BILI_WIDTH + 64, SCREEN_WIDTH, 50 * BILI_WIDTH +2)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelHeight = (contentView.frame.size.height - 2)/2;
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, labelHeight , SCREEN_WIDTH, 2)];
    lineView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    //label
    UILabel *userNameLb = [[UILabel alloc]initWithFrame:CGRectMake(15 * BILI_WIDTH,  0 , 50 * BILI_WIDTH, labelHeight)];
    UILabel *passwordLb = [[UILabel alloc]initWithFrame:CGRectMake(15 * BILI_WIDTH, CGRectGetMaxY(lineView.frame), 50 * BILI_WIDTH, labelHeight)];
    userNameLb.text = @"工号";
    userNameLb.font = [UIFont systemFontOfSize:10 * BILI_WIDTH];
    passwordLb.text = @"密码";
    passwordLb.font = [UIFont systemFontOfSize:10 * BILI_WIDTH];
    
    
    //textield
    userNameTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMidX(userNameLb.frame) + 10 * BILI_WIDTH, 0, 250 *BILI_WIDTH, CGRectGetHeight(userNameLb.frame))];
    passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(userNameTf.frame.origin.x, passwordLb.frame.origin.y, userNameTf.frame.size.width, userNameTf.frame.size.height)];
    
    //=======
    userNameTf.text = KdemoUserName;
    passwordTf.text = KdemoPassWord;
    
    userNameTf.delegate = self;
    passwordTf.delegate = self;
    userNameTf.tag = 100;
    passwordTf.tag = 200;
    userNameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTf.secureTextEntry = YES;
    
//    hud = [[SVProgressHUD alloc]init];
    
    [contentView addSubview:lineView];
    [contentView addSubview:userNameLb];
    [contentView addSubview:passwordLb];
    [contentView addSubview:userNameTf];
    [contentView addSubview:passwordTf];
    [self.view addSubview:contentView];
    
    UIButton *confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBut.frame = CGRectMake(0, 0, 30 * BILI_WIDTH, 20 * BILI_WIDTH);
    [confirmBut setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmBut.titleLabel.font = [UIFont systemFontOfSize:17];
    [confirmBut addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:confirmBut];
    self.navigationItem.rightBarButtonItem = item;
}


//登陆按钮点击
- (void)loginButtonAction{
    NSLog(@"登陆");
    
    [SVProgressHUD show];
    
    WS(weakself);
    [GMNetWorking loginWithUserName:userNameTf.text andPassword:passwordTf.text completion:^(id obj) {
        
        [SVProgressHUD showInfoWithStatus:@"登陆成功"];
        
        PGUser *user = obj;
        if (user.isFirstLogin) {
            
            
        }else{
            MainViewController *maiViewC = [[MainViewController alloc]init];
            
            UINavigationController *mainNavi = [[UINavigationController alloc]initWithRootViewController:maiViewC];
            
            [weakself.navigationController presentViewController:mainNavi animated:YES completion:nil];
        }
        
        
        
        
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
        
    }];
    
    MainViewController *maiViewC = [[MainViewController alloc]init];
    
    UINavigationController *mainNavi = [[UINavigationController alloc]initWithRootViewController:maiViewC];
    
    [weakself.navigationController presentViewController:mainNavi animated:YES completion:nil];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


#pragma  mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == 100) {
        [passwordTf becomeFirstResponder];
    }else{
        [self loginButtonAction];
    }
    
    return YES;
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
