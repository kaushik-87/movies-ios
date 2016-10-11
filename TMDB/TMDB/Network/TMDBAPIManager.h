//
//  TMDBAPIManager.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//


/*
 This class is responsible for all the network calls. Handling the fetching the data, any authentication challengs should go into this class.
 */

#import <Foundation/Foundation.h>

@interface TMDBAPIManager : NSObject

+ (id)sharedManager;

- (void)loadRequestWithPath:(NSString *)path completion:(void (^)(id data, NSError *error))completion;

@end
