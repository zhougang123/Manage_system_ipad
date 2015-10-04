//
//  GMNetWorking.m
//  PGGame
//
//  Created by RIMI on 15/9/29.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "GMNetWorking.h"
#import "JsonParser.h"

@implementation GMNetWorking


+ (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password completion:(callBack)callBack fail:(ErrorString)errorString
{
    NSString *path = [APIaddress stringByAppendingString:APIlogin];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPRequestOperationManager *manager = [GMNetWorking getManagerWithTimeout:15];
    NSDictionary *parameter = @{@"workNumber":userName,@"password":password};

    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeClear];
    [manager GET:path parameters:parameter success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"登陆:/n%@",responseObject);
        
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            PGUser *user = [JsonParser parserUserDic:[responseObject objectForKey:@"data"]];
            callBack(user);
            
        }else{
            //失败
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            errorString([responseObject objectForKey:@"msg"]);
        }
        
        
        
    } failure:^ (AFHTTPRequestOperation * operation, NSError * error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
         NSLog(@"fail 登陆:%@",[error description]);
        errorString(@"网络不好,请稍后再试");
        
    }];
    
    
}



+ (void)getDeskListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString{
    
    NSString *path = [APIaddress stringByAppendingString:APIdeskList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [ self getManagerWithTimeout:timeout];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"桌信息:/n%@",responseObject);
        
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            callBack(responseObject);
        }else{
            //失败
            errorString([responseObject objectForKey:@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorString(error.localizedDescription);
    }];

}


+ (void)getBeautyListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString{
    
    NSString *path = [APIaddress stringByAppendingString:APIbeautyList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"桌信息:/n%@",responseObject);
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            callBack(responseObject);
        }else{
            //失败
            errorString([responseObject objectForKey:@"msg"]);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorString(error.localizedDescription);
    }];
    
}

+ (void)getManagerListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString{
    
    NSString *path = [APIaddress stringByAppendingString:APImanagerList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"桌信息:/n%@",responseObject);
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            callBack(responseObject);
        }else{
            //失败
            errorString([responseObject objectForKey:@"msg"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorString(error.localizedDescription);
    }];
    
}


+ (void)submitGuessInfoWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString{
    
    NSString *path = [APIaddress stringByAppendingString:APImanagerList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"桌信息:/n%@",responseObject);
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


//+ (void)getDrinkListWithTimeout:(NSTimeInterval)timeout  completion:(callBack)callBack fail:(ErrorString)errorString
//{
//    
//    NSString *path = [APIaddress stringByAppendingString:APIDrinkList];
//    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = timeout;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"桌信息:/n%@",responseObject);
//        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
//        if (respondCode == 200) {
//            //成功
//            callBack(responseObject);
//        }else{
//            //失败
//            errorString([responseObject objectForKey:@"msg"]);
//        }
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//     
//        NSLog(@"fail 卓信息:%@",[error description]);
//        errorString(@"网络不好,请稍后再试");
//        
//    }];
//
//}




+ (void)getBetTypeAndOddsListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString
{
    
    NSString *path = [APIaddress stringByAppendingString:APIoddsList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [self getManagerWithTimeout:timeout];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"赔率列表:/n%@",responseObject);
        
        
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            NSArray *betArray = [[JsonParser parserBetAndOddsArray:[responseObject objectForKey:@"data"]] mutableCopy];
            callBack(betArray);
            
        }else{
            //失败
            errorString([responseObject objectForKey:@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail 赔率列表:%@",[error description]);
        errorString(@"网络不好,请稍后再试");
    }];
    
    
    
}




+ (void)getDrinksListWithTimeout:(NSTimeInterval)timeout completion:(callBack)callBack fail:(ErrorString)errorString{
    
    
    NSString *path = [APIaddress stringByAppendingString:APIdrinksList];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [self getManagerWithTimeout:timeout];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"酒水列表:/n%@",responseObject);
        
        
        NSInteger respondCode = [[responseObject objectForKey:@"code"] integerValue];
        if (respondCode == 200) {
            //成功
            NSArray *drinksArray = [[JsonParser parserDrinksArray:[responseObject objectForKey:@"data"]] mutableCopy];
            callBack(drinksArray);
            
        }else{
            //失败
            errorString([responseObject objectForKey:@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fail 酒水列表:%@",[error description]);
        errorString(@"网络不好,请稍后再试");
        
    }];
    
    
}





+ (AFHTTPRequestOperationManager *)getManagerWithTimeout:(NSTimeInterval)secennd{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = secennd ;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return manager;
}






@end
