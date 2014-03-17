//
//  WebviewViewController.m
//  TicTacToe
//
//  Created by user on 3/15/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "WebviewViewController.h"

@interface WebviewViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *myWebview;


@end

@implementation WebviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    
    //
    NSString *url = @"http://en.wikipedia.org/wiki/Tic_tac_toe";
    
    //create an NSURL
    NSURL *urlString = [NSURL URLWithString:url];
    
    //create a NSURL requset
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    
    
    //load the request
    [self.myWebview loadRequest:request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //tell the main application to start the network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //tell the main application to start the network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}





@end
