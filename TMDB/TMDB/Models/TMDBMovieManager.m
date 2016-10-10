//
//  TMDBMovieManager.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovieManager.h"
#import "TMDBAPIManager.h"


#define kUpcomingMoviesURL  "https://api.themoviedb.org/3/movie/upcoming"
#define kGenreListURL       "https://api.themoviedb.org/3/genre/movie/list"
#define kAPIKey             "1f54bd990f1cdfb230adb312546d765d"
#define kLanguage           "en-US"

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
    [self fetchGenreList:^(NSArray *genre, NSError *error) {
        NSArray *genreList = [genre valueForKeyPath:@"genres"];
        for(NSDictionary *genre in genreList)
        {
            [self.genreMap setObject:[genre valueForKey:@"name"] forKey:[genre valueForKey:@"id"]];
        }
    }];
}


- (void)fetchGenreList:(void(^)(NSArray *genre, NSError *error))completionBlock
{
    NSString *genreList = [NSString stringWithFormat:@"%s?api_key=%s&language=%s",kGenreListURL,kAPIKey,kLanguage];
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
        
        TMDBAPIManager *apiManager = [TMDBAPIManager sharedManager];
        NSString *urlString = [NSString stringWithFormat:@"%s?api_key=%s&language=%s&page=%lu",kUpcomingMoviesURL,kAPIKey,kLanguage,self.pageNumber];
        
        [apiManager loadRequestWithPath:urlString completion:^(id data, NSError *error) {
            
            if (data) {
                [self.movies addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[TMDBMovie class] fromJSONArray:[data valueForKey:@"results"] error:nil]];
            }
            
            NSArray *sortedMovies = [self sortedArray];
            
            if (completionBlock) {
                completionBlock(sortedMovies,error);
            }
        }];
        
        self.pageNumber++;
    }
}

/*
 This method sorts the movies list based on the value set for the sortby property. 
 For now we support sortby release date and title of the movie.
 */

- (NSArray *)sortedArray
{
    NSArray *sortedArray = [self.movies sortedArrayUsingComparator: ^(TMDBMovie *movie1, TMDBMovie *movie2) {
        if (self.sortBy == kSortByName) {
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