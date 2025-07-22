import Foundation
import UIKit

protocol LocationRowUI: AnyObject {
    func configure(presenter: LocationsListRowPresenterProtocol)
    func reload()
    func showErroState(presenter: LocationsListRowPresenterProtocol)
}

final class LocationsListTableViewCell: UITableViewCell {
    private var presenter: LocationsListRowPresenterProtocol?
    private let containerView: LocationRowContentView = {
        let view = LocationRowContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let errorView: LocationRowErrorView = {
        let view = LocationRowErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(errorView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            errorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            errorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension LocationsListTableViewCell: LocationRowUI {
    func configure(presenter: LocationsListRowPresenterProtocol) {
        self.presenter?.getDataTask?.cancel()
        containerView.configure(presenter: presenter)
        self.presenter = presenter
        self.presenter?.ui = self
        self.presenter?.getWeatherData()
        containerView.isHidden = false
        errorView.isHidden = true
    }
    
    func reload() {
        containerView.reload()
        containerView.isHidden = false
        errorView.isHidden = true
    }
    
    func showErroState(presenter: LocationsListRowPresenterProtocol) {
        errorView.configure(presenter: presenter)
        containerView.isHidden = true
        errorView.isHidden = false
    }
}
