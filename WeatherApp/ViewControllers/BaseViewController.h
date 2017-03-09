//
//  BaseViewController.h
//  WeatherApp
//
//  Created by Wipro Technology on 08/03/17.
//  Copyright © 2017 Wipro Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)showAlertViewControllerWithTitle:(NSString*)title andMessage:(NSString*)message;
- (void)showServerConnectionError;
- (void)showInternetErrorMessage;
- (void)showJSONParsingErrorMessage;
- (void)startActivityIndicator;
- (void)stopActivityIndicator;
- (void)showMessageForError:(NSError*)error;
- (NSString*)integerString:(NSNumber*)value;
- (NSString*)temperatureUnitSymbol;
- (NSString*)pressureUnitSymbol;

@end
