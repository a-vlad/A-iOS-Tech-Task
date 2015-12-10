//
//  ViewController.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "ViewController.h"

#import "AMessageConstruct.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, weak) IBOutlet UITextView *chatTextView;
@property (nonatomic, weak) IBOutlet UITextView *jsonTextView;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // subscribe to keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self updateJsonText];
}

- (void)dealloc
{
    // unsubscribe from notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//=============================================
#pragma mark - UIKeyboard Notification Handling
//=============================================

- (void)keyboardWillHide:(NSNotification *)n
{
    // resize views
    self.bottomConstraint.constant = 0;
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // get the size of the keyboard
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSNumber *animationLength = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]; // so we can sync up animation
    
    // resize views
    self.bottomConstraint.constant = keyboardSize.height;
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:animationLength.floatValue animations:^{
        [self.view layoutIfNeeded];
    }];
}


//====================================
#pragma mark - UITextViewDelegate
//====================================

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.chatTextView)
    {
        [self updateJsonText];
    }
}


//====================================
#pragma mark - Private Helpers
//====================================

/**
 *  Checks input text and updates json representation textview
 */
- (void)updateJsonText
{
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:self.chatTextView.text];
    self.jsonTextView.text = [construct jsonString];
}

@end
