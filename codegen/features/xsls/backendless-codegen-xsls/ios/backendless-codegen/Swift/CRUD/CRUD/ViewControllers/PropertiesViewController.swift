
import UIKit
import Backendless

class PropertiesViewController: UITableViewController {
    
    var tableName = ""
    var operation = ""
    var fields = [String : String]()
    var sortBy: [String]?
    var objectId: String?
    var related: String?
    
    private let BASIC_FIND = "Basic find"
    private let FIND_FIRST = "Find first"
    private let FIND_LAST = "Find last"
    private let FIND_SORT = "Find with sort"
    private let FIND_RELATED = "Find with related"
    private let SHOW_OBJECTS = "ShowObjects"
    
    private let utils = Utils.shared
    
    private var dataStore: MapDrivenDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(tableName) properties"
        dataStore = Backendless.shared.data.ofTable(tableName)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectPropertyCell", for: indexPath)
        cell.textLabel?.text = Array(fields.keys)[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SHOW_OBJECTS, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            let field = Array(fields.keys)[indexPath.row]
            
            if let objectsVC = segue.destination as? ObjectsViewController,
                let type = fields[field] {
                objectsVC.tableName = tableName
                objectsVC.propertyName = field
                objectsVC.type = type
                
                if operation == BASIC_FIND || operation == FIND_RELATED {
                    dataStore.find(responseHandler: { foundObjects in
                        var objects = [Any]()
                        for foundObject in foundObjects {
                            if let value = foundObject[field] {
                                objects.append(value)
                            }
                        }
                        objectsVC.objects = objects
                        objectsVC.tableView.reloadData()
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                    })
                }
                else if operation == FIND_FIRST {
                    dataStore.findFirst(responseHandler: { firstObject in
                        if let value = firstObject[field] {
                            objectsVC.objects = [value]
                            objectsVC.tableView.reloadData()
                        }
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                    })
                }
                else if operation == FIND_LAST {
                    dataStore.findLast(responseHandler: { lastObject in
                        if let value = lastObject[field] {
                            objectsVC.objects = [value]
                            objectsVC.tableView.reloadData()
                        }
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                    })
                }
                else if operation == FIND_SORT,
                    let sortBy = sortBy {
                    let queryBuilder = DataQueryBuilder()
                    queryBuilder.setSortBy(sortBy: sortBy)
                    
                    dataStore.find(queryBuilder: queryBuilder, responseHandler: { sortedObjects in
                        var objects = [Any]()
                        for object in sortedObjects {
                            if let value = object[field] {
                                objects.append(value)
                            }
                        }
                        objectsVC.objects = objects
                        objectsVC.tableView.reloadData()
                    }, errorHandler: { [weak self] fault in
                        if self != nil {
                            self?.utils.showErrorAler(target: self!, fault: fault)
                        }
                    })
                }
            }
        }
    }
}
