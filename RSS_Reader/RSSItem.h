//
//  RSSItem.h
//  RSSReader
//
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RSSItem : NSObject {
	NSString * _title;
    NSString * _guid;
	NSString * _summary;
	NSString * _content;
    NSString * _author;
    NSString * _imageURL;
	NSString * _linkURL;
    NSDate * _pubDate;
    NSMutableArray * _categories;
}

@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * guid;
@property(nonatomic, copy) NSString * summary;
@property(nonatomic, copy) NSString * content;
@property(nonatomic, copy) NSString * author;
@property(nonatomic, copy) NSString * imageURL;
@property(nonatomic, copy) NSString * linkURL;
@property(nonatomic, copy) NSDate * pubDate;

@property(readonly) NSMutableArray * categories;

- (void)addCategory:(NSString *)value;


@end
