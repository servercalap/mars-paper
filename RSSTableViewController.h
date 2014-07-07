//
//  RSSTableViewController.h
//  marspaper
//
//  Created by kuzey on 24.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface RSSTableViewController : UITableViewController
<MWFeedParserDelegate>

{
    
    MWFeedParser * feedParser;
    NSMutableArray *parsedItems;
    NSArray *itemsToDisplay;
    NSDateFormatter * formatter;
    
}

@property(nonatomic,strong) NSArray * itemsToDisplay;



@end
