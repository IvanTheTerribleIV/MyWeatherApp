import Foundation
import UIKit

final class LocationsListAdapter: NSObject, UITableViewDataSource {
    var locations: [LocationModel] 
        
    init(locations: [LocationModel] = []) {
        self.locations = locations
        super.init()
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
