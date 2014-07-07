//
//  ViewController.h
//  marspaper
//
//  Created by kuzey on 20.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollisionBehaviorDelegate>


@property(nonatomic,weak) IBOutlet UIView * curiosityBackgroundView;


@property (nonatomic) UIDynamicAnimator * theAnimator;






-(IBAction)buttonNews:(id)sender;
-(IBAction)buttonPlay:(id)sender;
-(IBAction)buttonWeather:(id)sender;



@end
