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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _movies = [[NSArray alloc]init];
        _manager = [[TMDBMovieManager alloc]init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.manager configure];
    
    self.moviesList.rowHeight = UITableViewAutomaticDimension;
    self.moviesList.estimatedRowHeight = 165;
    
    [self.manager setSortBy:kSortByReleaseDate];
    [self.manager setMaxListCount:50];
    
    [self.manager fetchUpcomingMovies:^(NSArray *movies, NSError *error) {
        if (movies) {
            self.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.moviesList reloadData];
            });
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.moviesList deselectRowAtIndexPath:[self.moviesList indexPathForSelectedRow] animated:NO];
    self.title = @"Coming Soon";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.list reloadData];
}

-(void)loadMore
{
    
    [self.manager fetchUpcomingMovies:^(NSArray *movies, NSError *error) {
        if (movies) {
            self.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.moviesList reloadData];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

    TMDBMovie *movie = [self.movies objectAtIndex:indexPath.row];
    cell.name.text = movie.title;
    cell.releaseDate.text = movie.releaseDate;
    [cell.poster sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", movie.imagePath]] placeholderImage:[UIImage imageNamed:@"default_poster_img.png"]];
    cell.genres.text = [self.manager genreStringsForIds:movie.genres];
    if (indexPath.row ==  self.movies.count-1) {
        NSLog(@"load more");
        [self loadMore];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    TMDBMovieDetailsViewController *detailsViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"movieDetails"];
    detailsViewController.manager = self.manager;
    detailsViewController.movie = [self.movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

@end
