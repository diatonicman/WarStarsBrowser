//
//  ServiceLocator.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/5/21.
//

#import <Foundation/Foundation.h>

#import "NetworkService.h"
#import "PersistenceService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceLocator : NSObject

+ (id<NetworkService>) getNetworkService;
+ (id<PersistenceService>) getPersistenceService;

@end

NS_ASSUME_NONNULL_END
