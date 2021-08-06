//
//  ViewController.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/4/21.
//

#import <UIKit/UIKit.h>

#import "Film.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic) NSArray<Film*> *films;

@end

