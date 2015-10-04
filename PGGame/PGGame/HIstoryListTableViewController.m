//
//  HIstoryListTableViewController.m
//  PGGame
//
//  Created by RIMI on 15/10/4.
//  Copyright (c) 2015年 qfpay. All rights reserved.
//

#import "HIstoryListTableViewController.h"
#import "HistoryTableViewCell.h"

@interface HIstoryListTableViewController ()

@property (nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation HIstoryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xECECEF);
    [self netWorking];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)netWorking{
    
    [SVProgressHUD show];
    WS(weakself);
    [GMNetWorking getHistoryListWithTimeout:15 completion:^(id obj) {
        [SVProgressHUD dismiss];
        self.dataSource = [obj mutableCopy];
        
        NSMutableArray *indexArray = [NSMutableArray array];
        [weakself.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSArray *detailArray = [obj objectForKey:@"orderDetailVoList"];
            if (detailArray.count<=0) {
                [indexArray addObject:obj];
            }
        }];
        
        for (id obj in indexArray) {
            [weakself.dataSource removeObject:obj];
        }
        
        [weakself.tableView reloadData];
        
    } fail:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
    }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *array = @[@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)},@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)},@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)},@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)},@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)},@{@"oddsName":@"大 (8 - 12点)",@"oddsNumerator":@(1),@"oddsDenominator":@(18),@"drinkName":@"嘉士伯",@"drinkNum":@(12)}];
    
    CGFloat cellH = [cell drawTableCellWithDetials:array];
    CGRect frame = cell.frame;
    frame.size.height = cellH;
    cell.frame = frame;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryTableViewCell *cell = (HistoryTableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat height = cell.frame.size.height;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
