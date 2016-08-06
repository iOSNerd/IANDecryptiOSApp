//
//  ViewController.m
//  getAppBundle
//
//  Created by ian on 16/7/4.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic , strong) UITextView *textView;

@end

@implementation ViewController

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _textView.editable = NO;
    }
    return _textView;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textView.text = _text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textView];
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[_textView]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-1-[_textView]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    self.navigationItem.title = @"App 详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
}

- (void)share
{
    if (self.textView.text.length == 0) {
        return;
    }
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:@[self.textView.text] applicationActivities:nil];
    
    NSArray *excluded = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter,UIActivityTypePostToWeibo];
    controller.excludedActivityTypes = excluded;
    
    
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
    
    
    // and present it
    [self presentViewController:controller animated:YES completion:^{
        // executes after the user selects something
    }];
    
}

//- (void)copyText:(id)sender
//{
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.textView.text;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
