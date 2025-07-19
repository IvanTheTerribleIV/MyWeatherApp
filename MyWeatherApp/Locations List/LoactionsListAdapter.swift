import Foundation
import UIKit

final class LocationsListAdapter: NSObject, UITableViewDataSource {
    var locations: [LocationModel] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let tableView: UITableView
    
    init(tableView: UITableView, locations: [LocationModel] = []) {
        self.tableView = tableView
        self.locations = locations
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsListTableViewCell", for: indexPath) as! LocationsListTableViewCell
        
        let model = locations[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}
