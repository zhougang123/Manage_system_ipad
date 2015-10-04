//
//  GuessSureAlertView.h
//  PGGame
//
//  Created by mac on 15/10/4.
//  Copyright © 2015年 qfpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessSureAlertView : UIView



- (id)initWithGuessArray:(NSArray *)infoArray;

- (void)show;

- (void)dismiss;
@end
