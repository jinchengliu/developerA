//
//  CustomTextView.h
//  Teaseat
//
//  Created by chen wang on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UIView <UITextViewDelegate> {
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UITextView *textView;
    IBOutlet UILabel *placeholderLabel;
    IBOutlet UIButton *clearTextButton;
    IBOutlet UILabel *wordCountLabel;
}

@property (nonatomic, assign) NSString *placeholder;
@property (nonatomic, assign) NSString *text;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)clearTextAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *wordCountLabel;

- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;

@end
