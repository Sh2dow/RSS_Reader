//
//  AppDelegate.m
//  RSS_Reader
//
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootViewController *rootViewController = [[RootViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:navController];
//    [navController setNavigationBarHidden:YES];
    return YES;
}

@end
