//
//  VideoModel.h
//  marspaper
//
//  Created by kuzey on 26.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "JSONModel.h"
#import "VideoLink.h"
#import "VideoTitle.h"


@interface VideoModel : JSONModel

-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err;


@property (strong,nonatomic) VideoLink * link;
@property (strong,nonatomic) VideoTitle * title;


@end
