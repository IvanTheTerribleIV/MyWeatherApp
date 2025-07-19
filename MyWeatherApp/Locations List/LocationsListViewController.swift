import UIKit

final class LocationsListViewController: UIViewController {
    var mainView: LocationsListesView { return view as! LocationsListView  }
    
    var presenter: LocationsListPresenterProtocol?
    var LocationsListProvider: LocationsListAdapter?
    
    override func loadView() {
        view = LocationsListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationsListProvider = LocationsListAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension LocationsListViewController: LocationsListUI {
    func update(heroes: [CharacterDataModel]) {
        LocationsListProvider?.heroes = heroes
    }
}

extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = LocationsListPresenter()
        let LocationsListViewController = LocationsListViewController()
        LocationsListViewController.presenter = presenter
        
        navigationController?.pushViewController(LocationsListViewController, animated: true)
    }
}

