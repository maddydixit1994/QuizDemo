//
//  CustomView.m
//  QuizDemo
//
//  Created by Revonomics on 20/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
@synthesize lblTitle;
@synthesize containtView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
    [self addSubview:containtView];
    [containtView setFrame:self.bounds];
    lblTitle.text = @"-NA-";
    [self.layer setMasksToBounds:YES];
}

- (void)setLableTitle:(NSString *)strTitle {
    lblTitle.text = strTitle?strTitle:@"-NA-";
}

- (void)setViewBorderWidth:(float)width {
    self.layer.borderWidth = width;
}

- (void)setViewCornerRadius:(float)corner {
    self.layer.cornerRadius = corner;
}

- (void)setViewBorderColor:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
}

@end
