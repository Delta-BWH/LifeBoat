
import UIKit
import Backendless

class Utils: NSObject {
    static let shared = Utils()
    
    var currentObjectId: String?
    
    private override init() { }
    
    func createStringForTableName(_ tableName: String) -> String {
        return """
let newObject = ["codegen": "new object"]
        
Backendless.shared.data.ofTable(\"\(tableName)\").save(entity: newObject, responseHandler: { savedObject in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func updateStringForTableName(_ tableName: String) -> String {
        return """
let object = ["codegen": "updatedObject", "objectId": \(currentObjectId ?? "")]
        
Backendless.shared.data.ofTable(\"\(tableName)\").update(entity: object, responseHandler: { updatedObject in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func deleteStringForTableName(_ tableName: String) -> String {
        return """
Backendless.shared.data.ofTable(\"\(tableName)\").removeById(objectId: objectId, responseHandler: { removed in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func basicFindStringForTableName(_ tableName: String) -> String {
        return """
Backendless.shared.data.ofTable(\"\(tableName)\").find(responseHandler: { foundObjects in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func firstFindStringForTableName(_ tableName: String) -> String {
        return """
Backendless.shared.data.ofTable(\"\(tableName)\").findFirst(responseHandler: { firstObject in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func lastFindStringForTableName(_ tableName: String) -> String {
        return """
Backendless.shared.data.ofTable(\"\(tableName)\").findLast(responseHandler: { lastObject in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func sortFindStringForTableName(_ tableName: String, sortBy: [String]) -> String {
        var sortByString = ""
        for sortByElement in sortBy {
            sortByString += "\"" + sortByElement + "\", "
        }
        sortByString = String(sortByString.dropLast(2))
        return """
let queryBuilder = DataQueryBuilder()
queryBuilder.setSortBy(sortBy: [\(sortByString)])

Backendless.shared.data.ofTable(\"\(tableName)\").find(queryBuilder: queryBuilder, responseHandler: { sortedObjects in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    func relatedFindStringForTableName(_ tableName: String, related: String) -> String {
        return """
let queryBuilder = DataQueryBuilder()
queryBuilder.setRelated(related: [\"\(related)\"])
        
Backendless.shared.data.ofTable(tableName).findById(objectId: "SELECTED_OBJECT_ID", queryBuilder: queryBuilder, responseHandler: { foundObject in
    // handle response
}, errorHandler: { fault in
    // handle fault
})
"""
    }
    
    // **************************************
    
    func createMessageForEmail(method: String, codeSample: String) -> String {
        return "\(method) object: \n------------------------------\n\n" + codeSample + "\n\n------------------------------\nBackendless Team"
    }
    
    func cellTitle(value: Any, type: String) -> String {
        if !(value is NSNull) {
            if type == "STRING" || type == "TEXT" || type == "STRING_ID" {
                return value as! String
            }
            else if type == "INT" || type == "DOUBLE" {
                return (value as! NSNumber).stringValue
            }
            else if type == "DATETIME" {
                let timestamp = (value as! Double) / 1000
                let date = Date(timeIntervalSince1970: timestamp)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/YYYY HH:mm:ss"
                return dateFormatter.string(from: date)
            }
            else if type == "BOOLEAN" {
                if let value = value as? Bool {
                    return value ? "TRUE" : "FALSE"
                }
            }
        }
        return "no value"
    }
    
    // **************************************
    
    func showErrorAler(target: UIViewController, fault: Fault) {
        let alert = UIAlertController(title: "Error", message: fault.message ?? "", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        target.present(alert, animated: true, completion: nil)
    }
    
    func showCreatedAlert(target: UIViewController, objectId: String) {
        let alert = UIAlertController(title: "Object saved", message: "Object has been created.\nObject Id - \(objectId)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        target.present(alert, animated: true, completion: nil)
    }
    
    func showUpdatedAlert(target: UIViewController, objectId: String) {
        let alert = UIAlertController(title: "Object updated", message: "Object has been updated.\nObject Id - \(objectId)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        target.present(alert, animated: true, completion: nil)
    }
    
    func showDeletedAlert(target: UIViewController, objectId: String) {
        let alert = UIAlertController(title: "Object deleted", message: "Object has been deleted.\nObject Id - \(objectId)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        target.present(alert, animated: true, completion: nil)
    }
    
    func showSendByEmailAlert(target: UIViewController, message: String) {
        let alert = UIAlertController(title: "Send code sample", message: "Enter your email address to send code sample", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { emailField in
            emailField.placeholder = "Email address"
        })
        let send = UIAlertAction(title: "Send", style: .default, handler: { action in
            if let recipient = alert.textFields?.first?.text {
                let bodyparts = EmailBodyparts()
                bodyparts.textMessage = message
                Backendless.shared.messaging.sendEmail(subject: "Backendless CRUD sample", bodyparts: bodyparts, recipients: [recipient], attachments: nil, responseHandler: { [weak self] status in
                    self?.showSentEmailAddress(target: target)
                    }, errorHandler: { [weak self] fault in
                        self?.showErrorAler(target: target, fault: fault)
                })
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(send)
        alert.addAction(cancel)
        target.present(alert, animated: true, completion: nil)
    }
    
    private func showSentEmailAddress(target: UIViewController) {
        let alert = UIAlertController(title: "Code sample has been sent", message: "Please check your email", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        target.present(alert, animated: true, completion: nil)
    }
}
