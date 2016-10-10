//
//  ViewController.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "ViewController.h"
#import "TMDBMovieCell.h"
#import "TMDBMovie.h"
#import <UIImageView+WebCache.h>
#import "TMDBMovieDetailsViewController.h"
#import "TMDBMovieManager.h"
#import "TMDBConstants.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) TMDBMovieManager *manager;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _movies     = [[NSArray alloc]init];
        _manager    = [[TMDBMovieManager alloc]init];
        [_manager configure];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesList.rowHeight           = UITableViewAutomaticDimension;
    self.moviesList.estimatedRowHeight  = 165;
    
    [self.manager setSortBy:kSortByReleaseDate];
    [self.manager setMaxListCount:50];
    
    __block ViewController *viewController = self;
    [self.manager fetchUpcomingMovies:^(NSArray *movies, NSError *error) {
        if (movies) {
            viewController.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [viewController.moviesList reloadData];
            });
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Coming Soon";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



-(void)loadMore
{
    __block ViewController *viewController = self;

    [self.manager fetchUpcomingMovies:^(NSArray *movies, NSError *error) {
        if (movies) {
            viewController.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [viewController.moviesList reloadData];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDelegate and Datasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    TMDBMovieCell *cell = (TMDBMovieCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    TMDBMovie *movie        = [self.movies objectAtIndex:indexPath.row];
    cell.name.text          = movie.title;
    cell.releaseDate.text   = movie.releaseDate;
    [cell.poster sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",kMovieCellImageURL, movie.imagePath]] placeholderImage:[UIImage imageNamed:@"default_poster_img.png"]];
    cell.genres.text        = [self.manager genreStringsForIds:movie.genres];
    
    if (indexPath.row ==  self.movies.count-1) {
        [self loadMore];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    TMDBMovieDetailsViewController *detailsViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"movieDetails"];
    detailsViewController.manager   = self.manager;
    detailsViewController.movie     = [self.movies objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
