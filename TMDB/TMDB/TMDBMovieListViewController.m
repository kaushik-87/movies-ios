//
//  ViewController.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieListViewController.h"
#import "TMDBMovieCell.h"
#import "TMDBMovie.h"
#import <UIImageView+WebCache.h>
#import "TMDBMovieDetailsViewController.h"
#import "TMDBMovieManager.h"
#import "TMDBConstants.h"
#import "TMDBAlertController.h"
#import "TMDBActivityIndicatorView.h"
#import "TMDBMovieListDataSource.h"

@interface TMDBMovieListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TMDBMovieManager *manager;
@property (nonatomic, weak) IBOutlet TMDBActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UITableView *moviesList;
@property (nonatomic, strong) TMDBMovieListDataSource *dataSource;
@end

@implementation TMDBMovieListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _manager    = [[TMDBMovieManager alloc]init];
        [_manager configure];
        _dataSource = [[TMDBMovieListDataSource alloc]init];
        _dataSource.movieManager = _manager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesList.rowHeight           = UITableViewAutomaticDimension;
    self.moviesList.estimatedRowHeight  = 165;
    
    [self.manager setSortBy:kSortByReleaseDate];
    [self.manager setMaxListCount:50];
    
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = NSLocalizedString(@"Coming Soon", @"Coming Soon");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)fetchData
{
    [self.activityIndicator showActivity];
    __block TMDBMovieListViewController *viewController = self;
    [self.dataSource loadData:^(BOOL completed, NSError *error) {
        [self.activityIndicator hideActivity];
        if (completed) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [viewController.moviesList reloadData];
            });
        }
        
        if (error) {
            NSError *fetchingFailedError = [NSError errorWithDomain:kFetchMoviesErrorDomain code:error.code userInfo:error.userInfo];
            [viewController showAlertViewForError:fetchingFailedError];
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
    return [self.dataSource totalNumberOfItems];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    TMDBMovieCell *cell = (TMDBMovieCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    TMDBMovie *movie        = [self.dataSource objectAtIndex:indexPath.row];
    if (movie) {
        cell.name.text          = movie.title;
        cell.releaseDate.text   = movie.releaseDate;
        [cell.poster sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMovieCellImageURL, movie.imagePath]] placeholderImage:[UIImage imageNamed:@"default_poster_img.png"]];
        cell.genres.text        = [self.manager genreStringsForIds:movie.genres];
    }

    //Checking for the last indx to fetch more items
    if (indexPath.row ==  self.dataSource.totalNumberOfItems-1) {
        [self fetchData];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    TMDBMovieDetailsViewController *detailsViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"movieDetails"];
    detailsViewController.manager   = self.manager;
    detailsViewController.movie     = [self.dataSource objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma UIALerViewController 

- (void)showAlertViewForError:(NSError *)error
{
    NSString *title;
    NSString *detailedMessage = error.localizedDescription;
    if ([error.domain  isEqualToString: kFetchMoviesErrorDomain]) {
        title = NSLocalizedString(@"Fetching Failed", @"Fetching Failed");
    }
    
    if ([error.domain  isEqualToString: kNetworkReachabilityErrorDomain]) {
        title = NSLocalizedString(@"Network Error", @"Network Error");
    }
    
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                               }];
    
    __block TMDBMovieListViewController *vc = self;
    UIAlertAction *retryAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Retry", @"Retry")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [vc fetchData];
                               }];
    
    NSArray *actions = [NSArray arrayWithObjects:okAction,retryAction, nil];
    [TMDBAlertController showAlertFrom:self actionButtons:actions title:title andMessage:detailedMessage];
}

@end
