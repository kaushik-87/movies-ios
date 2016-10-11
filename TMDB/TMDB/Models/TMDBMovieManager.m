//
//  TMDBMovieManager.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieManager.h"
#import "TMDBAPIManager.h"
#import "TMDBConstants.h"

@interface TMDBMovieGenre : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber    *genreId;
@property (nonatomic, strong) NSString    *genreName;
@end

@implementation TMDBMovieGenre

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"genreId" : @"id",
              @"genreName" : @"name"};
}

@end

@interface TMDBMovieManager()
@property (nonatomic, strong) NSMutableArray        *movies;
@property (nonatomic, strong) NSMutableArray        *genres;
@property (nonatomic, strong) NSMutableDictionary   *genreMap;
@property (nonatomic, assign) NSUInteger            pageNumber;

- (void)fetchGenreList:(void(^)(NSArray *genre, NSError *error))completionBlock;

@end


@implementation TMDBMovieManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _movies         = [[NSMutableArray alloc] init];
        _maxListCount   = 50;
        _sortBy         = kSortByReleaseDate;
        _genres         = [[NSMutableArray alloc]init];
        _genreMap       = [[NSMutableDictionary alloc]init];
        _pageNumber     = 1;
    }
    return self;
}


- (void) configure
{
    __block TMDBMovieManager *movieManager = self;
    [self fetchGenreList:^(NSArray *genre, NSError *error) {
        
        if (genre) {
            NSArray *genreList = [genre valueForKeyPath:@"genres"];
            for(NSDictionary *genre in genreList)
            {
                [movieManager.genreMap setObject:[genre valueForKey:@"name"] forKey:[genre valueForKey:@"id"]];
            }
        }

    }];
}


- (void)fetchGenreList:(void(^)(NSArray *genre, NSError *error))completionBlock
{
    NSString *genreList = [NSString stringWithFormat:@"%@?api_key=%@&language=%@",kGenreListURL,kAPIKey,kLanguage];
    TMDBAPIManager *apiManager = [TMDBAPIManager sharedManager];
    
    [apiManager loadRequestWithPath:genreList completion:^(id data, NSError *error) {
        
        if (completionBlock) {
            completionBlock(data,error);
        }
    }];
}

- (void) fetchUpcomingMovies:(void(^)(NSArray *movies, NSError *error))completionBlock
{
    if (self.movies.count < self.maxListCount) {
        __block TMDBMovieManager *movieManager = self;

        TMDBAPIManager *apiManager = [TMDBAPIManager sharedManager];
        NSString *urlString = [NSString stringWithFormat:@"%@?api_key=%@&language=%@&page=%lu",kUpcomingMoviesURL,kAPIKey,kLanguage,self.pageNumber];
        
        [apiManager loadRequestWithPath:urlString completion:^(id data, NSError *error) {
            
            if (data) {
                [movieManager.movies addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[TMDBMovie class] fromJSONArray:[data valueForKey:@"results"] error:nil]];
                NSArray *sortedMovies = [movieManager sortedArray];
                movieManager.pageNumber++;
                
                if (completionBlock) {
                    completionBlock(sortedMovies,error);
                }
            }
            
            if (error) {
                completionBlock(nil,error);
            }

        }];
        
    }
    else
    {
        if (completionBlock) {
            completionBlock(nil,nil);
        }
    }
}

/*
 This method sorts the movies list based on the value set for the sortby property. 
 For now we support sortby release date and title of the movie.
 */

- (NSArray *)sortedArray
{
    __block TMDBMovieManager *movieManager = self;

    NSArray *sortedArray = [self.movies sortedArrayUsingComparator: ^(TMDBMovie *movie1, TMDBMovie *movie2) {
        if (movieManager.sortBy == kSortByName) {
            return [movie1.title compare: movie2.title];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *d1 = [dateFormatter dateFromString:movie1.releaseDate];
        NSDate *d2 = [dateFormatter dateFromString:movie2.releaseDate];
        return [d1 compare: d2];
    }];
    return sortedArray;
}


- (TMDBMovie *)movieAtIndex:(NSUInteger)index
{
    return [self.movies objectAtIndex:index];
}


- (NSString *)genreStringsForIds:(NSArray *)genreIds
{
    if (self.genreMap.count) {
        NSMutableArray *genres = [[NSMutableArray alloc]init];
        for(NSNumber *id in genreIds)
        {
            [genres addObject:[self.genreMap objectForKey:id]];
        }
        
        return [genres componentsJoinedByString:@", "];
    }
    return @"";
}
@end
