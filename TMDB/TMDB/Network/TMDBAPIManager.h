//
//  TMDBAPIManager.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDBAPIManager : NSObject

+ (id)sharedManager;

- (void)loadRequestWithPath:(NSString *)path completion:(void (^)(id data, NSError *error))completion;

@end
