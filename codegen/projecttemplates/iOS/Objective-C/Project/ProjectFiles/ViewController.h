
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *objectSavedLabel;
@property (strong, nonatomic) IBOutlet UILabel *liveUpdateObjectPropertyLabel;
@property (strong, nonatomic) IBOutlet UILabel *propertyLabel;
@property (strong, nonatomic) IBOutlet UITextField *changePropertyValueTextField;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;

- (IBAction)pressedUpdate:(id)sender;

@end