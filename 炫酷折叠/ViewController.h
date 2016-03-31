//
//  ViewController.h
//  炫酷折叠
//
//  Created by Luis on 16/1/28.
//  Copyright © 2016年 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "foldTableViewCell.h"

@interface ViewController : UIViewController

@property (strong, nonatomic)  UITableView *testTableView;

- (foldTableViewCell *)tableViewCellForThing:(NSIndexPath *)indexPath;

@end

