//
//  QuezCell.m
//  QuizDemo
//
//  Created by Revonomics on 07/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import "QuezCell.h"

@implementation QuezCell

@synthesize lblQuestionNumber;
@synthesize lblQuestion;
@synthesize lblOptionA;
@synthesize lblOptionB;
@synthesize lblOptionC;
@synthesize imgOptionA;
@synthesize imgOptionB;
@synthesize imgOptionC;
@synthesize viewOptionA;
@synthesize viewOptionB;
@synthesize viewOptionC;
@synthesize btnNextOrSubmit;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // set default button Disable
    [btnNextOrSubmit setEnabled:NO];

    // Initialization code
    [viewOptionA setBackgroundColor:[UIColor clearColor]];
    [viewOptionB setBackgroundColor:[UIColor clearColor]];
    [viewOptionC setBackgroundColor:[UIColor clearColor]];
    
    self.tapViewOptionA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSelectionRecognizer:)];
    self.tapViewOptionB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSelectionRecognizer:)];
    self.tapViewOptionC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSelectionRecognizer:)];
    
    [[self.viewOptions layer] setMasksToBounds:YES];
    [[self.viewOptions layer] setCornerRadius:5];
    [[self.viewOptions layer] setBorderWidth:0.5];
    [[self.viewOptions layer] setBorderColor:[UIColor grayColor].CGColor];
    
    // set corner radius for NextORSubmit Button
    [[btnNextOrSubmit layer] setMasksToBounds:YES];
    [[btnNextOrSubmit layer] setCornerRadius:5];

}


- (void)optionSelectionRecognizer:(UITapGestureRecognizer *)recognizer {
    if (self.tapViewOptionA == recognizer) {
        NSLog(@"Option A Selected..");
        self.strSelectedOption = lblOptionA.text;
        [viewOptionA setBackgroundColor:[UIColor colorWithRed:244/255.0 green:217/255.0 blue:255/255.0 alpha:1.0]];
        [viewOptionB setBackgroundColor:[UIColor clearColor]];
        [viewOptionC setBackgroundColor:[UIColor clearColor]];
        
        [imgOptionA setImage:[UIImage imageNamed:@"icon_select"]];
        [imgOptionB setImage:[UIImage imageNamed:@"icon_unselect"]];
        [imgOptionC setImage:[UIImage imageNamed:@"icon_unselect"]];
        
    } else if (self.tapViewOptionB == recognizer) {
        NSLog(@"Option B Selected..");
        self.strSelectedOption = lblOptionB.text;
        [viewOptionA setBackgroundColor:[UIColor clearColor]];
        [viewOptionB setBackgroundColor:[UIColor colorWithRed:244/255.0 green:217/255.0 blue:255/255.0 alpha:1.0]];
        [viewOptionC setBackgroundColor:[UIColor clearColor]];
        
        [imgOptionA setImage:[UIImage imageNamed:@"icon_unselect"]];
        [imgOptionB setImage:[UIImage imageNamed:@"icon_select"]];
        [imgOptionC setImage:[UIImage imageNamed:@"icon_unselect"]];
        
    } else if (self.tapViewOptionC == recognizer) {
        NSLog(@"Option C Selected..");
        self.strSelectedOption = lblOptionC.text;
        [viewOptionA setBackgroundColor:[UIColor clearColor]];
        [viewOptionB setBackgroundColor:[UIColor clearColor]];
        [viewOptionC setBackgroundColor:[UIColor colorWithRed:244/255.0 green:217/255.0 blue:255/255.0 alpha:1.0]];
        
        [imgOptionA setImage:[UIImage imageNamed:@"icon_unselect"]];
        [imgOptionB setImage:[UIImage imageNamed:@"icon_unselect"]];
        [imgOptionC setImage:[UIImage imageNamed:@"icon_select"]];
        
    }
    
    [btnNextOrSubmit setEnabled:YES];
    NSLog(@"Selected Answer : %@",self.strSelectedOption);
}

- (void)setQuizDataWith:(NSDictionary *)data IsEditable:(BOOL)isEditable {
    
    NSString *strQuestion = [data valueForKey:@"question"];
    NSString *strOptionA = [data valueForKey:@"optionA"];
    NSString *strOptionB = [data valueForKey:@"optionB"];
    NSString *strOptionC = [data valueForKey:@"optionC"];
    NSString *strAnswer = [data valueForKey:@"answer"];
    
    NSLog(@"lblQuestion : %@",strQuestion);
    NSLog(@"lblOptionA : %@",strOptionA);
    NSLog(@"lblOptionB : %@",strOptionB);
    NSLog(@"lblOptionC : %@",strOptionC);
    NSLog(@"Answer : %@",strAnswer);
    
    lblQuestion.text = strQuestion;
    lblOptionA.text = strOptionA;
    lblOptionB.text = strOptionB;
    lblOptionC.text = strOptionC;
    self.strAnswer = strAnswer;
    
    if (isEditable) {
        NSLog(@"Is Editable");
        [self isEditable];
    } else {
        NSLog(@"Is Not Editable");
        [self isNotEditable];
    }
}

- (void)isEditable {
    [viewOptionA addGestureRecognizer:self.tapViewOptionA];
    [viewOptionB addGestureRecognizer:self.tapViewOptionB];
    [viewOptionC addGestureRecognizer:self.tapViewOptionC];
}

- (void)isNotEditable {
    // set button Enable
    [btnNextOrSubmit setEnabled:YES];
}

- (void)setQuestionNumberLabelTextWith:(NSString *)strQuestionNumber {
    lblQuestionNumber.text = strQuestionNumber;
}

- (void)setNextOrSubmitButtonTitleWith:(NSString *)strButtonTitle {
    [btnNextOrSubmit setTitle:strButtonTitle forState:UIControlStateNormal];
}

- (BOOL)checkAnswer
{
    BOOL isCorrect = false;
    if ([self.strSelectedOption isEqualToString:self.strAnswer])
    {
        isCorrect = true;
    } else {
        isCorrect = false;
    }
    return isCorrect;
}

- (void)clearOptions {
    // Initialization code
    [viewOptionA setBackgroundColor:[UIColor clearColor]];
    [viewOptionB setBackgroundColor:[UIColor clearColor]];
    [viewOptionC setBackgroundColor:[UIColor clearColor]];
    
    [imgOptionA setImage:[UIImage imageNamed:@"icon_unselect"]];
    [imgOptionB setImage:[UIImage imageNamed:@"icon_unselect"]];
    [imgOptionC setImage:[UIImage imageNamed:@"icon_unselect"]];
}

- (void)dealloc {
    NSLog(@"dealloc QuizCell....");
    if(self.tapViewOptionA)
    {
        [viewOptionA removeGestureRecognizer:self.tapViewOptionA];
        self.tapViewOptionA = nil;
    }
    
    if(self.tapViewOptionB)
    {
        [viewOptionB removeGestureRecognizer:self.tapViewOptionB];
        self.tapViewOptionB = nil;
    }
    
    if(self.tapViewOptionB)
    {
        [viewOptionC removeGestureRecognizer:self.tapViewOptionC];
        self.tapViewOptionC = nil;
    }
   
    self.strAnswer = nil;
    self.strSelectedOption = nil;
}

@end
