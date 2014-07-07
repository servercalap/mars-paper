//
//  ViewController.m
//  marspaper
//
//  Created by kuzey on 20.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
@synthesize curiosityBackgroundView=_curiosityBackgroundView;
@synthesize theAnimator=_theAnimator;
//@synthesize playButton=_playButton;
//@synthesize newsButton=_newsButton;




-(void)viewDidAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_theAnimator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior * gravityBehavior =[[UIGravityBehavior alloc] initWithItems:@[_curiosityBackgroundView]];
    //gravityBehavior.angle=M_PI_2;
    //[gravityBehavior setGravityDirection:CGVectorMake(0.0,0.5)];
    //[gravityBehavior setGravityDirection:CGVectorMake(-0.5, -0.1)];
    [_theAnimator addBehavior:gravityBehavior];
    
    UICollisionBehavior * collisionBehavior= [[UICollisionBehavior alloc] initWithItems:@[_curiosityBackgroundView]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    [_theAnimator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_curiosityBackgroundView]];
    [itemBehavior setElasticity:0.5];
    [_theAnimator addBehavior:itemBehavior];
    [collisionBehavior setCollisionDelegate:self];
    
  
   
    
    self.theAnimator=_theAnimator;
    
    //[gravityBehavior setAngle:0.0 magnitude:1.0];
    
   
    /*
    [_newsButton addTarget:self action:@selector(buttonNews:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newsButton];
   
    
    [_playButton addTarget:self action:@selector(buttonPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
    
    */
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}



-(IBAction)buttonNews:(id)sender{
 
}

-(IBAction)buttonPlay:(id)sender{
    
    
    
}


-(IBAction)buttonWeather:(id)sender{
    
    
    
}


/*
-(void)pusher{
    RootTableViewController*root =[[RootTableViewController alloc] initWithNibName:@"RootTableViewController" bundle:Nil];
    [self.navigationController pushViewController:root animated:YES];
 
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


