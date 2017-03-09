//
//  NetworkManager.h
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface NetworkManager : NSObject

+(instancetype)sharedNetworkManager;

-(void)getWeatherDataWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
