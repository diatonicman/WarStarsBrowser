//
//  ServiceLocator.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/5/21.
//

#import "ServiceLocator.h"

#import "NSURLSessionService.h"
#import "CoreDataService.h"

@implementation ServiceLocator

+ (id<NetworkService>) getNetworkService {
    static NSURLSessionService *sharedNetworkService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkService = [[NSURLSessionService alloc] init];
    });
    
    return sharedNetworkService;
}

+ (id<PersistenceService>) getPersistenceService {
    static CoreDataService *sharedPersistenceService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPersistenceService = [[CoreDataService alloc] init];
    });
    
    return sharedPersistenceService;
}

@end
