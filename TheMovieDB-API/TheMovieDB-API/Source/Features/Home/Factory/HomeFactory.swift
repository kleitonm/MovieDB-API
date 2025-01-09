//
//  HomeFactory.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 09/01/25.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let controller = HomeViewController()
        return controller
    }
}
