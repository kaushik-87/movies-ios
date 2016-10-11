//
//  TMDBMovieListDataSource.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//


/*
 This is data source class for the movies list controller.
 This class is responsible to prepare the list of movies fethching from the server/locally.
 Provides interfaces which are required for the list view controller.
 
 */

#import <Foundation/Foundation.h>
#import "TMDBMovie.h"
#import "TMDBMovieManager.h"

@interface TMDBMovieListDataSource : NSObject
@property (nonatomic, strong) TMDBMovieManager *movieManager;

//loadData fetches the data from the server with the completionBlock;
- (void)loadData:(void(^)(BOOL completed, NSError *error))completionBlock;

//objectAtIndex returns the object at the index.
- (TMDBMovie *)objectAtIndex:(NSUInteger)index;

//Returns total number of items in the data source.
- (NSUInteger)totalNumberOfItems;



@end
