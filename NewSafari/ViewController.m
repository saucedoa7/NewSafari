//
//  ViewController.m
//  NewSafari
//
//  Created by Albert Saucedo on 9/23/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *featureButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property CGFloat yOffset;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.URLTextField.delegate = self;
    self.webView.scrollView.delegate = self;
    self.URLTextField.alpha = 1;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}



-(void)webViewDidFinishLoad:(UIWebView *)webView{

    self.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

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

    // Displays current url in textfield
    NSURLRequest *currentRequest = [webView request];
    NSURL *currentUrl = [currentRequest URL];
    self.URLTextField.text = currentUrl.absoluteString;

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.URLTextField resignFirstResponder];

    if ([self.URLTextField.text hasPrefix:@"http://"]) {

        NSString *urlString =  self.URLTextField.text;
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    } else {
        NSString *http = @"http://google.com";
        NSString *urlString = [http stringByAppendingString:self.URLTextField.text];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
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
- (IBAction)onNewFeatureButtonPressed:(UIButton *)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.yOffset = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.yOffset >= scrollView.contentOffset.y) {

        [UIView animateWithDuration:1.5 animations:^{
            self.URLTextField.transform = CGAffineTransformMakeTranslation(0, 0);
            self.titleLabel.hidden = YES;
            self.titleLabel.alpha = 0.0;
            self.URLTextField.alpha = 1;
            self.URLTextField.hidden = NO;
        }];

    } else {

        [UIView animateWithDuration:1.5 animations:^{
            self.URLTextField.transform = CGAffineTransformMakeTranslation(0, 0);
            self.URLTextField.hidden = YES;
            self.URLTextField.alpha = 0.0;
            self.titleLabel.alpha = 1;
            self.titleLabel.hidden = NO;
        }];
    }
}

@end
