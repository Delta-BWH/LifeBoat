
#import <UIKit/UIKit.h>
#import <Backendless-Swift.h>

@interface ObjectsViewController : UITableViewController

@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *propertyName;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSArray<NSString *> *objects;

@end
