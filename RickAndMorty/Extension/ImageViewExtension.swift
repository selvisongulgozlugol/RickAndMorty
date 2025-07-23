import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.sd_setImage(with: url, completed: nil)
    }
}
