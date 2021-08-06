//
//  NetworkService.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "Film.h"

#ifndef NetworkService_h
#define NetworkService_h

typedef void (^FilmFetcherCallback)(NSArray<Film*> *newFilms, NSError *error);

@protocol NetworkService <NSObject>

- (void) fetchFilms: (FilmFetcherCallback) fetcherCallback;

@end

#endif /* NetworkService_h */
