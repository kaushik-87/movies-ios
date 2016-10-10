//
//  TMDBMovie.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBMovie.h"
#import "MTLValueTransformer.h"


@implementation TMDBMovie

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{ @"title" : @"original_title",
              @"genres" : @"genre_ids",
              @"imagePath" : @"poster_path",
              @"backdropPath" : @"backdrop_path",
              @"releaseDate": @"release_date",
              @"overview": @"overview"};
}

+ (NSValueTransformer *)releaseDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:[self.dateFormatter dateFromString:dateString]];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *_formatter;
    
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyy/MM/dd";
    }
    return _formatter;
}


@end
