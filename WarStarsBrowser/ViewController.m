//
//  ViewController.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import "ViewController.h"

#import "DetailViewController.h"
#import "NetworkService.h"
#import "NSURLSessionService.h"
#import "ServiceLocator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) id <NetworkService> netService;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self loadFilms];
}

- (void) loadFilms {
    [self.activityIndicator startAnimating];
    [[ServiceLocator getNetworkService]  fetchFilms:^(NSArray<Film*> *newFilms, NSError* error ) {
        if(error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
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
                [self.activityIndicator stopAnimating];
            });
            
            [self saveFilms];
        }
    }];
    
}

- (void) saveFilms {
    NSError *error = nil;
    
    [[ServiceLocator getPersistenceService] createOrUpdateFilms:self.films error:error];
    if(error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Saving Films" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //button click event
            }];
                
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailController = segue.destinationViewController;
        detailController.film = [self.films objectAtIndex:indexPath.row];
    }
}

@end
