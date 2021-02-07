
import UIKit
import Backendless

class ObjectsWithRelationsViewController: UITableViewController {
    
    var tableName = ""
    var objectIds = [String]()
    var related = ""
    var relatedTableName = ""
    var propertyType = ""
    
    private let FIND_RELATED = "Find with related"
    private let SHOW_PROPERTIES = "ShowRelatedProperties"
    
    private let utils = Utils.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectIds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectIdCell", for: indexPath)
        cell.textLabel?.text = objectIds[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SHOW_PROPERTIES, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let propertiesVC = segue.destination as? PropertiesViewController,
            let indexPath = sender as? IndexPath {
            propertiesVC.operation = FIND_RELATED
            propertiesVC.related = related
            propertiesVC.objectId = objectIds[indexPath.row]
            propertiesVC.tableName = relatedTableName
            Backendless.shared.data.describe(tableName: relatedTableName, responseHandler: { properties in
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
    }
}

