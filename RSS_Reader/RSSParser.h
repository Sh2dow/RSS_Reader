//
//  RSSParser.h
//  RSSReader
//
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RSSItem;

@protocol RSSParserDelegate;

@interface RSSParser : NSObject <NSXMLParserDelegate> {
    id<RSSParserDelegate> _delegate;

	RSSItem * _currentItem;
	NSMutableArray * _rssItems;
    NSString * _rssURL;
	
	NSMutableData * _downloadedData;

    BOOL _parseElement;
	NSMutableString * _parsedElementString;
    NSMutableData * _parsedElementData;
}

@property(nonatomic, assign) id<RSSParserDelegate> delegate;
@property(readonly) NSMutableArray * rssItems;
@property(nonatomic, retain) NSString * RSSURL;

- (id)initWithRSSURL:(NSString *)rssURL;

- (void)start;

@end

@protocol RSSParserDelegate <NSObject>

-(void)RSSParserDidCompleteParsing;
-(void)RSSParserHasError:(NSError *)error;

@end
