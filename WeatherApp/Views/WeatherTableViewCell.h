//
//  WeatherTableViewCell.h
//  WeatherApp
//
//  Created by Wipro Technology on 09/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherDescriptionLabel;

@end
