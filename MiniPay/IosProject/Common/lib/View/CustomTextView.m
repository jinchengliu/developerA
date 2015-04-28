//
//  CustomTextView.m
//  Teaseat
//
//  Created by chen wang on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView
@synthesize wordCountLabel;

@synthesize placeholder;
@synthesize text;
@synthesize backgroundImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    backgroundImageView.image = [[UIImage imageNamed:@"leftkuang.png"] stretchableImageWithLeftCapWidth:40 topCapHeight:20];//原来是inputFd.png
    placeholderLabel.hidden = YES;
    clearTextButton.hidden = YES;
    textView.text = nil;
    
    textView.backgroundColor=[UIColor clearColor];
}

- (NSString *)text {
    return textView.text;
}

- (void)setText:(NSString *)aText {
    textView.text = aText;
}

- (void)setPlaceholder:(NSString *)aPlaceholder {
    [placeholder autorelease];
    placeholder = [aPlaceholder retain];
    
    placeholderLabel.text = aPlaceholder;
    placeholderLabel.hidden = NO;
    
    CGSize size = [placeholderLabel.text sizeWithFont:placeholderLabel.font constrainedToSize:CGSizeMake(placeholderLabel.frame.size.width, 9999)];
    CGRect frame = placeholderLabel.frame;
    frame.size.height = size.height;
    placeholderLabel.frame = frame;
    placeholderLabel.numberOfLines = 0;
}

- (void)textViewDidChange:(UITextView *)aTextView {
    int maxLength = 140;
    
    NSString *strTemp = [[NSString alloc] initWithFormat:@"%d",maxLength-textView.text.length];
    wordCountLabel.text = strTemp;
    [strTemp release];
    
    clearTextButton.hidden = (textView.text.length == 0);
//    placeholderLabel.hidden = (textView.text.length > 0); 
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    placeholderLabel.hidden = YES;
    return YES;
}

- (BOOL)becomeFirstResponder {
    return [textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [textView resignFirstResponder];
}
- (void)dealloc {
    [backgroundImageView release];
    [textView release];
    [placeholderLabel release];
    [clearTextButton release];
    [wordCountLabel release];
    
    [super dealloc];
}
- (IBAction)clearTextAction:(id)sender {
    textView.text=@"";
}
@end
