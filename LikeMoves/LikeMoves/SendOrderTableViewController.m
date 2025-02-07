//
//  SendOrderTableViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-11-11.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "SendOrderTableViewController.h"

@interface SendOrderTableViewController ()

@end

@implementation SendOrderTableViewController
NSArray* carts;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[[LMShopBL alloc] init];
    carts=(NSArray*)[_dict objectForKey:@"shopping_carts"];
    UIView* view =[ [UIView alloc]init];
    view.backgroundColor= [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return carts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: cellIdentifier];
    }
    //昵称、当天运动时长、当月已运动天数、金币数量
    UILabel* name=(UILabel*)[cell viewWithTag:1];
    UILabel* price=(UILabel*)[cell viewWithTag:2];
    UILabel* size=(UILabel*)[cell viewWithTag:3];
    UILabel* num=(UILabel*)[cell viewWithTag:4];
    NSDictionary* friend=[carts objectAtIndex:indexPath.row];
    name.text=[friend objectForKey:@"name"];
    price.text=[NSString stringWithFormat:@"￥%0.2f",[[friend objectForKey:@"price"] floatValue]];
    size.text=[friend objectForKey:@"comment"];
    num.text=[NSString stringWithFormat:@"X%@",[friend objectForKey:@"number"]];
    UIImageView* img=(UIImageView*)[cell viewWithTag:5];
    NSArray* roll=(NSArray*)[friend objectForKey:@"roll_pics" ];
    NSDictionary* dict=[roll objectAtIndex:0];
    NSString* url=[NSString stringWithFormat:PicUrlString,[dict objectForKey:@"pic"]];
    [img sd_setImageWithURL:[NSURL URLWithString:url ] placeholderImage:[UIImage imageNamed:@"img_nil.png"]];
    img.layer.cornerRadius = 15;
    img.layer.masksToBounds = YES;
    return cell;
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow]animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmReceipt:(id)sender {
    NSString* order_id=[_dict objectForKey:@"id"];
    [_bl confirmReceiptWithOrderID:order_id];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"确认收货成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
