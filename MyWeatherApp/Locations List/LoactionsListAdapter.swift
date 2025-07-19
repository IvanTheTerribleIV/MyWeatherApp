import Foundation
import UIKit

final class LocationsListAdapter: NSObject, UITableViewDataSource {
    var heroes: [LocationModel] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView
    
    init(tableView: UITableView, heroes: [LocationModel] = []) {
        self.tableView = tableView
        self.heroes = heroes
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsListTableViewCell", for: indexPath) as! LocationsListTableViewCell
        
        let model = heroes[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}
