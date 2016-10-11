//
//  TMDBAPIManager.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "TMDBAPIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
#import "TMDBConstants.h"

@implementation TMDBAPIManager

+ (id)sharedManager {
    static TMDBAPIManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}


- (void)loadRequestWithPath:(NSString *)path completion:(void (^)(id data, NSError *error))completion
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Movies %@",responseObject);
        if (completion) {
            completion(responseObject,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error);
        }
    }];

    
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    if ([[AFNetworkReachabilityManager sharedManager]isReachable]) {
//        [sessionManager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            if (completion) {
//                completion(responseObject,nil);
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if (completion) {
//                completion(nil,error);
//            }
//        }];
//    }
//    else
//    {
//        NSMutableDictionary *userInfo = [NSMutableDictionary new];
//        userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"No internet connectivity.", @"No internet connectivity.");
//
//        NSError *networkError = [NSError errorWithDomain:kNetworkReachabilityErrorDomain code:1001 userInfo:userInfo];
//        if (completion) {
//            completion(nil,networkError);
//        }
//    }

}

@end
