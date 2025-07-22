import Foundation
import UIKit

final class LocationsListAdapter: NSObject, UITableViewDataSource {
    var locations: [LocationsListRowPresenterProtocol]
        
    init(locations: [LocationsListRowPresenterProtocol] = []) {
        self.locations = locations
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.isEmpty {
            tableView.setCustomEmptyView(title: "No locations found", message: "Press + button to add new location", image: UIImage(systemName: "globe"))
        } else {
            tableView.restore()
        }
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsListTableViewCell", for: indexPath) as! LocationsListTableViewCell
        
        let presenter = locations[indexPath.row]
        cell.configure(presenter: presenter)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
