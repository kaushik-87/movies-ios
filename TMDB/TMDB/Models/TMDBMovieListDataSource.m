//
//  TMDBMovieListDataSource.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieListDataSource.h"

@interface TMDBMovieListDataSource ()
@property (nonatomic, strong) NSArray *movieList;

@end


@implementation TMDBMovieListDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _movieList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadData:(void(^)(BOOL completed, NSError *error))completionBlock
{
    __block TMDBMovieListDataSource *datasource = self;
    [self.movieManager fetchUpcomingMovies:^(NSArray *movies, NSError *error) {
        
        if (error) {
            if (completionBlock) {
                completionBlock(NO,error);
            }
            return;
        }
        if (movies) {
            datasource.movieList = movies;
        }
        if (completionBlock) {
            completionBlock(YES,nil);
        }
        

    }];

}

- (TMDBMovie *)objectAtIndex:(NSUInteger)index
{
    if (self.movieList.count) {
        return [self.movieList objectAtIndex:index];
    }
    
    return nil;
}

- (NSUInteger)totalNumberOfItems
{
    return self.movieList.count;
}

@end
