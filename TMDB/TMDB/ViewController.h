//
//  ViewController.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMDBMovieManager.h"
@interface ViewController : UIViewController
@property (nonatomic, strong) TMDBMovieManager *manager;
@property (nonatomic, weak) IBOutlet UITableView *moviesList;

@end

