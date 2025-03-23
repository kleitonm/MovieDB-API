//
//  HomeCell.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//
import UIKit

final class HomeCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - UI
    private lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(movie: MovieResult) {
        didDownloadImage(url: movie.posterPath ?? "")
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
    
}

extension HomeCell {
    private func didDownloadImage(url: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(url).jpg") {
            image.load(urlImage: url, mode: .scaleAspectFit)
        }
    }
}

extension HomeCell: ViewConfig {
    func buildHierarchy() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func applyAdditionalChanges() {
        backgroundColor = .systemBackground
    }
}
