//
//  MarsWeatherViewController.m
//  marspaper
//
//  Created by kuzey on 29.06.2014.
//  Copyright (c) 2014 kuzey. All rights reserved.
//


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kReportMarsURL [NSURL URLWithString:@"http://marsweather.ingenology.com/v1/latest/?format=json"]

#import "MarsWeatherViewController.h"


/*
@interface NSDictionary (JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end

@implementation NSDictionary (JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString *)urlAddress{
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kReportMarsURL]];
    __autoreleasing NSError*error = nil;
    id result =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error !=nil) return nil;
    return result;
    
}


-(NSData*)toJSON{
    NSError *error = nil;
    id result= [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error !=nil) return nil;
    return result;

}

@end
*/
@interface MarsWeatherViewController ()

@end

@implementation MarsWeatherViewController







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  

	    [super viewDidLoad];
        
    
    wweather.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"marssun.png"]];
    wweather.textColor=[UIColor whiteColor];
   [self.view addSubview:wweather];
    
    
    
	    NSURL *JSONFeed= [NSURL URLWithString:@"http://marsweather.ingenology.com/v1/latest/?format=json"];
        
        
	    NSError * error = nil;
        
        
	    NSData * JSONData =[NSData dataWithContentsOfURL:JSONFeed options:NSDataReadingUncached error:&error];
        
        
	    id jsonObject= [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
        
        
	    if (jsonObject !=nil && error==nil) {
            
            
	        NSLog(@"Success");
            
            
	        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                
                
	            NSDictionary * dics= (NSDictionary*)jsonObject;
                
                
	            NSLog(@"disc JSON Dictionary =%@",dics);
                
                
	            NSDictionary * detailContent = [dics objectForKey:@"report"];
                
                
	            NSString * date= [detailContent objectForKey:@"terrestrial_date"];
                
                
	            NSString *atmo = [detailContent objectForKey:@"atmo_opacity"];
                NSNumber * sola =[detailContent objectForKey:@"sol"];
                NSNumber * lss =[detailContent objectForKey:@"ls"];
                NSNumber * minTemp = [detailContent objectForKey:@"min_temp"];
                NSNumber * minTempFah= [detailContent objectForKey:@"min_temp_fahrenheit"];
                NSNumber * maxTemp =[detailContent objectForKey:@"max_temp"];
                NSNumber * maxTempFah =[detailContent objectForKey:@"max_temp_fahrenheit"];

                
	            wweather.text = [NSString stringWithFormat:@"date:%@ \n atmosphere:%@ \n Mars Date:%@ \n Mars Season:%@ \n Min Temp (C):%@ \n Min Temp (F):%@ \n Max Temp (C): %@ \n Max Temp(F) %@", date,atmo,sola,lss,minTemp,minTempFah,maxTemp,maxTempFah];
                //wweather.text=[NSString stringWithUTF8String:NSUTF8StringEncoding];
                
                
	        }
            
            
	        else if ([jsonObject isKindOfClass:[NSArray class]]){
                
                
	            NSArray * arrray = (NSArray*)jsonObject;NSLog(@"JSon Array =%@",arrray);
                
                
	        }
            
            
	    }
        
        
	    else if (error !=nil){
            
            
	        NSLog(@"an error");
            
            
	    }
        
        
        
        
        
	}

    
    /*
    dispatch_async(kBgQueue, ^ {
        
        NSData * data = [NSData dataWithContentsOfURL:kReportMarsURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES
         ];
    });
    
}

   //label
    self.marsWeather.font=[UIFont fontWithName:@"Helvatica" size:17.0f];
    self.marsWeather.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"marssun"]];
    self.marsWeather.textColor=[UIColor whiteColor];
    [self.view addSubview:marsWeather];


    
    NSURL *JSONFeed= [NSURL URLWithString:@"http://marsweather.ingenology.com/v1/latest/"];
    NSError * error = nil;
    
    NSData * JSONData =[NSData dataWithContentsOfURL:JSONFeed options:NSDataReadingUncached error:&error];
    
    id jsonObject= [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    
    if (jsonObject !=nil && error==nil) {
        NSLog(@"Success");
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dics= (NSDictionary*)jsonObject; NSLog(@"disc JSON Dictionary =%@",dics);
            
            for (NSString* dataType in dics) {
                if ([dataType isEqualToString:@"json"]) {
                    NSDictionary * content = [dics objectForKey:dataType];
                    
                    for (NSDictionary* data in content) {
                        NSDictionary * detailContent = [data objectForKey:@"report"];
                        NSString * date= [detailContent objectForKey:@"Terrestrial_date"];
                        //NSNumber * sola =[detailContent objectForKey:@"sol"];
                        //NSNumber * lss =[detailContent objectForKey:@"ls"];
                        //NSNumber * minTemp = [detailContent objectForKey:@"min_temp"];
                        //NSNumber * minTempFah= [detailContent objectForKey:@"min_temp_fahrenheit"];
                        //NSNumber * maxTemp =[detailContent objectForKey:@"max_temp"];
                        //NSNumber * maxTempFah =[detailContent objectForKey:@"max_temp_fahrenheit"];
                        NSString *atmo = [detailContent objectForKey:@"atmo_opacity"];
                        wweather.text=[NSString stringWithFormat:date,atmo];
                        
                    }
                }
            }
            
        }
    
        else if ([jsonObject isKindOfClass:[NSArray class]]){
            NSArray * arrray = (NSArray*)jsonObject;NSLog(@"JSon Array =%@",arrray);
            
        }
    
    }
    
    else if (error !=nil){
        NSLog(@"an error");
    }
    
}

     

*/
    

