//
//  YoutubeViewController.m
//  marspaper
//
//  Created by kuzey on 26.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "YoutubeViewController.h"
#import "VideoModel.h"
#import "HUD.h"



@interface YoutubeViewController (){
    
    IBOutlet UITableView * table;
    NSArray *items;
    
    
    
}

@end

@implementation YoutubeViewController


-(void)viewDidAppear:(BOOL)animated{
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [table setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"marssun.png"]]];
    [table setBackgroundColor:
     [UIColor colorWithPatternImage:
      [UIImage imageNamed:@"marssun.png"]]];
    
    self.title=@"NASA";
    
    [HUD showUIBlockingIndicatorWithText:@"Loading"];
    
    
    dispatch_async (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSData * ytData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://gdata.youtube.com/feeds/api/videos?q=nasa&max-results=50&alt=json"]];
        
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:ytData options:kNilOptions error:nil];
        
        dispatch_async(dispatch_get_main_queue() ,^ {
            
            items= [VideoModel arrayOfModelsFromDictionaries:json[@"feed"][@"entry"]];
            
            [HUD hideUIBlockingIndicator];
            if (items) {
                [table reloadData];
            }else {
                [HUD showAlertWithTitle:@"Error" text:@"Sorry, invalid data"];
                
            }
        });
    });

   
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - table methods


-(NSInteger)numberOfSectionInTableView:(UITableView*)tableView{
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    return items.count;
    
    
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
       
    
    }
    
    VideoModel* videio = items[indexPath.row];
    cell.textLabel.text=videio.title.$t;
    
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    VideoModel * video = items[indexPath.row];
    [[UIApplication sharedApplication] openURL:video.link.href];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
