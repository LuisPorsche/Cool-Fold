//
//  foldTableViewCell.h
//  testDemo
//
//  Created by Imac 21 on 16/1/8.
//  Copyright © 2016年 Imac 21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotatedView.h"

typedef void(^CompletionHandler)(void);

typedef enum : NSUInteger {
    Open,
    Close,
} AnimationType;

typedef void(^foldTapBlock)(void);
@interface foldTableViewCell : UITableViewCell

@property (strong, nonatomic)  RotatedView *foregroundView;
@property (strong, nonatomic)  UIView *containerView;
@property (strong, nonatomic)  NSLayoutConstraint *foregroundTopConstraint;
@property (strong, nonatomic)  NSLayoutConstraint *containerViewTopConstraint;

-(void)selectedAnimation:(BOOL )isSelected animated:(BOOL)animated completion:(CompletionHandler)completion;
-(BOOL)isAnimating;
-(CGFloat)returnSumTime;
-(void)fold_imageTap:(foldTapBlock)block;
@end
