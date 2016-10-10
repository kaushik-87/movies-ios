//
//  TMDBMovieManager.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBMovie.h"

typedef NS_ENUM(NSUInteger, TMDBSortOption){
    kSortByReleaseDate,
    kSortByName
};
@interface TMDBMovieManager : NSObject

@property (nonatomic, assign) TMDBSortOption sortBy;
@property (nonatomic, assign) NSUInteger maxListCount;

- (void) configure;

- (void) fetchUpcomingMovies:(void(^)(NSArray *movies, NSError *error))completionBlock;

- (TMDBMovie *)movieAtIndex:(NSUInteger)index;

- (NSString *)genreStringsForIds:(NSArray *)genreIds;

@end
