//
//  BrowserViewController.h
//  RSSReader
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BrowserViewController : UIViewController <UIWebViewDelegate, MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    UIWebView * _webview;
    NSURLRequest * _loadRequest;
}

@property (nonatomic, retain) IBOutlet UIWebView * webview;

@property (nonatomic, retain) NSURLRequest * loadRequest;

- (id)initWithLoadRequest:(NSURLRequest *)request;

- (void)startActivity:(id)sender;

- (void)stopActivity:(id)sender;

- (void)showLoadingView;


@end
