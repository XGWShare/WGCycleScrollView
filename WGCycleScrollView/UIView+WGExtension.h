//
//  UIView+WGExtension.h
//  WGCycleScrollView
//
//  Created by weige on 16/11/22.
//  Copyright © 2016年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WGColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface UIView (WGExtension)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;
@property (nonatomic, assign) CGFloat sd_x;

@end
