import Foundation
import UIKit

final class LocationsListView: UIView {
    private enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LocationsListTableViewCell.self, forCellReuseIdentifier: "LocationsListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        return tableView
    }()
    
    private let tableViewDataSource: LocationsListAdapter
    
    init(tableViewDelegate: UITableViewDelegate, tableViewDataSource: LocationsListAdapter = .init()) {
        self.tableViewDataSource = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension LocationsListView: LocationsListUI {
    func update(locations: [LocationModel]) {
        tableViewDataSource.locations = locations
        tableView.reloadData()
    }
}
