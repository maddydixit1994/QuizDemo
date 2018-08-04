//
//  ViewController.h
//  QuizDemo
//
//  Created by Revonomics on 07/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuezCell.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblQuestionCount;
@property (weak, nonatomic) IBOutlet UICollectionView *quizCollectionView;
@property (strong, nonatomic) QuezCell *quizCell;
@end

