import UIKit

class CustomImageView: UIImageView {
    init(cornerRadius: CGFloat = 8) {
        super.init(frame: .zero)
        setupUI(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI(cornerRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
} 