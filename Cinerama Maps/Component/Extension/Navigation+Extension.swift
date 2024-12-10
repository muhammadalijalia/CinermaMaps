//
//  Navigation+Extension.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation
import UIKit
import LanguageManager_iOS

extension UIViewController {
    
    public func setNavigationBarItem(LeftTitle: String, LeftImage: String, CenterTitle: String, CenterImage: String, RightTitle: String, RightImage: String, BackgroundColor: String, BackgroundImage: String, TextColor: String, TintColor: String, Menu: String) {
        
        if LeftTitle != "" {
            addLeftBarButtonWithTitle(LeftTitle, Menu)
        }
        if LeftImage != "" {
            addLeftBarButtonWithImage(LeftImage, Menu)
        }
        if CenterTitle != "" {
            addCenterBarWithTitle(CenterTitle)
        }
        if CenterImage != "" {
            addCenterBarWithImage(CenterImage)
        }
        if RightTitle != "" {
            addRightBarButtonWithTitle(RightTitle)
        }
        if RightImage != "" {
            addRightBarButtonWithImage(RightImage)
        }
        if BackgroundColor != "" {
            setNavigationBarBackgroundColor(BackgroundColor)
        }
        if BackgroundImage != "" {
            setNavigationbarBackgroundImage(BackgroundImage)
        }
        if TextColor != "" {
            setNavigationBarTextColor(color: TextColor)
        }
        if TintColor != "" {
            setNavigationBarTintColor(color: TintColor)
        }
    }
    
    public func addLeftBarButtonWithTitle(_ buttonTitle: String, _ menu: String) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftClick))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    public func addLeftBarButtonWithImage(_ buttonImage: String, _ menu: String) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: buttonImage)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftClick))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    public func addCenterBarWithTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    public func addCenterBarWithImage(_ imageName: String) {
        let image: UIImage = UIImage(named: imageName)!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    public func addRightBarButtonWithTitle(_ buttonTitle: String) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func addRightBarButtonWithImage(_ buttonImage: String) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: buttonImage)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func setNavigationBarBackgroundColor(_ BackgroundColor: String) {
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: BackgroundColor)
    }
    
    public func setNavigationbarBackgroundImage(_ imageName: String) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
    }
    
    public func setNavigationBarTextColor(color: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): hexStringToUIColor(hex: color)]
    }
    
    private func setNavigationBarTintColor(color: String) {
        navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: color)
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc public func leftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc public func rightClick() {
        print("Right Click")
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
    
    func showProgressBar() {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.label.text = "Loading".localiz();
        spinnerActivity.detailsLabel.text = "Please wait".localiz();
        spinnerActivity.isUserInteractionEnabled = true;
    }

    func hideProgressBar() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

    func blockUi() {
        MBProgressHUD.hide(for: self.view, animated: true)
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        if spinnerActivity.isUserInteractionEnabled {
            spinnerActivity.bezelView.isHidden = true
            spinnerActivity.bezelView.color = .clear
            spinnerActivity.isUserInteractionEnabled = true;
        }
    }

    func unBlockUi() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

    func alert(alertmessage: String) {
        let alert = UIAlertController(title: k.appName, message: alertmessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")

            case .cancel:
                print("cancel")

            case .destructive:
                print("destructive")
            }
        }
            )
        )
        self.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    func getStringSize(string: String, fontSize: CGFloat) -> CGSize {
        let size: CGSize = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        return size
    }
    
    func datePickerTapped(strFormat:String,mode:UIDatePicker.Mode, completionBlock complete: @escaping (_ dateString: String) -> Void) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        var dateString:String = ""
        // let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        let datePicker = DatePickerDialog(textColor: .darkGray,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.show("Date",
                        doneButtonTitle: "Done".localiz(),
                        cancelButtonTitle: "Cancel".localiz(),
                        minimumDate: nil,
                        maximumDate: currentDate,
                        datePickerMode: mode) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = strFormat
                if mode == .date {
                    dateString = formatter.string(from: dt)
                } else {
                    dateString = formatter.string(from: dt)
                }
                complete(dateString)
            }
        }
    }
}
