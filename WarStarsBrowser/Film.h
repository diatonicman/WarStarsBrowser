//
//  Film.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Film : NSObject

@property (nonatomic) NSString* title;
@property (nonatomic) NSString* director;
@property (nonatomic) NSDate *releaseDate;

+ (Film*) buildPersonFromDict:(NSDictionary*) dict;

@end

NS_ASSUME_NONNULL_END
