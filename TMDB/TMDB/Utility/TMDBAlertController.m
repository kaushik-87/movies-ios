//
//  TMDBAlertController.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBAlertController.h"
#import <UIKit/UIKit.h>

@implementation TMDBAlertController

+ (void)showAlertFrom:(_Nonnull id)viewController actionButtons:(NSArray * _Nonnull)actions title:(NSString *_Nonnull)title andMessage:(nullable NSString *)detailedMessage
{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:detailedMessage preferredStyle:UIAlertControllerStyleAlert];
    
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    
    [viewController presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
