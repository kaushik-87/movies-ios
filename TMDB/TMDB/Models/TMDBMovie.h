//
//  TMDBMovie.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface TMDBMovie : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSArray     *genres;
@property (nonatomic, copy) NSString    *imagePath;
@property (nonatomic, copy) NSString    *backdropPath;
@property (nonatomic, copy) NSString    *releaseDate;
@property (nonatomic, copy) NSString    *overview;
@end
