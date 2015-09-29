//
//  GMNetWorking.m
//  PGGame
//
//  Created by RIMI on 15/9/29.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "GMNetWorking.h"

@implementation GMNetWorking

+ (void)getDeskListWithTimeout:(NSTimeInterval)timeout CallBack:(callBack)callBack AndErrorString:(ErrorString)errorString{
    
    NSString *path = [address stringByAppendingString:deskList];
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



@end
