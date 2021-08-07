//
//  CoreDataService.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/7/21.
//

#import <UIKit/UIKit.h>

#import "CoreDataService.h"
#import "AppDelegate.h"
#import "FilmDao+CoreDataClass.h"
#import "FilmDao+CoreDataProperties.h"

@interface CoreDataService ()
@property NSManagedObjectContext *managedObjectContext;
@end

@implementation CoreDataService

- (id)init {
    self = [super init];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Database.sqlite"];
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = psc;
    
    return self;
}

- (void) createOrUpdateFilms:(NSArray<Film*>*) films error:(NSError*) error {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"FilmDao" inManagedObjectContext: self.managedObjectContext];
    
    for(Film *film in films) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FilmDao"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"episodeId == %d", film.episodeId]];
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        FilmDao *filmDao;
        if(results.count == 1) {
            filmDao = results[0];
        } else {
            filmDao = [[FilmDao alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        }
        
        filmDao.episodeId = film.episodeId;
        filmDao.title = film.title;
        filmDao.director = film.director;
        filmDao.crawlString = film.crawlString;
        filmDao.releaseDate = film.releaseDate;
    }
    
    [self.managedObjectContext save:&error];
}

@end
