//
//  TMDBAlertController.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBAlertController : NSObject

+ (void)showAlertFrom:(_Nonnull id)viewController actionButtons:(NSArray * _Nonnull)actions title:(NSString *_Nonnull)title andMessage:(nullable NSString *)detailedMessage;
@end
