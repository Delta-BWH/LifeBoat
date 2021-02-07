
#import <UIKit/UIKit.h>
#import <Backendless/Backendless-Swift.h>

@interface ChatViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *chatTextView;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) Channel *channel;

@end
