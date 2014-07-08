//
//  mainViewController.m
//  week 3 homework
//
//  Created by Josh Sassoon on 7/6/14.
//  Copyright (c) 2014 youtubeux. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UIView *headline1View;
@property (weak, nonatomic) IBOutlet UIView *headline2View;
@property (weak, nonatomic) IBOutlet UIView *headline3View;
@property (weak, nonatomic) IBOutlet UIView *headlineContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *newsScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer;
//- (void)onNewsPan:(UIPanGestureRecognizer *)panGestureRecognizer;
//- (void)onNewsPan:(UILongPressGestureRecognizer *)longPressGestureRecognizer;

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)animateHeadlineThree {
    self.headline1View.center = CGPointMake(-160,self.headline1View.center.y);
    [UIView animateWithDuration:.5 animations:^{
        self.headline3View.frame = CGRectMake(320, self.headline3View.frame.origin.y, self.headline3View.frame.size.width, self.headline3View.frame.size.height);
        self.headline1View.frame = CGRectMake(0, self.headline1View.frame.origin.y, self.headline1View.frame.size.width, self.headline1View.frame.size.height);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(animateHeadlineOne) withObject:nil afterDelay:2];
    }];
    
}

- (void)animateHeadlineTwo {
    self.headline3View.center = CGPointMake(-160,self.headline3View.center.y);
    [UIView animateWithDuration:.5 animations:^{
        self.headline2View.frame = CGRectMake(320, self.headline2View.frame.origin.y, self.headline2View.frame.size.width, self.headline2View.frame.size.height);
        self.headline3View.frame = CGRectMake(0, self.headline3View.frame.origin.y, self.headline3View.frame.size.width, self.headline3View.frame.size.height);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(animateHeadlineThree) withObject:nil afterDelay:2];
    }];
    
}

- (void)animateHeadlineOne {
    self.headline2View.center = CGPointMake(-160,self.headline2View.center.y);
        [UIView animateWithDuration:.5 animations:^{
            self.headline1View.frame = CGRectMake(320, self.headline1View.frame.origin.y, self.headline1View.frame.size.width, self.headline1View.frame.size.height);
            self.headline2View.frame = CGRectMake(0, self.headline2View.frame.origin.y, self.headline2View.frame.size.width, self.headline2View.frame.size.height);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(animateHeadlineTwo) withObject:nil afterDelay:2];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCustomPan:)];
    [self.headlineContainer addGestureRecognizer:panGestureRecognizer];
    
    /*
    UILongPressGestureRecognizer *newsScrollGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onNewsPan:)];
    [self.newsImage addGestureRecognizer:newsScrollGestureRecognizer];
    */
     
    //UILongPressGestureRecognizer

    /*
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onNewsTap:)];
    [self.newsImage addGestureRecognizer:tapGestureRecognizer];
     */
    /*
    UIPanGestureRecognizer *newspanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onNewsPan:)];
    [self.newsImage addGestureRecognizer:newspanGestureRecognizer];
     */
    
    self.newsScrollView.contentSize = CGSizeMake(1445, 253);
    [self performSelector:@selector(animateHeadlineOne) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void)onNewsPan:(UILongPressGestureRecognizer *)newsScrollGestureRecognizer  {
    NSLog(@"hi");
}
 */

/*

- (void)onNewsPan:(UIPanGestureRecognizer *)newspanGestureRecognizer {
//    NSLog(@"hi");
    CGPoint point = [newspanGestureRecognizer locationInView:self.newsImage];
    if (newspanGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
        //NSLog(@"began");
    } else if (newspanGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(point));
        self.newsImage.center = CGPointMake(self.newsImage.center.x, 127);
    } else if (newspanGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
    }
}
 
 */

- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer  {
    CGPoint point = [panGestureRecognizer locationInView:self.headlineContainer];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (velocity.y <= 0) {
            self.headlineContainer.center = CGPointMake(self.headlineContainer.center.x, self.headlineContainer.center.y + (translation.y * .1));
        } else {
            self.headlineContainer.center = CGPointMake(self.headlineContainer.center.x, self.headlineContainer.center.y + (translation.y * 1.0));
        }
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
        if (velocity.y >= 0) {
            [UIView animateWithDuration:1 animations:^{
                 self.headlineContainer.frame = CGRectMake(0,520,320, 568);
            }];
           
        } else {
            [UIView animateWithDuration:1 animations:^{
                self.headlineContainer.frame = CGRectMake (0,0, 320, 568);
            }];
        }
    }

}

@end
