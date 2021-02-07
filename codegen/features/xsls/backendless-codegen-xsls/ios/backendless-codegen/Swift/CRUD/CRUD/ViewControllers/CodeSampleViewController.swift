
import UIKit
import Backendless

class CodeSampleViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var tableName = ""
    var operation = ""
    var related: String?
    var sortBy: [String]?
    
    private let CREATE = "Create"
    private let UPDATE = "Update"
    private let DELETE  = "Delete"
    
    private let BASIC_FIND = "Basic find"
    private let FIND_FIRST = "Find first"
    private let FIND_LAST = "Find last"
    private let FIND_SORT = "Find with sort"
    private let FIND_RELATED = "Find with related"
    
    private let SHOW_PROPERTIES = "ShowTableProperties"
    private let SHOW_OBJECTS_WITH_RELATIONS = "ShowObjectsWithRelations"
    
    private let utils = Utils.shared
    
    private var dataStore: MapDrivenDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCodeSample()
        dataStore = Backendless.shared.data.ofTable(tableName)
    }
    
    func prepareCodeSample() {
        if operation == CREATE {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.createStringForTableName(table)
                }
            }
        }
        else if operation == UPDATE {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.updateStringForTableName(table)
                }
            }
        }
        else if operation == DELETE {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.deleteStringForTableName(table)
                }
            }
        }
        else if operation == BASIC_FIND {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.basicFindStringForTableName(table)
                }
            }
        }
        else if operation == BASIC_FIND {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.basicFindStringForTableName(table)
                }
            }
        }
        else if operation == FIND_FIRST {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.firstFindStringForTableName(table)
                }
            }
        }
        else if operation == FIND_LAST {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName {
                    self?.textView.text = self?.utils.lastFindStringForTableName(table)
                }
            }
        }
        else if operation == FIND_SORT {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName,
                    let sort = self?.sortBy {
                    self?.textView.text = self?.utils.sortFindStringForTableName(table, sortBy: sort)
                }
            }
        }
        else if operation == FIND_RELATED {
            DispatchQueue.main.async { [weak self] in
                if let table = self?.tableName,
                    let relations = self?.related {
                    self?.textView.text = self?.utils.relatedFindStringForTableName(table, related: relations)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_PROPERTIES,
            let propertiesVC = segue.destination as? PropertiesViewController {
            propertiesVC.tableName = tableName
            propertiesVC.operation = operation
            if propertiesVC.operation == FIND_SORT {
                propertiesVC.sortBy = sortBy
            }
            Backendless.shared.data.describe(tableName: tableName, responseHandler: { properties in
                var fields = [String : String]()
                for property in properties {
                    if property.getTypeName() != "RELATION" && property.getTypeName() != "RELATION_LIST" {
                        fields[property.name] = property.getTypeName()
                    }              
                }
                propertiesVC.fields = fields
                propertiesVC.tableView.reloadData()
            }, errorHandler: { [weak self] fault in
                if self != nil {
                    self?.utils.showErrorAler(target: self!, fault: fault)
                }
            })
        }
        else if segue.identifier == SHOW_OBJECTS_WITH_RELATIONS,
            let objectsWithRelsVC = segue.destination as? ObjectsWithRelationsViewController,
            let related = related {
            objectsWithRelsVC.related = related
            objectsWithRelsVC.tableName = tableName
            dataStore.find(responseHandler: { [weak self] foundObjects in
                var objectIds = [String]()
                for foundObject in foundObjects {
                    if let objId = foundObject["objectId"] as? String {
                        objectIds.append(objId)
                    }
                }
                if let table = self?.tableName {
                    Backendless.shared.data.describe(tableName: table, responseHandler: { properties in
                        for property in properties {
                            if property.getTypeName() == "RELATION" || property.getTypeName() == "RELATION_LIST",
                                let relatedTable = property.relatedTable {
                                objectsWithRelsVC.relatedTableName = relatedTable
                                objectsWithRelsVC.propertyType = property.getTypeName()
                                objectsWithRelsVC.objectIds = objectIds
                                objectsWithRelsVC.tableView.reloadData()
                            }
                        }
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }                        
                    })
                }
                }, errorHandler: { [weak self] fault in
                    if self != nil {
                        self?.utils.showErrorAler(target: self!, fault: fault)
                    }
            })
        }
    }
    
    @IBAction func runCode(_ sender: Any) {
        if operation == CREATE {
            let newObject = ["codegen": "new object"]
            dataStore.save(entity: newObject, responseHandler: { [weak self] savedObject in
                if let objectId = savedObject["objectId"] as? String,
                    self != nil {
                    self?.utils.currentObjectId = objectId
                    self?.utils.showCreatedAlert(target: self!, objectId: objectId)
                }
                }, errorHandler: { [weak self] fault in
                    if self != nil {
                        self?.utils.showErrorAler(target: self!, fault: fault)
                    }
            })
        }
        else if operation == UPDATE {
            if let objectId = utils.currentObjectId {
                let object = ["codegen": "updatedObject", "objectId": objectId]
                dataStore.update(entity: object, responseHandler: { [weak self] updatedObject in
                    if self != nil {
                        self?.utils.showUpdatedAlert(target: self!, objectId: objectId)
                    }
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                })
            }
            else {
                let fault = Fault(message: "Please create object before updating", faultCode: 0)
                utils.showErrorAler(target: self, fault: fault)
            }
        }
        else if operation == DELETE {
            if let objectId = utils.currentObjectId {
                dataStore.removeById(objectId: objectId, responseHandler: { [weak self] removed in
                    if self != nil {
                        self?.utils.showDeletedAlert(target: self!, objectId: objectId)
                        self?.utils.currentObjectId = nil
                    }
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                })
            }
            else {
                let fault = Fault(message: "Please create object before deleting", faultCode: 0)
                utils.showErrorAler(target: self, fault: fault)
            }
        }
        else if operation == FIND_RELATED {
            performSegue(withIdentifier: SHOW_OBJECTS_WITH_RELATIONS, sender: nil)
        }
        else {
            performSegue(withIdentifier: SHOW_PROPERTIES, sender: nil)
        }
    }
    
    @IBAction func sendCodeByEmail(_ sender: Any) {
        utils.showSendByEmailAlert(target: self, message: utils.createMessageForEmail(method: operation, codeSample: textView.text))
    }
}
