//
//  ViewController.m
//  WeatherApp
//
//  Created by Wipro Technology on 07/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "CityWeather.h"
#import "WeatherTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

static NSString * const cellIdentifier = @"WeathereCell";

@interface ViewController () <CLLocationManagerDelegate>{
    __block CityWeather *cityWeather;
    Weather *weather;
    NSArray *tableViewDataArray;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureUnitLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *day;
@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UILabel *temperatureMinLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureMaxLabel;
@property (nonatomic, weak) IBOutlet UILabel *humidityLabel;
@property (nonatomic, weak) IBOutlet UILabel *pressureLabel;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

-(void)viewWillAppear:(BOOL)animated{
    [self fetchWeatherData];
   // [self initializeLocationManager];
}

-(void)initializeLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    currentLocation=locationManager.location;
}

- (void)fetchWeatherData{
    __weak ViewController *weakSelf = self;
    
    // Fetch Data for 5 day Weather Trend
    [[NetworkManager sharedNetworkManager] getWeatherDataWithSuccess:^(id expectedObject) {
       //update UI
        cityWeather = (CityWeather*)expectedObject;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf stopActivityIndicator];
            [weakSelf refreshData];
        });
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf stopActivityIndicator];
            [weakSelf showMessageForError:error];
        });
        
    }];
}

- (void)refreshData{
    self.cityNameLabel.text = cityWeather.cityName;
    weather = cityWeather.weatherData[0];
    tableViewDataArray = cityWeather.weatherData;
    [self refreshUI];
    [self refreshTableData];
}
- (void)refreshTableData{
    [self.tableView reloadData];
}

- (void)refreshUI{
    
    self.temperatureLabel.text = [self integerString:weather.temp];//°C
    self.temperatureUnitLabel.text = [self temperatureUnitSymbol];
    self.temperatureMaxLabel.text = [NSString stringWithFormat:@"High %@ %@",[self integerString:weather.temp_max], [self temperatureUnitSymbol]];
    self.temperatureMinLabel.text = [NSString stringWithFormat:@"Low %@ %@",[self integerString:weather.temp_min], [self temperatureUnitSymbol]];
    self.weatherDescriptionLabel.text = [weather.descriptionString capitalizedString];
    self.pressureLabel.text = [NSString stringWithFormat:@"%@ %@",[self integerString:weather.pressure],[self pressureUnitSymbol]];
    self.humidityLabel.text = [NSString stringWithFormat:@"%@ %%",weather.humidity];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEE, MMM dd, HH:mm"];
    NSString *displayDate = [format stringFromDate:weather.date];
    self.date.text = displayDate;
}

- (void)getWeatherObjectForCurrentTime{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableViewDataArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Weather *weatherObject = [tableViewDataArray objectAtIndex:indexPath.row];
    cell.weatherDescriptionLabel.text = [weatherObject.descriptionString capitalizedString];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%@ %@",[self integerString:weatherObject.temp],[self temperatureUnitSymbol]];
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEE, MMM dd, HH:mm"];
    NSString *displayDate = [format stringFromDate:weatherObject.date];
    cell.dateLabel.text = displayDate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    weather = [tableViewDataArray objectAtIndex:indexPath.row];
    [self refreshUI];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self showAlertViewControllerWithTitle:@"Error" andMessage:@"Location fetch error."];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    currentLocation = newLocation;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations lastObject];
    [locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
