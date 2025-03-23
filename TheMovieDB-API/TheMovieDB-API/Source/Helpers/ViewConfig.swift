
import UIKit

protocol ViewConfig {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewConfig {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges() { }
}
