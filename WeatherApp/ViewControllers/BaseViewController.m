//
//  BaseViewController.m
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import "BaseViewController.h"
#import "ReachabilityManager.h"
#import "NetworkManager.h"

//Error messages
static NSString * const kError = @"Error";
static NSString * const kInternetNotReachable = @"Internet Connection Error, Please connect to internet.";
static NSString * const kServerErrorMessage = @"Server Connection Error";
static NSString * const kJSONParsingError = @"Error while parsing web response.";

@interface BaseViewController (){
    int unitSystem;
}
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus)
        {
            case NotReachable: {
                
                [self showAlertViewControllerWithTitle:kError andMessage:kServerErrorMessage];
                break;
            }
                
            default:{
                break;
            }
        }
    }
    if (reachability == self.internetReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus)
        {
            case NotReachable: {
                [self showAlertViewControllerWithTitle:kError andMessage:kInternetNotReachable];
                break;
            }
                
            default:{
                break;
            }
        }
    }
}

- (void)showAlertViewControllerWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showServerConnectionError{
    [self showAlertViewControllerWithTitle:kError andMessage:kServerErrorMessage];
}

- (void)showInternetErrorMessage{
    [self showAlertViewControllerWithTitle:kError andMessage:kInternetNotReachable];
}

- (void)showJSONParsingErrorMessage{
    [self showAlertViewControllerWithTitle:kError andMessage:kJSONParsingError];
}

- (void)showMessageForError:(NSError*)error{
    [self showAlertViewControllerWithTitle:kError andMessage:error.localizedDescription];
}

- (void)startActivityIndicator{
    [self.activityIndicatorView startAnimating];
}

- (void)stopActivityIndicator{
    [self.activityIndicatorView stopAnimating];
}

- (NSString*)integerString:(NSNumber*)value{
    return [NSString stringWithFormat:@"%ld",(long)[value integerValue]];
}

- (NSString*)temperatureUnitSymbol{
    switch (unitSystem) {
        case 0:
            return @"°C";
            break;
            
        case 1:
            return @"°K";
            break;
            
        case 2:
            return @"°F";
            break;
            
        default:
            return @"°C";
            break;
    }
}

- (NSString*)pressureUnitSymbol{
    switch (unitSystem) {
        case 0:
            return @"mBar";
            break;
            
        case 1:
            return @"Pascal";
            break;
            
        case 2:
            return @"kBar";
            break;
            
        default:
            return @"mBar";
            break;
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
