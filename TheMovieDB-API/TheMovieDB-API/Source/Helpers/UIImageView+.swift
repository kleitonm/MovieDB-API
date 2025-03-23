//
//  UIImageView+.swift
//  TheMovieDB-API
//
//  Created by Kleiton Mendes on 15/01/25.
//
import UIKit

extension UIImageView {
    
    func load(urlImage: URL, mode: ContentMode) {
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = img
                    }
                }
            }
        }
    }
    
    func downloaded(from url: URL, mode: ContentMode) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let type = response?.mimeType,
                  type.hasPrefix("image"),
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func didLoadImage(link: String, mode: ContentMode) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, mode: mode)
    }
}
