//
//  CustomView.h
//  QuizDemo
//
//  Created by Revonomics on 20/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *containtView;

- (void)setLableTitle:(NSString *)strTitle;
- (void)setViewBorderWidth:(float)width;
- (void)setViewCornerRadius:(float)corner;
- (void)setViewBorderColor:(UIColor *)color;

@end
