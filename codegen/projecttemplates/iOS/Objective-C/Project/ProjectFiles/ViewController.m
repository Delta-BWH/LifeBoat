
#import "ViewController.h"
#import <Backendless-Swift.h>

@interface ViewController() {
    MapDrivenDataStore *dataStore;
    NSMutableDictionary *testObject;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.changePropertyValueTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self saveTestObject];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([textField.text length] > 0) {
        self.updateButton.enabled = YES;
    }
    else {
        self.updateButton.enabled = NO;
    }
}

- (void)showErrorAlert:(Fault *)fault {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Error %ld", (long)fault.faultCode] message:fault.message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissButton = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:dismissButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveTestObject {
    dataStore = [Backendless.shared.data ofTable:@"TestTable"];
    testObject = [NSMutableDictionary dictionaryWithDictionary:@{@"foo" : @"Hello World"}];
    [dataStore saveWithEntity:testObject responseHandler:^(NSDictionary *savedTestObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.objectSavedLabel.text = @"Object has been saved in the real-time database";
            self.liveUpdateObjectPropertyLabel.text = @"Live update object property";
            self.propertyLabel.text = [savedTestObject valueForKey:@"foo"];
        });
        self->testObject = [NSMutableDictionary dictionaryWithDictionary:savedTestObject];
        EventHandlerForMap *eventHandler = self->dataStore.rt;
        NSString *whereClause = [NSString stringWithFormat:@"objectId = '%@'", [savedTestObject valueForKey:@"objectId"]];
        RTSubscription *subscription __unused = [eventHandler addUpdateListenerWithWhereClause:whereClause responseHandler:^(NSDictionary *updatedTestObject) {
            if ([updatedTestObject valueForKey:@"foo"]) {
                self.propertyLabel.text = [updatedTestObject valueForKey:@"foo"];
            }
        } errorHandler:^(Fault *fault) {
            [self showErrorAlert:fault];
        }];
    } errorHandler:^(Fault *fault) {
        [self showErrorAlert:fault];
    }];
}

- (IBAction)pressedUpdate:(id)sender {
    [testObject setValue:self.changePropertyValueTextField.text forKey:@"foo"];
    [dataStore updateWithEntity:testObject responseHandler:^(NSDictionary *updatedTestObject) {
    } errorHandler:^(Fault *fault) {
        [self showErrorAlert:fault];
    }];
    self.changePropertyValueTextField.text = @"";
    self.updateButton.enabled = NO;
}

@end
            
