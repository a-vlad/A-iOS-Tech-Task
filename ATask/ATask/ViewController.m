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

@property (nonatomic, strong) AMessageConstruct *stringConstruct;

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

- (void)keyboardWillHide:(NSNotification *)notification
{
    // get the size of the keyboard
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *animationLength = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]; // so we can sync up animation
    
    // resize views
    self.bottomConstraint.constant = 0;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationLength.floatValue animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    // get the size of the keyboard
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSNumber *animationLength = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]; // so we can sync up animation
    
    // resize views
    self.bottomConstraint.constant = keyboardSize.height;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationLength.floatValue animations:^{
        [self.view layoutIfNeeded];
    }];
}


//====================================
#pragma mark - UITextViewDelegate
//====================================

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.chatTextView) {
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
    // remove all KVO for current string construct
    for (AURL *url in self.stringConstruct.urls)
        [url removeObserver:self forKeyPath:@"urlTitle"];
    
    self.stringConstruct = [[AMessageConstruct alloc] initWithString:self.chatTextView.text];
    self.jsonTextView.text = [self.stringConstruct jsonString];
    
    // set KVO for all URLs so we can update UI when they have been updated
    for (AURL *url in self.stringConstruct.urls) {
        [url addObserver:self
              forKeyPath:@"urlTitle"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    }
}

/**
 *  KVO observer method called when change is detected
 */
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    // update json string textview with newly resolved urlTitle
    if ([keyPath isEqualToString:@"urlTitle"]) {
        // ui changes must be done from main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.jsonTextView.text = [self.stringConstruct jsonString];
        });
    }
}

@end
