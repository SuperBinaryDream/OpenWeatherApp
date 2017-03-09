//
//  WeatherDataParser.h
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityWeather.h"

@interface WeatherDataParser : NSObject

+(CityWeather*)getParsedData:(NSDictionary*)returnedDict;

@end
