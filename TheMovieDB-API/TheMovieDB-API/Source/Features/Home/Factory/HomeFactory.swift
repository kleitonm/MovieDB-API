//
//  HomeFactory.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let service = HomeService()
        let viewModel = HomeViewModel(service: service)
        let controller = HomeViewController(viewModel: viewModel)
        return controller
    }
}
