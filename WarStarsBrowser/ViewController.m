//
//  ViewController.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "ViewController.h"

#import "NetworkService.h"
#import "NSURLSessionService.h"
#import "ServiceLocator.h"

@interface ViewController ()
@property (weak, nonatomic) id <NetworkService> netService;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    [self loadFilms];
}

- (void) loadFilms {
    [[ServiceLocator getNetworkService]  fetchFilms:^(NSArray<Film*> *newFilms, NSError* error ) {
        if(error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Fetching Films" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //button click event
                    }];
                
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            });
        } else {
            self.films = newFilms;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section {
    if(self.films) {
        return self.films.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"standardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Film* film = [self.films objectAtIndex:indexPath.row];
    [cell.textLabel setText:film.title];
    
    return cell;
}

#pragma mark - Table View Delegate

@end
