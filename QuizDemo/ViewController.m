//
//  ViewController.m
//  QuizDemo
//
//  Created by Revonomics on 07/07/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

typedef enum
{
    WeekdaySunday = 1,
    WeekdayMonday,
    WeekdayTuesday,
    WeekdayWednesday,
    WeekdayThursday,
    WeekdayFriday,
    WeekdaySaturday
} Weekday;

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSArray *arrQuizData;
    int score;
    BOOL isEditable;
    BOOL isViewDidLoaded;
}

@end

@implementation ViewController

@synthesize quizCell;

static NSString *identifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // default score ZERO
    score = 0;
    
    // default quiz is Editable
    isEditable = YES;
    
    // default set Viewdidloaded false
    isViewDidLoaded = NO;
    
    Weekday d = WeekdayTuesday;
    
    switch (d) {
        case WeekdaySunday:
            NSLog(@"You like sunday");
        break;
        case WeekdayMonday:
            NSLog(@"You like monday");
        break;
        case WeekdayTuesday:
            NSLog(@"You like Tuesday");
        break;
        case WeekdayWednesday:
            NSLog(@"You like Wednesday");
        break;
        case WeekdayThursday:
            NSLog(@"You like Thursday");
        break;
        case WeekdayFriday:
        NSLog(@"You like Friday");
        break;
        case WeekdaySaturday:
        NSLog(@"You like Saturday");
        break;
        default:
        
        break;
    }
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"QuizQuestions" ofType:@"plist"];
    arrQuizData = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
    NSLog(@"Question Data from plist file : \n %@",arrQuizData);
    NSLog(@"plist reading successfull");
    
    //Set Main Cell in Collection View
    [self.quizCollectionView registerNib:[UINib nibWithNibName:@"QuezCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    self.quizCollectionView.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set question count ONE
    self.lblQuestionCount.text = @"1/10";
    
    // default score ZERO
    score = 0;
    
    if (isViewDidLoaded) {
        // reload quiz collectionview once
        [self.quizCollectionView reloadData];
        
        // question move to first
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.quizCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
    
    isViewDidLoaded = YES;
}

- (IBAction)nextOrSubmitButtonAction:(UIButton *)sender {
    NSLog(@"Next Button Clicked...");
    [sender setEnabled:NO];
    
    NSArray *visibleItems = [self.quizCollectionView indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.row+1 inSection:currentItem.section];
    
    QuezCell *currentCell = (QuezCell *)[self.quizCollectionView cellForItemAtIndexPath:currentItem];
    
    if ([currentCell checkAnswer]) {
        score = score + 10;
    }
    
    if (nextItem.row <= arrQuizData.count-1) {
        
        QuezCell *cell = (QuezCell *)[self.quizCollectionView cellForItemAtIndexPath:nextItem];
        [cell clearOptions];
      
        [UIView animateWithDuration:0.2 animations:^{
            [self.quizCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        }];
    } else {
        // move next view controller
        NSLog(@"move to next view controller with score : %d",score);
        [self performSegueWithIdentifier:@"segue_result" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QuizCollectionView Delegete methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrQuizData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    quizCell = (QuezCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 
    NSDictionary *data = [arrQuizData objectAtIndex:indexPath.row];
    
    [quizCell clearOptions];
    
    [quizCell setQuizDataWith:data IsEditable:isEditable];
    
    [quizCell setQuestionNumberLabelTextWith:[NSString stringWithFormat:@"Question %ld",indexPath.row+1]];
    
    if (arrQuizData.count == indexPath.row+1) {
        [quizCell setNextOrSubmitButtonTitleWith:@"Submit Quiz"];
    } else {
        [quizCell setNextOrSubmitButtonTitleWith:@"Next Question"];
    }
    
    return quizCell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"display cell index : %ld",indexPath.row);
    self.lblQuestionCount.text = [NSString stringWithFormat:@"%d/10",(int)indexPath.row+1];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.quizCollectionView.frame.size.width, self.quizCollectionView.frame.size.height);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue_result"]) {
        ResultViewController *vc = [segue destinationViewController];
        vc.score = score;
    }
}

@end
