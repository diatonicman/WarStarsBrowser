//
//  DetailViewController.m
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/6/21.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _film.title;
    
    NSString *directorString = [NSString stringWithFormat:@"Directed By: %@", _film.director];
    _directorLabel.text = directorString;
    
    NSDateFormatter* dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"EEEE MMM d, yyyy"];
    NSString *displayDate = [dateformat stringFromDate: _film.releaseDate];
    NSString *releaseString = [NSString stringWithFormat:@"Released: %@", displayDate];
    _releaseDateLabel.text = releaseString;
    
    _crawlText.text = _film.crawlString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
