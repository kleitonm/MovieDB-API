//
//  ViewController.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 08/01/25.
//

import UIKit

final class HomeViewController: UIViewController {

    private var viewModel: HomeViewModelProtocol
    private lazy var customView: HomeView = {
        let homeView = HomeView()
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        return homeView
    }()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "The MovieDB"
        navigationItem.largeTitleDisplayMode = .always
        handler()
        binded()
    }
    
    override func loadView() {
        view = customView
    }
    
    func handler() {
        viewModel.handler { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movie):
                self.viewModel.allMovies.value = movie.results
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
}

extension HomeViewController {
    // MARK: - private func
    private func binded() {
        DispatchQueue.main.async {
            self.viewModel.allMovies.bind { _ in
                self.customView.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allMovies.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier,
                                                       for: indexPath) as? HomeCell else { return UITableViewCell()}
        if let movie = viewModel.allMovies.value?[indexPath.row] {
            cell.setupCell(movie: movie)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
