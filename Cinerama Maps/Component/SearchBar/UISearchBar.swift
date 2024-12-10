import UIKit

//extension UISearchBar {
//    public var textField: UITextField? {
//        if #available(iOS 13, *) {
//            return searchTextField
//        }
//        let subViews = subviews.flatMap { $0.subviews }
//        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
//            return nil
//        }
//        return textField
//    }
//
//    func clearBackgroundColor() {
//        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
//
//        for view in subviews {
//            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
//                subview.alpha = 0
//            }
//        }
//    }
//
//    public var activityIndicator: UIActivityIndicatorView? {
//        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
//    }
//
//    var isLoading: Bool {
//        get {
//            return activityIndicator != nil
//        } set {
//            if newValue {
//                if activityIndicator == nil {
//                    let newActivityIndicator = UIActivityIndicatorView(style: .gray)
//                    newActivityIndicator.color = UIColor.gray
//                    newActivityIndicator.startAnimating()
//                    newActivityIndicator.backgroundColor = textField?.backgroundColor ?? UIColor.white
//                    textField?.leftView?.addSubview(newActivityIndicator)
//                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
//
//                    newActivityIndicator.center = CGPoint(x: leftViewSize.width - newActivityIndicator.frame.width / 2,
//                                                          y: leftViewSize.height / 2)
//                }
//            } else {
//                activityIndicator?.removeFromSuperview()
//            }
//        }
//    }
//
//    func changePlaceholderColor(_ color: UIColor) {
//        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
//            let field = textField else {
//            return
//        }
//        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
//            (subview as! UILabel).textColor = color
//        }
//    }
//
//    func setRightImage(normalImage: UIImage,
//                       highLightedImage: UIImage) {
//        showsBookmarkButton = true
//        if let btn = textField?.rightView as? UIButton {
//            btn.setImage(normalImage,
//                         for: .normal)
//            btn.setImage(highLightedImage,
//                         for: .highlighted)
//        }
//    }
//    
//        func setLeftImage(_ image: UIImage,
//                      with padding: CGFloat = 0,
//                      tintColor: UIColor) {
//        let imageView = UIImageView()
//        imageView.image = image
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        imageView.tintColor = tintColor
//
//        if padding != 0 {
//            let stackView = UIStackView()
//            stackView.axis = .horizontal
//            stackView.alignment = .center
//            stackView.distribution = .fill
//            stackView.translatesAutoresizingMaskIntoConstraints = false
//            
//            let paddingView = UIView()
//            paddingView.translatesAutoresizingMaskIntoConstraints = false
//            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
//            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
//            stackView.addArrangedSubview(paddingView)
//            stackView.addArrangedSubview(imageView)
//            textField?.leftView = stackView
//
//        } else {
//            textField?.leftView = imageView
//        }
//    }
//}

extension UISearchBar {

    // Computed property to access the text field inside the search bar
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            return self.value(forKey: "searchField") as? UITextField
        }
    }

    // Method to clear the background of the search bar
    func clearBackgroundColor() {
        if let backgroundView = self.value(forKey: "background") as? UIView {
            backgroundView.alpha = 0
        }
    }

    // Method to change the placeholder text color
    func changePlaceholderColor(_ color: UIColor) {
        if let textField = self.textField {
            let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.textColor = color
        }
    }

    // Method to set a custom image on the right side of the text field
    func setRightImage(normalImage: UIImage, highLightedImage: UIImage?) {
        if let textField = self.textField {
            let rightButton = UIButton(type: .custom)
            rightButton.setImage(normalImage, for: .normal)
            rightButton.setImage(highLightedImage, for: .highlighted)
            textField.rightView = rightButton
            textField.rightViewMode = .always
        }
    }
    
    // Method to set a custom image on the left side of the text field
    func setLeftImage(_ image: UIImage, with padding: CGFloat, tintColor: UIColor) {
        if let textField = self.textField {
            let imageView = UIImageView(image: image)
            imageView.tintColor = tintColor
            let stackView = UIStackView(arrangedSubviews: [imageView])
            stackView.spacing = padding
            textField.leftView = stackView
            textField.leftViewMode = .always
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}
