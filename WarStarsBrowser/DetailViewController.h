//
//  DetailViewController.h
//  WarStarsBrowser
//
//  Created by Scott Anderson on 8/6/21.
//

#import <UIKit/UIKit.h>

#import "Film.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic) Film *film;

@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UILabel *directorLabel;
@property (nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (nonatomic) IBOutlet UITextView *crawlText;

@end

NS_ASSUME_NONNULL_END
