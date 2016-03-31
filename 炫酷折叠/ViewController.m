//
//  ViewController.m
//  炫酷折叠
//
//  Created by Luis on 16/1/28.
//  Copyright © 2016年 Luis. All rights reserved.
//

#import "ViewController.h"
#import "foldTableViewCell.h"

static const CGFloat kCloseCellHeight  = 179;
static const CGFloat kOpenCellHeight = 488;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    NSMutableArray *heightArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bg.image = [UIImage imageNamed:@"main_background"];
    [self.view addSubview:bg];
    
    self.testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.testTableView.delegate = self;
    self.testTableView.dataSource = self;
    self.testTableView.separatorStyle = 0;
    self.testTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.testTableView];
    
    [self.testTableView registerNib:[UINib nibWithNibName:NSStringFromClass([foldTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    heightArray = [NSMutableArray array];
    
    for (int i=0; i < 5; i++) {
        [heightArray addObject:[NSNumber numberWithFloat:kCloseCellHeight]];
    }
    [self.testTableView reloadData];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(foldTableViewCell *)tableViewCellForThing:(NSIndexPath *)indexPath
{
    if (indexPath.row== NSNotFound) {
        return nil;
    }
    return (foldTableViewCell*)[self.testTableView cellForRowAtIndexPath:indexPath];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [heightArray[indexPath.row] floatValue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    foldTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[foldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([heightArray[indexPath.row] floatValue]==kCloseCellHeight) {
        [cell selectedAnimation:NO animated:NO completion:nil];
    }else
    {
        [cell selectedAnimation:YES animated:NO completion:nil];
    }
    [cell fold_imageTap:^{
        
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    foldTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([cell isAnimating]) return;
    
    CGFloat durtion=0.0;
    if([heightArray[indexPath.row] floatValue]==kCloseCellHeight)
    {
        [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kOpenCellHeight]];
        durtion=0.3;
        [cell selectedAnimation:YES animated:YES completion:^{
            NSLog(@"完成了");
        }];
    }else
    {
        durtion=[cell returnSumTime];
        [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kCloseCellHeight]];
        [cell selectedAnimation:NO animated:YES completion:^{
            
        }];
    }
    [UIView animateWithDuration:durtion+0.3 animations:^{
        [self.testTableView beginUpdates];
        [self.testTableView endUpdates];
    }];
}
@end
