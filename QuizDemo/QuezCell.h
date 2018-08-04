//
//  QuezCell.h
//  QuizDemo
//
//  Created by Revonomics on 07/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuezCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblQuestionNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@property (weak, nonatomic) IBOutlet UILabel *lblOptionA;
@property (weak, nonatomic) IBOutlet UILabel *lblOptionB;
@property (weak, nonatomic) IBOutlet UILabel *lblOptionC;

@property (weak, nonatomic) IBOutlet UIImageView *imgOptionA;
@property (weak, nonatomic) IBOutlet UIImageView *imgOptionB;
@property (weak, nonatomic) IBOutlet UIImageView *imgOptionC;

@property (weak, nonatomic) IBOutlet UIView *viewOptions;

@property (weak, nonatomic) IBOutlet UIView *viewOptionA;
@property (weak, nonatomic) IBOutlet UIView *viewOptionB;
@property (weak, nonatomic) IBOutlet UIView *viewOptionC;

@property (weak, nonatomic) IBOutlet UIButton *btnNextOrSubmit;

@property (retain, nonatomic) UITapGestureRecognizer *tapViewOptionA;
@property (retain, nonatomic) UITapGestureRecognizer *tapViewOptionB;
@property (retain, nonatomic) UITapGestureRecognizer *tapViewOptionC;

@property (weak, nonatomic) NSString *strAnswer;
@property (weak, nonatomic) NSString *strSelectedOption;

- (void)setQuizDataWith:(NSDictionary *)data IsEditable:(BOOL)isEditable;
- (void)setQuestionNumberLabelTextWith:(NSString *)strQuestionNumber;
- (void)setNextOrSubmitButtonTitleWith:(NSString *)strButtonTitle;
- (BOOL)checkAnswer;
- (void)clearOptions;

@end
