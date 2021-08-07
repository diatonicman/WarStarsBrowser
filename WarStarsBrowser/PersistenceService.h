//
//  PersistenceService.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/7/21.
//

#import "Film.h"

#ifndef PersistenceService_h
#define PersistenceService_h

@protocol PersistenceService <NSObject>

- (void) createOrUpdateFilms:(NSArray<Film*>*) films error:(NSError*) error;

@end

#endif /* PersistenceService_h */
