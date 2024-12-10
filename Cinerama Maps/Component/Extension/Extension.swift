//
//  Extension.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 08/08/24.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

extension UILabel {
    func setColor(for targetText: String, with color: UIColor) {
        guard let labelText = self.text else { return }

        let attributedString = NSMutableAttributedString(string: labelText)
        let range = (labelText as NSString).range(of: targetText)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attributedString
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

extension String {
    static func GetNoonTime() -> String {
        let date = Date()
        // Make Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        // hh for hour mm for minutes and a will show you AM or PM
        let str: String = dateFormatter.string(from: date)
        print("\(str)")
        // Sperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
        var array: [Any] = str.components(separatedBy: " ")
        
        // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night
        
        var message: String = ""
        let timeInHour: String = array[0] as! String
        let am_pm: String = array[1] as! String
        
        if CInt(timeInHour)! < 12 && (am_pm == "AM") {
            message = "Good Morning"
        }
        else if CInt(timeInHour)! <= 4 && (am_pm == "PM") {
            message = "Good Afternoon"
        }
        else if CInt(timeInHour) == 12 && (am_pm == "PM") {
            message = "Good Afternoon"
        }
        else if CInt(timeInHour)! > 4 && (am_pm == "PM") {
            message = "Good Night"
        }
        print("\(message)")

        return message
    }
    
    var htmlAttributedString3 : NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do{
            return try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html,.characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return nil
        }
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UITextView {
    
    func addHint(_ hint: String) {
        let hintLabel = UILabel()
        hintLabel.text = hint
        hintLabel.font = self.font
        hintLabel.textColor = UIColor.lightGray
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hintLabel)
        
        NSLayoutConstraint.activate([
            hintLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            hintLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
            // Add additional constraints as needed
        ])
        
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: nil, queue: nil) { [weak self] _ in
            self?.updateHintVisibility(hintLabel)
        }
        
        updateHintVisibility(hintLabel)
    }
    
    private func updateHintVisibility(_ hintLabel: UILabel) {
        hintLabel.isHidden = !self.text.isEmpty
    }
}

extension UIImage {
    func circularImage(with size: CGSize) -> UIImage? {
        let minEdge = min(size.width, size.height)
        let squareImage = self.resizeImage(to: CGSize(width: minEdge, height: minEdge))
        
        let imageView = UIImageView(image: squareImage)
        imageView.layer.cornerRadius = minEdge / 2
        imageView.layer.masksToBounds = true
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: minEdge, height: minEdge))
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let circularImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return circularImage
    }
    
    func resizeImage(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}
