//
//  RSSListViewController.h
//  RSSReader
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RSSParser.h"


@interface RSSListViewController : UITableViewController <RSSParserDelegate> {
    RSSParser * _rssParser;
}

- (id)initWithRSSURL:(NSString *)rssURL;

- (void)startActivity:(id)sender;

- (void)stopActivity:(id)sender;

@end
