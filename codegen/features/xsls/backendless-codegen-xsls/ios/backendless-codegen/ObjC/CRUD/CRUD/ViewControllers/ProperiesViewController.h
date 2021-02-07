
#import <UIKit/UIKit.h>

@interface ProperiesViewController : UITableViewController

@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *operation;
@property (strong, nonatomic) NSDictionary<NSString *, NSString *> *fields;
@property (strong, nonatomic) NSArray<NSString *> *sortBy;
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *related;

@end
