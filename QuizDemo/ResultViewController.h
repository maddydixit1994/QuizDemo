//
//  ResultViewController.h
//  QuizDemo
//
//  Created by Revonomics on 10/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnReview;

@property (nonatomic, readwrite) NSInteger score;
@end
