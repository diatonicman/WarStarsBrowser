//
//  Film.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "Film.h"

@implementation Film

+ (Film *) buildFilmFromDict:(NSDictionary*) dict {

    Film* film = [[Film alloc] init];
    film.episodeId = [dict[@"episode_id"] intValue];
    film.director   = dict[@"director"] ?: @"";
    film.title      = dict[@"title"] ?: @"";
    film.crawlString = dict[@"opening_crawl"] ?: @"";
    
    NSString *dateString = dict[@"release_date"];
    NSDateFormatter* dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    film.releaseDate = [dateformat dateFromString: dateString];
    
    return film;
}

@end
