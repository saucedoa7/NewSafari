//
//  ViewController.m
//  NewSafari
//
//  Created by Albert Saucedo on 9/23/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.URLTextField.delegate = self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    if (self.webView.canGoBack) {
        self.backButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;
    }

    if (self.webView.canGoForward) {
        self.forwardButton.enabled = YES;
    } else {
        self.forwardButton.enabled = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.URLTextField resignFirstResponder];

    NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.com", self.URLTextField.text ];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSLog(@"%@", request);

    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

    return YES;
}
- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}
- (IBAction)onStopButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}

@end
