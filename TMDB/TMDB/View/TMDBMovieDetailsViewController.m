//
//  TMDBMovieDetailsViewController.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieDetailsViewController.h"
#import <UIImageView+WebCache.h>
#import "TMDBConstants.h"


@interface TMDBMovieDetailsViewController()
@property (nonatomic, weak) IBOutlet UIImageView    *moviePoster;
@property (nonatomic, weak) IBOutlet UILabel        *name;
@property (nonatomic, weak) IBOutlet UILabel        *genre;
@property (nonatomic, weak) IBOutlet UILabel        *releaseDate;
@property (nonatomic, weak) IBOutlet UITextView     *overview;
@property (nonatomic, weak) IBOutlet UIImageView    *backdropImageView;
@end


@implementation TMDBMovieDetailsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMovieDetails:self.movie];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.overview setScrollsToTop:YES];
    self.title = @"Movie";
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.list reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMovieDetails:(TMDBMovie *)movie
{
    self.name.text          = movie.title;
    self.overview.text      = movie.overview;
    [self.overview setScrollsToTop:YES];
    self.releaseDate.text   = movie.releaseDate;
    self.genre.text         = [self.manager genreStringsForIds:movie.genres];
    [self.moviePoster sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kPosterURL, movie.imagePath]] placeholderImage:[UIImage imageNamed:@"default_poster_img.png"]];

}

@end
