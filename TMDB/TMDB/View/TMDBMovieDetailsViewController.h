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

@property (nonatomic, weak) IBOutlet UIImageView    *moviePoster;
@property (nonatomic, weak) IBOutlet UILabel        *name;
@property (nonatomic, weak) IBOutlet UILabel        *genre;
@property (nonatomic, weak) IBOutlet UILabel        *releaseDate;
@property (nonatomic, weak) IBOutlet UITextView     *overview;
@property (nonatomic, weak) IBOutlet UIImageView    *backdropImageView;
@property (nonatomic, strong) TMDBMovieManager      *manager;
@property (nonatomic, strong) TMDBMovie             *movie;

@end
