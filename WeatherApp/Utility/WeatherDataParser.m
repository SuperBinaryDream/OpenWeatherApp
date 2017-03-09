//
//  WeatherDataParser.m
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import "WeatherDataParser.h"
#import "Weather.h"

@implementation WeatherDataParser

+(CityWeather*)getParsedData:(NSDictionary*)returnedDict{
    CityWeather *cityWeather = [CityWeather new];
    NSMutableArray <Weather *> *weatherObjectArray = [NSMutableArray new];
    
    NSArray *hourwiseDetails= [returnedDict objectForKey:@"list"];
    
    NSString *keyPath = [NSString stringWithFormat:@"city.name"];
    cityWeather.cityName = [returnedDict valueForKeyPath:keyPath];
    keyPath = [NSString stringWithFormat:@"city.coord.lat"];
    cityWeather.cityLatitude = [returnedDict valueForKeyPath:keyPath];
    keyPath = [NSString stringWithFormat:@"city.coord.lon"];
    cityWeather.cityLongitude = [returnedDict valueForKeyPath:keyPath];
    
    for (NSDictionary *hourlyData in hourwiseDetails) {
        Weather *weatherObject = [Weather new];
        NSDictionary *main  = [hourlyData objectForKey:@"main"];
        NSArray *weather  = [hourlyData objectForKey:@"weather"];
        
        weatherObject.dt_txt = [hourlyData objectForKey:@"dt_txt"];
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = weatherObject.dt_txt;
        NSDate* date = [format dateFromString:dateString];
        weatherObject.date = date;
        
        for (NSString *objectKey in main) {
            if ([weatherObject respondsToSelector:NSSelectorFromString(objectKey)]) {
                NSObject *value = [main valueForKey:objectKey];
                if(value){
                    [weatherObject setValue:value forKey:objectKey];
                }
            }
        }
        NSDictionary *weatherData = weather[0];
        weatherObject.descriptionString = [weatherData objectForKey:@"description"];
        weatherObject.icon = [weatherData objectForKey:@"icon"];
        [weatherObjectArray addObject:weatherObject];
    }
    cityWeather.weatherData = weatherObjectArray;
    return cityWeather;
}

@end
