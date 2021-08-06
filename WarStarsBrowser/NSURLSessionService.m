//
//  NSURLSessionService.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "NSURLSessionService.h"

@implementation NSURLSessionService

- (void)fetchFilms:(FilmFetcherCallback)fetcherCallback {
    NSURL *filmsURL = [NSURL URLWithString:@"https://swapi.dev/api/films/"];
    //NSURL *filmsURL = [NSURL URLWithString:@"https://www.swapi.tech/api/films"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:filmsURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            
            NSMutableArray<Film*> *newFilms = [[NSMutableArray alloc] init];
            
            //Try to handle the JSON differences between swapi.dev and swapi.tech
            NSArray *filmArray;
            
            if(responseDictionary[@"results"]) {
                filmArray = responseDictionary[@"results"];
            } else if(responseDictionary[@"result"]) {
                filmArray = responseDictionary[@"result"];
            }
            
            for (NSDictionary *filmDict in filmArray) {
                //Check for the properties field if it's there then it's swapi.tech
                if(filmDict[@"properties"]) {
                    [newFilms addObject:[Film buildPersonFromDict:filmDict[@"properties"]]];
                } else {
                    [newFilms addObject:[Film buildPersonFromDict:filmDict]];
                }
            }
            fetcherCallback(newFilms, nil);
            
            NSLog(@"Found %lu Films", newFilms.count);
        }
        else
        {
            NSLog(@"Error Fetching Films, %@", error.localizedDescription);
            fetcherCallback(nil, error);
        }
    }];
    [dataTask resume];
}

@end
