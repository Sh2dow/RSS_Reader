//
//  BrowserViewController.m
//  RSSReader
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//

#import "BrowserViewController.h"

@implementation BrowserViewController

@synthesize webview = _webview;
@synthesize loadRequest = _loadRequest;


- (id)initWithLoadRequest:(NSURLRequest *)request{
    self = [super initWithNibName:@"BrowserViewController" bundle:nil];
    if (self) {
        self.loadRequest = request;
    }
    return self;
}

- (void)dealloc{
    
    [self.webview setDelegate:nil];
    [self.webview stopLoading];
    self.webview = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)showLoadingView {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.webview setDelegate:self];

    if (self.loadRequest!=nil) {
        [self.webview loadRequest:self.loadRequest];
    }
    
    [self showLoadingView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //Create an instance of activity indicator view
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //set the initial property
    [activityIndicator stopAnimating];
    [activityIndicator hidesWhenStopped];
    //Create an instance of Bar button item with custome view which is of activity indicator
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    //Set the bar button the navigation bar
    [self navigationItem].rightBarButtonItem = barButton;
    //Memory clean up
    [activityIndicator release];
    [barButton release];
}

-(void)startActivity:(id)sender{
    //Send startAnimating message to the view
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
}

-(void)stopActivity:(id)sender{
    //Send stopAnimating message to the view
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView stopAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self stopActivity:nil];
    [HUD hide:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startActivity:nil];
}

@end
