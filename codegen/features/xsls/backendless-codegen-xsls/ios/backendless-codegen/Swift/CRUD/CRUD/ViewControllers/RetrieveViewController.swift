
import UIKit
import Backendless

class RetrieveViewController: UITableViewController {
    
    var tableName = ""
    
    private var retrieveTypes = [String]()
    private var sortBy = [String]()
    
    private let BASIC_FIND = "Basic find"
    private let FIND_FIRST = "Find first"
    private let FIND_LAST = "Find last"
    private let FIND_SORT = "Find with sort"
    private let FIND_RELATED = "Find with related"
    
    private let SHOW_SAMPLE = "ShowCodeSampleFromRetrieve"
    private let SHOW_SORT = "ShowSortBy"
    private let SHOW_RELATED = "ShowRelated"
    
    private let utils = Utils.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveTypes = [BASIC_FIND, FIND_FIRST, FIND_LAST, FIND_SORT, FIND_RELATED]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetrieveTypeCell", for: indexPath)
        cell.textLabel?.text = retrieveTypes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if retrieveTypes[indexPath.row] == FIND_SORT {
            performSegue(withIdentifier: SHOW_SORT, sender: nil)
        }
        else if retrieveTypes[indexPath.row] == FIND_RELATED {
            performSegue(withIdentifier: SHOW_RELATED, sender: nil)
        }
        else {
            performSegue(withIdentifier: SHOW_SAMPLE, sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_SORT,
            let sortVC = segue.destination as? SortViewController {
            sortVC.tableName = tableName
            Backendless.shared.data.describe(tableName: tableName, responseHandler: { properties in
                var fields = [String]()
                for property in properties {
                    if property.getTypeName() != "RELATION" && property.getTypeName() != "RELATION_LIST" {
                        fields.append(property.name)
                    }
                }
                sortVC.fields = fields
                sortVC.tableView.reloadData()
            }, errorHandler: { [weak self] fault in
                if self != nil {
                    self?.utils.showErrorAler(target: self!, fault: fault)
                }
            })
        }
        else if segue.identifier == SHOW_RELATED {
            if let relatedVC = segue.destination as? RelatedViewController {
                relatedVC.tableName = tableName
                Backendless.shared.data.describe(tableName: tableName, responseHandler: { properties in
                    var fields = [String]()
                    for property in properties {
                        if property.getTypeName() == "RELATION" || property.getTypeName() == "RELATION_LIST" {
                            fields.append(property.name)
                        }
                    }
                    relatedVC.fields = fields
                    relatedVC.tableView.reloadData()
                }, errorHandler: { [weak self] fault in
                    if self != nil {
                        self?.utils.showErrorAler(target: self!, fault: fault)
                    }
                })
            }
        }
        else if segue.identifier == SHOW_SAMPLE {
            if let codeSampleVC = segue.destination as? CodeSampleViewController,
                let indexPath = sender as? IndexPath {
                codeSampleVC.tableName = tableName
                codeSampleVC.operation = retrieveTypes[indexPath.row]
            }
        }
    }
}
