//
//  VideoModel.m
//  marspaper
//
//  Created by kuzey on 26.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel



-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{

    
    self=[super init];
    
    if (self) {
        self.title=[[VideoTitle alloc] initWithDictionary:dict[@"title"] error:err];
        if (!self.title) return nil;
        
        self.link=[[VideoLink alloc] initWithDictionary:dict[@"link"][0] error:err]; 
    }
    return self;

}

@end
