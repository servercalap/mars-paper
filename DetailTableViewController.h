//
//  DetailTableViewController.h
//  marspaper
//
//  Created by kuzey on 24.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface DetailTableViewController : UITableViewController

{
    MWFeedItem * item;
    NSString    *dateString;
    NSString    *summaryString;
    
}

@property(nonatomic,strong) MWFeedItem *item;
@property(nonatomic,strong) NSString * dateString;
@property(nonatomic,strong) NSString * summaryString;


@end
