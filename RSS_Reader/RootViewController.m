//
//  RootViewController.m
//  RSSReader
//
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//

#import "RootViewController.h"
#import "FeedsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //FeedsViewController will load automatically, so we won't see RootViewController
    self.title = @"Root";
    UIButton *nextScreenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextScreenButton.frame= CGRectMake(100, 100, 100, 40);
    [nextScreenButton setTitle:@"News" forState:UIControlStateNormal];
    [self CreateFeeds];
    [self ShowFeeds];
}

- (void) CreateFeeds
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath])
    {
        NSString *filePathBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"data.plist"];
        [[NSFileManager defaultManager] copyItemAtPath:filePathBundle toPath:filePath error:nil];
    }

}

- (void) ShowFeeds
{
    //plist file full path
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    //Load plist file as dictionary
    NSMutableArray * Root = [[NSMutableArray alloc] initWithContentsOfFile:filePath];

    FeedsViewController * newsController = nil;
    newsController = [[FeedsViewController alloc] initWithNewsSourceList:Root];
    [self.navigationController pushViewController:newsController animated:YES];
    [newsController release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
