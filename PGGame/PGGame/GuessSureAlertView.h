//
//  GuessSureAlertView.h
//  PGGame
//
//  Created by mac on 15/10/4.
//  Copyright © 2015年 qfpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuessSureAlertViewDelegate <NSObject>

- (void)guessSureAlertSubmitToServer;

@end


@interface GuessSureAlertView : UIView


@property (nonatomic, weak)id<GuessSureAlertViewDelegate>delegate;

- (id)initWithGuessArray:(NSArray *)infoArray;

- (void)show;

- (void)dismiss;
@end
