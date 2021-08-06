//
//  Film.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "Film.h"

@implementation Film

+ (Film *) buildPersonFromDict:(NSDictionary*) dict {

    Film* film = [[Film alloc] init];
    film.director   = dict[@"director"] ?: @"";
    film.title      = dict[@"title"] ?: @"";
    
    return film;
}

@end
