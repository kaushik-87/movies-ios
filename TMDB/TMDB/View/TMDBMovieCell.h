//
//  MovieCell.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMDBMovieCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *poster;
@property (nonatomic, weak) IBOutlet UILabel *genres;
@property (nonatomic, weak) IBOutlet UILabel *releaseDate;
@end
