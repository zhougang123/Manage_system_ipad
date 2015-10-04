//
//  NSDictionary+PGDictionary.m
//  ManageSystem
//
//  Created by RIMI on 15/10/4.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "NSDictionary+PGDictionary.h"

@implementation NSDictionary (PGDictionary)


- (id)objectforNotNullKey:(id)akey{
    
    id obj = [self objectForKey:akey];
    if ([obj isKindOfClass:[NSNull class]]) {
        return [NSNumber numberWithFloat:0.00];
    }else{
        return obj;
    }
}

@end