/*
-(void)fetchedData:(NSData*)responseData{

    
    
    NSError * error;
    
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    self.tDate=[json objectForKey:@"terrestrial_date"];
    self.mDate=[json objectForKey:@"sol"];
    self.mTempC=[NSString stringWithFormat:@"%@",[json objectForKey:@"min_temp"]];
    self.mxTempC=[NSString stringWithFormat:@"%@",[json objectForKey:@"max_temp"]];
    self.mTempF=[NSString stringWithFormat:@"%@",[json objectForKey:@"min_temp_fahrenheit"]];
    self.mxTempF=[NSString stringWithFormat:@"%@",[json objectForKey:@"max_temp_fahrenheit"]];
    self.mSeason=[json objectForKey:@"ls"];
    self.atmo=[json objectForKey:@"atmo_opacity"];
    
    
    
    /*
    NSError * error;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    NSArray * marsReport = [json objectForKey:@"callback"];
    NSLog(@"report:%@", marsReport);
    
  NSString * name = [json objectForKey:@"report"];
    

    NSDictionary * report= [json objectForKey:name];
    
    
    NSDecimalNumber * minTemp = [report objectForKey:@"min_temp"];
    NSDecimalNumber *minTempFah=[report objectForKey:@"min_temp_fahrenheit"];
    NSDecimalNumber * maxTemp =[report objectForKey:@"max_temp"];
    NSDecimalNumber * maxTempFah= [report objectForKey:@"max_temp_fahrenheit"];
    float outstandingTemp=[minTemp floatValue] - [minTempFah floatValue] - [maxTemp floatValue] - [maxTempFah floatValue];
   
    NSDictionary * info =[NSDictionary dictionaryWithObjectsAndKeys:[report objectForKey:@"abs_humidity"], @"humidity",[report objectForKey:@"atmo_opacity"] , @"atmosphere" ,[report objectForKey:@"ls"], @"marsseason",[NSDecimalNumber numberWithFloat:outstandingTemp], [report objectForKey:@"pressure"],@"pressure",[report objectForKey:@"pressure_string"],@"pressure string",[report objectForKey:@"season"], @"season",[report objectForKey:@"sol"], @"marsdate" ,[report objectForKey:@"sunrise"], @"sunsire", [report objectForKey:@"sunset"], @"sunset",[report objectForKey:@"terrestrial_date"],@"date", [report objectForKey:@"wind_direction"],@"wind direction", [report objectForKey:@"wind_speed"],@"wind speed", nil];
  
    
  
                          
                                                  
    NSData * jsonData= [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
    
    
   weather.text =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
     
     
}
 

*/
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
