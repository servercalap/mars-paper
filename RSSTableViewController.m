//
//  RSSTableViewController.m
//  marspaper
//
//  Created by kuzey on 24.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "RSSTableViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailTableViewController.h"

@interface RSSTableViewController ()

@end

@implementation RSSTableViewController
@synthesize itemsToDisplay;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    
    
    self.title=@"marspaper";
    
    formatter=[[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    parsedItems=[[NSMutableArray alloc] init];
    
    self.itemsToDisplay=[NSArray array];
    
    
    
    //refresh button
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    
    
    // parse
    
    
    
    NSURL *feedURL=[NSURL URLWithString:@"http://mars.nasa.gov/rss/news.cfm"];
    
    feedParser=[[MWFeedParser alloc] initWithFeedURL:feedURL];
    
    feedParser.delegate=self;
    
    feedParser.feedParseType=ParseTypeFull;
    
    feedParser.connectionType=ConnectionTypeAsynchronously;
    
    [feedParser parse];
    
    
    
    
   
}
-(void)refresh{
    
    self.title=@"Refreshing.";
    
    [parsedItems removeAllObjects];
    
    [feedParser stopParsing];
    
    [feedParser parse];
    
    self.tableView.userInteractionEnabled=YES;
    
    self.tableView.alpha=0.3;
    
    
    
}

-(void)updateTableWithParsedItems{
    
    self.itemsToDisplay=[parsedItems sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO]]];
    
    self.tableView.userInteractionEnabled=YES;
    
    self.tableView.alpha=1;
    
    [self.tableView reloadData];
    
    
    
}
#pragma mark -

#pragma mark MWFeedParserDelegate



-(void)feedParserDidStart:(MWFeedParser *)parser{
    
    NSLog(@"Started Parsing:%@" , parser.url);
    
    
    
}



-(void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    
    NSLog(@"Parsed Feed Info:“%@”", info.title);
    
    self.title= info.title;
    
}



-(void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    
    NSLog(@"Parsed Feed Item:“%@”", item.title);
    
    if (item) [parsedItems addObject:item];
    
    
    
}

-(void)feedParserDidFinish:(MWFeedParser *)parser{
    
    NSLog(@"Finished Parsing%@", (parser.stopped ? @"(Stopped)":@""));
    
    [self updateTableWithParsedItems];
    
    
    
}



-(void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    
    NSLog(@"Finished Parsing With Error:%@",error);
    
    if (parsedItems.count==0) {
        
        self.title=@"Failed";
        
    }else{
        
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Parsing Incomplete" message:@"There was an error during the parsing of this feed.Not all of the feed items cloud parsed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    
    
    [self updateTableWithParsedItems];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return itemsToDisplay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    
    // Configure the cell.
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    
    if (item) {
        
        
        // Process
        
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No title]";
        
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        
        
        // Set
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        cell.textLabel.text = itemTitle;
        
        NSMutableString *subtitle = [NSMutableString string];
        
        if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
        
        [subtitle appendString:itemSummary];
        
        cell.detailTextLabel.text = subtitle;
        
        
    }
    
    return cell;
    
}
#pragma mark-
#pragma mark -TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    DetailTableViewController *detail= [[DetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    detail.item = (MWFeedItem*)[itemsToDisplay objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end