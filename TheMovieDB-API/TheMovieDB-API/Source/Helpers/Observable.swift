//
//  Observable.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 15/01/25.
//

import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                listener?(value)
            }
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ listener: (@escaping (T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
