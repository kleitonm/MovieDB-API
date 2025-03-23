
import UIKit

final class HomeView: UIView {
    
    // MARK: - UI
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadImage: UIPickerView = {
        let loadImage = UIPickerView()
        loadImage.translatesAutoresizingMaskIntoConstraints = false
        return loadImage
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: ViewConfig {
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
