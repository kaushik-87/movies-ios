//
//  TMDBActivityIndicatorView.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBActivityIndicatorView.h"

@implementation TMDBActivityIndicatorView

- (void)showActivity
{
    [self startAnimating];
    [self setHidden:NO];
}
- (void)hideActivity
{
    [self stopAnimating];
    [self setHidden:YES];
}

@end
