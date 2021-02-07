
#import <UIKit/UIKit.h>

@interface ObjectsWithRelationsViewController : UITableViewController

@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSArray<NSString *> *objectIds;
@property (strong, nonatomic) NSString *related;
@property (strong, nonatomic) NSString *relatedTableName;
@property (strong, nonatomic) NSString *propertyType;

@end
