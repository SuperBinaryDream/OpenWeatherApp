//
//  Weather.h
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

//weather description
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic, copy) NSString *icon;
// temperature
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSNumber *temp_min;
@property (nonatomic, strong) NSNumber *temp_max;

@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *pressure;

// date string
@property (nonatomic, copy) NSString *dt_txt;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *time;

// date string converted into NSDate format for comparison purpose
@property (nonatomic, copy) NSDate *date;

@end
