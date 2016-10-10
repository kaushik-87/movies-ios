//
//  TMDBMovieDetailsViewController.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieDetailsViewController.h"
#import <UIImageView+WebCache.h>

@interface TMDBMovieDetailsViewController()
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
    self.name.text = movie.title;
    self.overview.text = movie.overview;
    [self.overview setScrollsToTop:YES];
    self.releaseDate.text = movie.releaseDate;
    self.genre.text = [self.manager genreStringsForIds:movie.genres];
    [self.moviePoster sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", movie.imagePath]] placeholderImage:[UIImage imageNamed:@"default_poster_img.png"]];
//    [self.backdropImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", movie.backdropPath]] placeholderImage:[UIImage imageNamed:nil]];

}

@end
