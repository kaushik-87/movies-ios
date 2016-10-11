//
//  AppDelegate.h
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

/*
 
 This application is designed and developed to list the upcoming movies using TMDB API.
 
 Application has two main screens:
 
 1. List of Movies
 2. Details of the selcted Movie. 
 
 For this application we are restricting the movie list count to 50. All the movies are sorted by the release date in ascending order.
 In the list view each movie is displayed in a row with title, poster image, genres and release date. 
 
 Selecting on each row navigates to detailed screen. Detailed screen displays Movie title, bigger poster image, genres, release date and oveview about the movie.
 
 The application is desgined in such a way that it can be extensible for handling more number of movies and also can be sorted using other parameters like name, popularity etc.
 
 Major components in the project
 
    TMDBMovie           - Class which reresents movie object. Used mantle to handle the JSON parsing.
 
    TMDBMovieManager    - Model manager class which manages the fetching/storing of the list of movies.
 
    TMDBDataSource      - Datsource class for the list view controller. Designed to keep the data source separate from the Viewcontroller.
 
    TMDBAPIManager      - Network manager class which is responsible for communicting with the server. Uses AFNetworking library.
 
 
 */

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

