
#import <UIKit/UIKit.h>

@interface CodeSampleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *operation;
@property (strong, nonatomic) NSString *related;
@property (strong, nonatomic) NSArray<NSString *> *sortBy;

@end
