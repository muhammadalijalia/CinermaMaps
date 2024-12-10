//
//  Utility.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import UIKit
import MapKit
import SDWebImage
import SafariServices
import Rswift
import GoogleMaps
import LanguageManager_iOS
import WebKit

class Utility {
    
    typealias BlockerList = [[String: [String: String]]]
    
    class func doShare(_ url: String, _ shareText: String, _ vc: UIViewController) {
        if let url = URL(string: url), !url.absoluteString.isEmpty {
            let shareItems: [Any] = [shareText, url]
            let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .postToFlickr, .assignToContact, .openInIBooks]
            vc.present(activityVC, animated: true, completion: nil)
        }
    }
    
    class func isValidMobileNumber(_ mobileNo: String) -> Bool {
        let mobileNumberPattern: String = "^[0-9]{10}$"
        //@"^[7-9][0-9]{9}$";
        let mobileNumberPred = NSPredicate(format: "SELF MATCHES %@", mobileNumberPattern)
        let isValid: Bool = mobileNumberPred.evaluate(with: mobileNo)
        return isValid
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        let mobileNumberPattern: String = "^[0-9]{4}$"
        //@"^[7-9][0-9]{9}$";
        let mobileNumberPred = NSPredicate(format: "SELF MATCHES %@", mobileNumberPattern)
        let isValid: Bool = mobileNumberPred.evaluate(with: password)
        return isValid
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid: Bool = emailPred.evaluate(with: email)
        return isValid
    }
    
    class func isValidPinCode(_ pincode: String) -> Bool {
        let pinRegex: String = "^[0-9]{6}$"
        let pinTest = NSPredicate(format: "SELF MATCHES %@", pinRegex)
        let pinValidates: Bool = pinTest.evaluate(with: pincode)
        return pinValidates
    }
    
    class func convertDateFormat(withAMPM dateString: String, inputFormate: String, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormate
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = outputFormate
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getDateFrom(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        return date!
    }
    
    class func getDateString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "EEEE, MMM dd"
        let dateAMPM: String = dateFormatterAMPM.string(from: date!)
        return dateAMPM
    }
    
    class func getDateStringString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "hh:mm a"
        let dateAMPM: String = dateFormatterAMPM.string(from: date!)
        return dateAMPM
    }
    
    class func getDateTimeString(withAMPM dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = "dd-MMM-yyyy hh:mm a"
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getStringDateFromStringDate(withAMPM dateString: String, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date: Date? = dateFormatter.date(from: dateString)
        let dateFormatterAMPM = DateFormatter()
        dateFormatterAMPM.dateFormat = outputFormate
        var dateAMPM:String = ""
        if let dateS = date {
            dateAMPM = dateFormatterAMPM.string(from: dateS)
        }
        return dateAMPM
    }
    
    class func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale.current
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func getCurrentWeekDates(from date: Date) -> [Date] {
        let calendar = Calendar.current
        var weekDates: [Date] = []
        
        // Get the start of the week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return weekDates
        }
        
        print(startOfWeek)
        
        // Get all dates of the week
        for day in 0..<7 {
            if let weekDate = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                weekDates.append(weekDate)
                print(weekDates)
            }
        }
        print(weekDates)
        return weekDates
    }
    
    class func getCurrentDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        //        dateFormatter.locale = Locale.current
        dateFormatter.locale = Locale(identifier: "en_US")
        let date:String = dateFormatter.string(from: Date())
        return date
    }
    
    class func showAlertMessage(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "Ok".localiz(), style: .default, handler: nil)
        //You can use a block here to handle a press on this button
        alertController.addAction(actionOk)
        //        alertController.setMessageAlignment(.center)
        parentVC.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertWithAction(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: alert.view.frame.width - 20, height: 50))
        //        label.text = title
        //        label.textAlignment = .center
        //        alert.view.addSubview(label)
        //
        //        let label2 = UILabel(frame: CGRect(x: 0, y: 50, width: alert.view.frame.width - 20, height: 50))
        //        label2.text = msg
        //        label2.textAlignment = .center
        //        alert.view.addSubview(label2)
        alert.addAction(UIAlertAction(title: "Ok".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        //        alert.setMessageAlignment(.center)
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertYesNoAction(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "No".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        //        alert.setMessageAlignment(.center)
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertOkOrCancel(withTitle title: String, message msg: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localiz(), style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        //        alert.setMessageAlignment(.center)
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func showAlertWithCustomAction(withTitle title: String, message msg: String, firstTitle first: String, secondTitle second: String, delegate del: Any?, parentViewController parentVC: UIViewController, completionHandler: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: first, style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: second, style: .default, handler: { action in
            switch action.style {
            case .default:
                completionHandler(false)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        parentVC.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    class func isUserLogin ()-> Bool {
        if (k.userDefault.value(forKey: k.session.userId) != nil) {
            return true
        }
        return false
    }
    
    class func checkNetworkConnectivityWithDisplayAlert( isShowAlert : Bool) -> Bool{
        let isNetworkAvaiable = InternetUtilClass.sharedInstance.hasConnectivity()
        return isNetworkAvaiable;
    }
    
    class func getStringFromDate(_ date: Date, outputFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormate
        let newDate = dateFormatter.string(from: date) //pass Date here
        return newDate
    }
    
    class func encode(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    class func decode(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    class func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    class func noDataFound(_ title: String,_ message: String, tableViewOt: UITableView, parentViewController parentVC: UIViewController) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableViewOt.bounds.size.width, height: tableViewOt.bounds.size.height))
        
        let center = (tableViewOt.bounds.size.width/2)
        let center_y = (tableViewOt.bounds.size.height/2)
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "noitem"))
        imageView.frame = CGRect(x: center -  50, y: center_y - 120, width: 120, height: 120)
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: center_y + 20, width: tableViewOt.bounds.size.width, height: 20))
        label.font = label.font.withSize(17.0)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.text = title
        //        label.textColor = parentVC.hexStringToUIColor(hex: "#5A5C63")
        label.textColor = UIColor(red: CGFloat(90)/255, green: CGFloat(92)/255, blue: CGFloat(99)/255, alpha :1)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        
        let label2: UILabel = UILabel(frame: CGRect(x: 0, y: center_y + 40, width: tableViewOt.bounds.size.width, height: 40))
        label2.font = label.font.withSize(13.0)
        label2.text = message
        //        label2.textColor = UIColor(red: CGFloat(150)/255, green: CGFloat(150)/255, blue: CGFloat(150)/255, alpha :1)
        label2.textColor = parentVC.hexStringToUIColor(hex: "#95979B")
        label2.textAlignment = NSTextAlignment.center
        label2.numberOfLines = 2
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(label2)
        tableViewOt.backgroundView = view
    }
    
    class func setImageWithSDWebImage(_ url: String, _ imageView: UIImageView) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        imageView.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: "BackPlaceholder"), options: .continueInBackground, completed: nil)
    }
    class func imageWithSDWebImage(_ url: String, _ imageView: UIImageView) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        if url.contains(".svg"){
            SVGLoader.load(url: urlwithPercentEscapes) { image in
                imageView.image = image
            }
        }else{
            imageView.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: ""), options: .continueInBackground, completed: nil)
        }
        
        
    }
    class func loadSVGWithoutLibrary(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a WKWebView to render the SVG
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        webView.load(URLRequest(url: url))
        
        // Wait until the SVG is fully loaded and rendered
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Adjust timing as necessary
            UIGraphicsBeginImageContextWithOptions(webView.bounds.size, false, 0.0)
            webView.drawHierarchy(in: webView.bounds, afterScreenUpdates: true)
            let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                // Set the rendered image to the UIImageView
                imageView.image = renderedImage
            }
        }
    }
    class func downloadImageBySDWebImage(_ url: String, successBlock success : @escaping ( _ image : UIImage?, _  error: Error?) -> Void) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: urlLogo, options: .continueInBackground, progress: nil, completed: { (image, data, error, boool) in
            success(image, error)
        })
    }
    
    class func setImageWithSDWebImageOnButton(_ url: String, _ imageView: UIButton) {
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let urlLogo = URL(string: urlwithPercentEscapes!)
        
        imageView.sd_setImage(with: urlLogo, for:
                                UIControl.State.normal, placeholderImage: UIImage(named:
                                                                                    "BackPlaceholder"), options: SDWebImageOptions(rawValue: 0)) { (image,
                                                                                                                                                error, cache, url) in
            print("imagdoooooooooo\(image)")
        }
    }
    
    class func blockUi() {
        let spinnerActivity = MBProgressHUD.showAdded(to: UIApplication.topViewController()!.view, animated: true);
        if spinnerActivity.isUserInteractionEnabled {
            spinnerActivity.bezelView.isHidden = true
            spinnerActivity.bezelView.color = .clear
            spinnerActivity.isUserInteractionEnabled = true;
        }
    }
    
    class func unBlockUi() {
        MBProgressHUD.hide(for: UIApplication.topViewController()!.view, animated: true)
    }
    
    class func setCurrentLocation(_ mapView: MKMapView) {
        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.setRegion(region, animated: true)
    }
    
    // For text view
    class func autoresizeTextView(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        textView.font = font
        textView.text = text
        textView.sizeToFit()
        if let textNSString: NSString = textView.text as NSString? {
            let rect = textNSString.boundingRect(with: CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: textView.font!],
                                                 context: nil)
            textView.frame = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.size.width, height: rect.height)
        }
        return textView.frame.height
    }
    
    /******************************************************************************************/
    //MARK:-  Mapkit
    /******************************************************************************************/
    
    class func initMapViewAnnotation(_ mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        mapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                mapView.removeAnnotation($0)
            }
        }
    }
    
    class func showCurrentLocation(_ mapView: MKMapView, _ vc: UIViewController) {
        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
    }
    
    //    class func showCurrentLocationOnGoogleMap(_ mapView: GMSMapView, _ vc: UIViewController) {
    //        let region = MKCoordinateRegion(center: kAppDelegate.coordinate2.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
    //        mapView.showsUserLocation = true
    //        mapView.setRegion(region, animated: true)
    //    }
    
    class func showCurrentLocationOnGoogleMap(_ mapView: GMSMapView, _ vc: UIViewController) {
        guard let currentLocation = LocationManager.sharedInstance.locationManager?.location else {
            print("Unable to fetch current location")
            return
        }
        
        let coordinate = currentLocation.coordinate
        
        // Create a camera position to focus on the user's current location.
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              zoom: 15) // Adjust zoom level as needed
        
        // Move the camera to the user's location on the map.
        mapView.animate(to: camera)
        
        //        // Optionally add a marker for the user's current location.
        //        let marker = GMSMarker()
        //        marker.position = coordinate
        //        marker.title = "You are here"
        //        marker.map = mapView
        
        // Display user location on the map (if enabled in Google Maps settings).
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    class func getLocationByCoordinates (location: CLLocation, successBlock success: @escaping (_ address: String, _ display_address: String) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            var address_display = ""
            if let city = addressDict["City"] as? String {
                if let zip = addressDict["ZIP"] as? String {
                    address_display = city + " " + zip
                }
            }
            
            // Print fully formatted address
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                let address = (formattedAddress.joined(separator: ", "))
                success(address, address_display)
            }
        })
    }
    
    class func getCurrentAddress( successBlock success: @escaping (_ address: String) -> Void) {
        Utility.lookUpCurrentLocation { (Placemark) in
            guard let addressDict = Placemark?.addressDictionary else {
                return
            }
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                let address = (formattedAddress.joined(separator: ", "))
                success(address)
            }
        }
    }
    
    class func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                                     -> Void ) {
        // Use the last reported location.
        if let lastLocation = LocationManager.sharedInstance.lastLocation {
            let geocoder = CLGeocoder()
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        } else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    //    class func showRouteOnMap(_ mapView: MKMapView, _ pickupCoordinate: CLLocationCoordinate2D, _ destinationCoordinate: CLLocationCoordinate2D, _ vc: UIViewController,top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
    //
    //        Utility.initMapViewAnnotation(mapView)
    //
    //        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
    //        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
    //
    //        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
    //        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    //
    //        let sourceAnnotation = CustomPointAnnotation()
    //
    //        if let location = sourcePlacemark.location {
    //            sourceAnnotation.coordinate = location.coordinate
    //            sourceAnnotation.imageName = "pick.png"
    //            sourceAnnotation.point = "source"
    //        }
    //
    //        let destinationAnnotation = CustomPointAnnotation()
    //
    //        if let location = destinationPlacemark.location {
    //            destinationAnnotation.coordinate = location.coordinate
    //            destinationAnnotation.imageName = "drop.png"
    //            destinationAnnotation.point = "destination"
    //        }
    //
    //        mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
    //
    //        let directionRequest = MKDirections.Request()
    //        directionRequest.source = sourceMapItem
    //        directionRequest.destination = destinationMapItem
    //        directionRequest.transportType = .automobile
    //
    //        // Calculate the direction
    //        let directions = MKDirections(request: directionRequest)
    //
    //        directions.calculate {
    //            (response, error) -> Void in
    //
    //            guard let response = response else {
    //                if let error = error {
    //                    print("Error: \(error)")
    //                }
    //
    //                return
    //            }
    //
    //            let route = response.routes[0]
    //            mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
    //
    //            //            let rect = route.polyline.boundingMapRect
    //            //            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    //
    //            let mapRect = MKPolygon(points: route.polyline.points(), count: route.polyline.pointCount)
    //            mapView.setVisibleMapRect(mapRect.boundingMapRect, edgePadding: UIEdgeInsets(top: top,left: left,bottom: bottom,right: right), animated: true)
    //        }
    //    }
    
    class func addRadiusCircle(_ mapView: MKMapView, location: CLLocationCoordinate2D, desiredRadius: CLLocationDistance) {
        let circle = MKCircle(center: location, radius: desiredRadius)
        mapView.addOverlay(circle)
        
        mapView.setVisibleMapRect(circle.boundingMapRect, animated: true)
    }
    
    class func clearMapViewOverlay(_ mapView: MKMapView) {
        mapView.overlays.forEach {
            if !($0 is MKUserLocation) {
                mapView.removeOverlay($0)
            }
        }
    }
    
    class func region(_ coordinate: CLLocationCoordinate2D, _ radius: CLLocationDistance, _ identifier: String) -> CLCircularRegion {
        let region = CLCircularRegion(center: coordinate, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
    class func zoomMapToAnnotations(_ map: MKMapView) {
        if !map.annotations.isEmpty {
            let region = self.regionThatFitsAllAnnotations(map)
            map.setRegion(region, animated: true)
        }
    }
    
    class func regionThatFitsAllAnnotations(_ map: MKMapView) -> MKCoordinateRegion {
        var minLat = CLLocationDegrees(100)
        var maxLat = CLLocationDegrees(-100)
        var minLon = CLLocationDegrees(200)
        var maxLon = CLLocationDegrees(-200)
        
        for annotation in map.annotations {
            let annotationCoordinate = annotation.coordinate
            minLat = min(minLat, annotationCoordinate.latitude)
            maxLat = max(maxLat, annotationCoordinate.latitude)
            minLon = min(minLon, annotationCoordinate.longitude)
            maxLon = max(maxLon, annotationCoordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) / 2, longitude: (maxLon + minLon) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.2, longitudeDelta: (maxLon - minLon) * 1.2)
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    class func zoomMapToMarkers(_ mapView: GMSMapView, markers: [GMSMarker]) {
        guard !markers.isEmpty else { return }
        
        let bounds = self.boundsThatFitAllMarkers(markers)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50) // Adjust padding as needed
        mapView.animate(with: update)
    }
    
    /// Computes the GMSCoordinateBounds that include all markers.
    private class func boundsThatFitAllMarkers(_ markers: [GMSMarker]) -> GMSCoordinateBounds {
        var bounds = GMSCoordinateBounds()
        
        for marker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        return bounds
    }
}

class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
}

class SVGLoader {
    typealias wkType = (data: Data, complition: ((UIImage?) -> Void)?, url: String?)
    static var wkContainer = [wkType]()
    static var wView: WKView?

    static func load(url: String?, size: CGSize = CGSize(width: 600, height: 600), complition: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            var data: Data = Data()
            do {
                guard let url, let path = URL(string: url) else { return }
                data = try Data(contentsOf: path)
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                let wkData: wkType = (data, complition, url)
                wkContainer.append(wkData)
                
                if wView == nil {
                    wView = WKView(frame: CGRect(origin: .zero, size: size))
                }
            }
        }
    }

    static func clean() {
        if wkContainer.isEmpty {
            wView = nil
        }
    }

    class WKView: NSObject, WKNavigationDelegate {
        var webKitView: WKWebView?

        init(frame: CGRect) {
            super.init()
            webKitView = WKWebView(frame: frame)
            webKitView?.navigationDelegate = self
            webKitView?.isOpaque = false
            webKitView?.backgroundColor = .clear
            webKitView?.scrollView.backgroundColor = .clear
            loadData()
        }

        func loadData() {
            let datas = SVGLoader.wkContainer
            if datas.isEmpty { return }
            
            guard let data = datas.first?.data, let urlS = datas.first?.url, let url = URL(string: urlS) else {
                return
            }

            webKitView?.load(data, mimeType: "image/svg+xml", characterEncodingName: "", baseURL: url)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Calculate the content size of the SVG content
            webKitView?.scrollView.layoutIfNeeded()

            let contentHeight = webKitView?.scrollView.contentSize.height ?? 0
            let contentWidth = webKitView?.scrollView.contentSize.width ?? 0

            let newFrame = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight)
            webKitView?.frame = newFrame

            webKitView?.takeSnapshot(with: nil) { [weak self] image, error in
                guard let self = self else { return }
                wkContainer.first?.complition?(image)
                wkContainer.removeFirst()
                clean()
                loadData()
            }
        }
    }
}


