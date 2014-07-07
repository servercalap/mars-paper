//
//  VideoLink.h
//  marspaper
//
//  Created by kuzey on 26.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "JSONModel.h"

@interface VideoLink : JSONModel

@property (strong,nonatomic) NSString * type;
@property (strong,nonatomic) NSURL * href;


@end
