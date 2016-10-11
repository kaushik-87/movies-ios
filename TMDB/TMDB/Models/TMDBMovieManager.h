//
//  TMDBMovieManager.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

/*
 
 This class is responsible to manage the models.
 TMDBMovieManager object is responsible to fetch the upcoming movies from the server.
 This class can be modified to support storing the data in the local DB. 
 For the current scope of the applicaiton this class exposes the below mentioed apis.
 */



#import <Foundation/Foundation.h>
#import "TMDBMovie.h"

typedef NS_ENUM(NSUInteger, TMDBSortOption){
    kSortByReleaseDate,
    kSortByName
};
@interface TMDBMovieManager : NSObject

@property (nonatomic, assign) TMDBSortOption sortBy;
@property (nonatomic, assign) NSUInteger maxListCount;

/*
 This method must be called in the begining. This method fetchs all the configuration related data from the server and stores locally. Currently this method fetches all the genre list and stored in the dictionary.
 */
- (void) configure;
/*
 This method is used to fetch all the upcoming movies. The impalemation can be extended to first check the local cache and then fetch from the server. For now it checks for the max list count property and fethces more movies.
 */
- (void) fetchUpcomingMovies:(void(^)(NSArray *movies, NSError *error))completionBlock;

//- (TMDBMovie *)movieAtIndex:(NSUInteger)index;

/*
 This method is used to get the genre string from the set of genre ids.  The TMDB API gives only the array of genre ids in the movie list. We need to fetch all the genre list using separate API.
 */
- (NSString *)genreStringsForIds:(NSArray *)genreIds;

@end
