//
//  NewsListViewController.h
//  RSSReader
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeedsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _newsSourceList;
    IBOutlet UITableView *myTableView;
}

@property(nonatomic,retain) IBOutlet UITableView *myTableView;

- (id)initWithNewsSourceList:(NSMutableArray * )list ;

@end
