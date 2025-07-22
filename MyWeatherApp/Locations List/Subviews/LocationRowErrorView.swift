//
//  LocationRowErrorView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 21.07.2025.
//

import UIKit

final class LocationRowErrorView: UIView {
    private var presenter: LocationsListRowPresenterProtocol?

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to load weather data."
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(errorLabel)
        addSubview(reloadButton)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),

            reloadButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 100),
            reloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func retryTapped() {
        presenter?.getWeatherData()
    }
    
    func configure(presenter: LocationsListRowPresenterProtocol) {
        self.presenter = presenter
    }
}
