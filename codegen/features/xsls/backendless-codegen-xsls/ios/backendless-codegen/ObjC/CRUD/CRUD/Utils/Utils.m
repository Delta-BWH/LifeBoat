
#import "Utils.h"
#
#import <Backendless-Swift.h>

@implementation Utils

+(instancetype)sharedInstance {
    static Utils *sharedUtils;
    @synchronized(self) {
        if (!sharedUtils)
            sharedUtils = [Utils new];
    }
    return sharedUtils;
}

- (NSString *)createStringForTableName:(NSString *)tableName {
    NSString *str1 = [NSString stringWithFormat:@"NSDictionary *newObject = @{@\"codegen\": @\"new object\"};"];
    NSString *str2 = [NSString stringWithFormat:@"\n\n[[Backendless.shared.data ofTable:@\"%@\"] saveWithEntity:newObject responseHandler:^(NSDictionary *savedObject) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
    return [str1 stringByAppendingString:str2];
}

- (NSString *)updateStringForTableName:(NSString *)tableName {
    NSString *str1 = [NSString stringWithFormat:@"NSDictionary *object = @{@\"codegen\": @\"updated object\", @\"objectId\": \"%@\"};", self.currentObjectId];
    NSString *str2 = [NSString stringWithFormat:@"\n\n[[Backendless.shared.data ofTable:@\"%@\"] updateWithEntity:object responseHandler:^(NSDictionary *updatedObject) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
    return [str1 stringByAppendingString:str2];
}

- (NSString *)deleteStringForTableName:(NSString *)tableName {
    return [NSString stringWithFormat:@"[[Backendless.shared.data ofTable:@\"%@\"] removeByIdWithObjectId:\"%@\" responseHandler:^(NSInteger removed) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName, self.currentObjectId];
}

- (NSString *)basicFindStringForTableName:(NSString *)tableName {    
    return [NSString stringWithFormat:@"[[Backendless.shared.data ofTable:@\"%@\"] findWithResponseHandler:^(NSArray *foundObjects) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
}

- (NSString *)firstFindStringForTableName:(NSString *)tableName {
    return [NSString stringWithFormat: @"[[Backendless.shared.data ofTable:@\"%@\"] findFirstWithResponseHandler:^(NSDictionary *firstObject) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
}

- (NSString *)lastFindStringForTableName:(NSString *)tableName {
    return [NSString stringWithFormat: @"[[Backendless.shared.data ofTable:@\"%@\"] findLastWithResponseHandler:^(NSDictionary *lastObject) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
}

- (NSString *)sortFindSringForTableName:(NSString *)tableName sortBy:(NSArray<NSString *> *)sortBy {
    NSString *sortByString = @"\"@";
    for (NSString *sortByElement in sortBy) {
        sortByString = [[sortByString stringByAppendingString:sortByElement] stringByAppendingString:@"\", "];
    }
    sortByString = [sortByString substringToIndex:sortByString.length - 2];
    NSString *str1 = [NSString stringWithFormat:@"DataQueryBuilder *queryBuilder = [DataQueryBuilder new];\n[queryBuilder setSortBySortBy:@[%@]];", sortByString];
    NSString *str2 = [NSString stringWithFormat: @"\n\n[[Backendless.shared.data ofTable:@\"%@\"] findWithQueryBuilder:queryBuilder responseHandler:^(NSArray *sortedObjects) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
    return [str1 stringByAppendingString:str2];
}

- (NSString *)relatedFindSringForTableName:(NSString *)tableName related:(NSString *)related {
    NSString *str1 = [NSString stringWithFormat:@"DataQueryBuilder *queryBuilder = [DataQueryBuilder new];\n[queryBuilder setRelatedWithRelated:@[@\"%@\"]];", related];
    NSString *str2 = [NSString stringWithFormat: @"\n\n[[Backendless.shared.data ofTable:@\"%@\"] findByIdWithObjectId:SELECTED_OBJECT_ID queryBuilder:queryBuilder responseHandler:^(NSDictionary *foundObject) {\n    // handle response\n} errorHandler:^(Fault *fault) {\n    // handle fault\n}];", tableName];
    return [str1 stringByAppendingString:str2];
}

// **************************************

- (NSString *)createMessageForEmail:(NSString *)method codeSample:(NSString *)codeSample {
    return [NSString stringWithFormat:[[@"%@ object: \n------------------------------\n\n" stringByAppendingString:codeSample] stringByAppendingString:@"\n\n------------------------------\nBackendless Team"], method];
}

- (NSString *)cellTitle:(NSString *)value type:(NSString *)type {
    if (![value isKindOfClass:[NSNull class]]) {
        if ([type isEqualToString:@"STRING"] ||
            [type isEqualToString:@"TEXT"] ||
            [type isEqualToString:@"STRING_ID"]) {
            return value;
        }
        else if ([type isEqualToString:@"INT"]) {
            return [NSString stringWithFormat: @"%li", (long)((NSInteger)value)];
        }
        else if ([type isEqualToString:@"DOUBLE"]) {
            return [NSString stringWithFormat: @"%f", value.doubleValue];
        }
        else if ([type isEqualToString:@"DATETIME"]) {
            double timestamp = [value doubleValue] / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"MM/dd/YYYY HH:mm:ss";
            return [dateFormatter stringFromDate:date];
        }
        else if ([type isEqualToString:@"BOOLEAN"]) {
            return value.boolValue ? @"TRUE" : @"FALSE";
        }
    }
    return @"no value";
}

// **************************************

- (void)showErrorAlert:(UIViewController *)target fault:(Fault *)fault {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:fault.message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:dismiss];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)showCreatedAlert:(UIViewController *)target objectId:(NSString *)objectId {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Object saved" message:[NSString stringWithFormat:@"Object has been created.\nObject Id - %@", objectId] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)showUpdatedAlert:(UIViewController *)target objectId:(NSString *)objectId {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Object updated" message:[NSString stringWithFormat:@"Object has been updated.\nObject Id - %@", objectId] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)showDeletedAlert:(UIViewController *)target objectId:(NSString *)objectId {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Object deleted" message:[NSString stringWithFormat:@"Object has been deleted.\nObject Id - %@", objectId] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)showSendByEmailAlert:(UIViewController *)target message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Send code sample" message:@"Enter your email address to send code sample" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *emailField) {
        emailField.placeholder = @"Email address";
    }];
    UIAlertAction *send = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *recipient = alert.textFields.firstObject.text;
        EmailBodyparts *bodyparts = [EmailBodyparts new];
        bodyparts.textMessage = message;
        [Backendless.shared.messaging sendEmailWithSubject:@"Backendless CRUD sample" bodyparts:bodyparts recipients:@[recipient] attachments:nil responseHandler:^(MessageStatus *status) {
            [self showSentEmailAlert:target];
        } errorHandler:^(Fault *fault) {
            [self showErrorAlert:target fault:fault];
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:send];
    [alert addAction:cancel];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)showSentEmailAlert:(UIViewController *)target {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Code sample has been sent" message:@"Please check your email" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [target presentViewController:alert animated:YES completion:nil];
}

@end
