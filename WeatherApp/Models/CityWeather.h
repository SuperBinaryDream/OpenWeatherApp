//
//  CityWeather.h
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface CityWeather : NSObject

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityLatitude;
@property (nonatomic, copy) NSString *cityLongitude;
// Holds day and time wise weather data
@property (nonatomic, strong) NSArray <Weather *> *weatherData;


@end
