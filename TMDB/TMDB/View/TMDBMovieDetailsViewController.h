//
//  TMDBMovieDetailsViewController.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMDBMovie.h"
#import "TMDBMovieManager.h"

@interface TMDBMovieDetailsViewController : UIViewController

@property (nonatomic, strong) TMDBMovieManager      *manager;
@property (nonatomic, strong) TMDBMovie             *movie;

@end
