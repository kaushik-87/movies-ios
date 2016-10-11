//
//  TMDBActivityIndicatorView.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/11/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBActivityIndicatorView.h"

@implementation TMDBActivityIndicatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


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
