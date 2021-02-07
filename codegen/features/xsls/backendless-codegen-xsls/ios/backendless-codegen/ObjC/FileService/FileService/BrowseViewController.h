
#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *mainTableView;

- (IBAction)pressedRemoveAll:(id)sender;

@end
