
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Backendless-Swift.h>

#define utils Utils.sharedInstance

@interface Utils : NSObject

@property (strong, nonatomic) NSString *currentObjectId;

+(instancetype)sharedInstance;

- (NSString *)createStringForTableName:(NSString *)tableName;
- (NSString *)updateStringForTableName:(NSString *)tableName;
- (NSString *)deleteStringForTableName:(NSString *)tableName;
- (NSString *)basicFindStringForTableName:(NSString *)tableName;
- (NSString *)firstFindStringForTableName:(NSString *)tableName;
- (NSString *)lastFindStringForTableName:(NSString *)tableName;
- (NSString *)sortFindSringForTableName:(NSString *)tableName sortBy:(NSArray<NSString *> *)sortBy;
- (NSString *)relatedFindSringForTableName:(NSString *)tableName related:(NSString *)related;

- (NSString *)createMessageForEmail:(NSString *)method codeSample:(NSString *)codeSample;
- (NSString *)cellTitle:(NSString *)value type:(NSString *)type;

- (void)showErrorAlert:(UIViewController *)target fault:(Fault *)fault;
- (void)showCreatedAlert:(UIViewController *)target objectId:(NSString *)objectId;
- (void)showUpdatedAlert:(UIViewController *)target objectId:(NSString *)objectId;
- (void)showDeletedAlert:(UIViewController *)target objectId:(NSString *)objectId;
- (void)showSendByEmailAlert:(UIViewController *)target message:(NSString *)message;

@end
