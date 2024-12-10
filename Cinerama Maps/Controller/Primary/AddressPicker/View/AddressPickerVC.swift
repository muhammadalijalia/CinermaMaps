//
//  AddressPickerVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/10/23.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddressPickerVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtSearchLocation: UITextView!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightLocation: NSLayoutConstraint!
    @IBOutlet weak var btnclear: UIButton!
    @IBOutlet weak var address_TypeVw: UIView!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var slider_Ot: UISlider!
    
    var searchResults = [GMSAutocompletePrediction]()
    var address_display = ""
    var address: String = ""
    var lat: Double?
    var lon: Double?
    var locationCoordinate: CLLocationCoordinate2D?
    
    var locationPickedBlock: ((CLLocationCoordinate2D, Double, Double, String) -> Void)?
    
    let autocompleteFetcher = GMSAutocompleteFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupAutocomplete()
//        setupSlider()
        Utility.showCurrentLocationOnGoogleMap(mapView, self)
        
        //        updateLocationDetails(locationCoordinate!)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func setupAutocomplete() {
        autocompleteFetcher.delegate = self
        txtSearchLocation.textColor = .lightGray
    }
    
    func updateLocationDetails(_ coordinate: CLLocationCoordinate2D) {
        self.locationCoordinate = coordinate
        self.lat = coordinate.latitude
        self.lon = coordinate.longitude
        
        Utility.getLocationByCoordinates(location: CLLocation(latitude: lat!, longitude: lon!)) { (address, display_address) in
            self.address_display = display_address
            self.address = address
            self.setSearchLocation()
        }
        
        updateMapViewAndMarker()
    }
    
    func updateMapViewAndMarker() {
        guard let coordinate = locationCoordinate else { return }
        mapView.clear()
        
        let marker = GMSMarker(position: coordinate)
        marker.title = self.address
        marker.map = mapView
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        mapView.animate(to: camera)
    }
    
    @objc func addAnnotationOnLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            let point = gesture.location(in: mapView)
            let coordinate = mapView.projection.coordinate(for: point)
            updateLocationDetails(coordinate)
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        let value = Int(slider_Ot.value)
        lbl_Distance.text = "Select a distance \(value) KM"
    }
    
    @IBAction func btnAddresclear(_ sender: UIButton) {
        txtSearchLocation.text = ""
        tableViewOt.isHidden = true
        constraintHeightLocation.constant = 33.0
    }
    
    @IBAction func btnSubmitAddress(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.locationPickedBlock?(self.locationCoordinate ?? CLLocationCoordinate2D(), self.lat ?? 0.0, self.lon ?? 0.0, self.address)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setSearchLocation() {
        if address.isEmpty {
            txtSearchLocation.text = "Search Location"
            txtSearchLocation.textColor = .lightGray
            tableViewOt.isHidden = true
        } else {
            txtSearchLocation.text = address
            txtSearchLocation.textColor = .black
        }
        
        let height = Utility.autoresizeTextView(address, font: UIFont.systemFont(ofSize: 14.0), width: txtSearchLocation.frame.width)
        constraintHeightLocation.constant = height > 17 ? height + 15 : height + 18
    }
}

// MARK: - GMSMapViewDelegate
extension AddressPickerVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        locationCoordinate = position.target
        lat = position.target.latitude
        lon = position.target.longitude
        
        let location = CLLocation(latitude: lat!, longitude: lon!)
        Utility.getLocationByCoordinates(location: location) { (address, display_address) in
            self.address = address
            self.address_display = display_address
            self.setSearchLocation()
        }
    }
    
}

// MARK: - GMSAutocompleteFetcherDelegate
extension AddressPickerVC: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        searchResults = predictions
        tableViewOt.isHidden = predictions.isEmpty
        tableViewOt.reloadData()
        
        // Adjust table height dynamically
        tableHeightConstraint.constant = tableViewOt.contentSize.height
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print("Autocomplete Error: \(error.localizedDescription)")
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension AddressPickerVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.isEmpty {
            tableViewOt.isHidden = true
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchLocationCell = tableView.dequeueReusableCell(withIdentifier: "searchLocationCell", for: indexPath) as! SearchLocationCell
        let result = searchResults[indexPath.row]
        cell.lblMainLocation.text = result.attributedPrimaryText.string
        cell.lblSecondaryLocation.text = result.attributedSecondaryText?.string ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewOt.isHidden = true
        let prediction = searchResults[indexPath.row]
        GMSPlacesClient.shared().fetchPlace(
            fromPlaceID: prediction.placeID,
            placeFields: [.coordinate, .formattedAddress],
            sessionToken: nil
        ) { [weak self] (place, error) in
            guard let self = self, let place = place, error == nil else { return }
            
            self.locationCoordinate = place.coordinate
            self.address = place.formattedAddress ?? ""
            self.lat = place.coordinate.latitude
            self.lon = place.coordinate.longitude
            
            self.updateMapViewAndMarker()
            self.setSearchLocation()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableHeightConstraint.constant = tableViewOt.contentSize.height
    }
}

// MARK: - UITextViewDelegate
//extension AddressPickerVC: UITextViewDelegate {
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if (textView.text == "Search Location" && textView.textColor == .lightGray) {
//            textView.text = ""
//            textView.textColor = .black
//        }
//        textView.becomeFirstResponder() //Optional
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if (textView.text == "" && textView.tag == 0) {
//            textView.text = "Search Location"
//            self.tableViewOt.isHidden = true
////            self.searchResults.queryFragment = txtSearchLocation.text!
//            textView.textColor = .lightGray
//        }
//        textView.resignFirstResponder()
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//        if textView.tag == 0 {
//            if textView.text != "" {
//                self.tableViewOt.isHidden = false
//                self.constraintHeightLocation.constant = 33.0
//                print("dd")
//            } else {
//                self.tableViewOt.isHidden = true
//                print("nothing")
//            }
////            self.searchResults.queryFragment = txtSearchLocation.text!
//        }
//    }
//}

extension AddressPickerVC: UITextViewDelegate {
    
    //    func textViewDidChange(_ textView: UITextView) {
    //        guard let query = textView.text, !query.isEmpty else {
    //            searchResults.removeAll()
    //            tableViewOt.reloadData()
    //            return
    //        }
    //
    //        // Set the query fragment and fetch predictions
    //        if textView.tag == 0 {
    //            if textView.text != "" {
    //
    //                tableViewOt.isHidden = false
    //            } else {
    //                tableViewOt.isHidden = true
    //            }
    //        }
    //    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let query = textView.text, !query.isEmpty else {
            searchResults.removeAll()
            tableViewOt.reloadData()
            return
        }
        
        if textView.tag == 0 {
            if textView.text != "" {
                self.tableViewOt.isHidden = false
                self.constraintHeightLocation.constant = 33.0
                print("dd")
            } else {
                self.tableViewOt.isHidden = true
                print("nothing")
            }
            autocompleteFetcher.sourceTextHasChanged(query)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Search Location" && textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        if textView.text.isEmpty {
    //            textView.text = "Search Location"
    //            textView.textColor = .lightGray
    //            tableViewOt.isHidden = true
    //        }
    //    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "" && textView.tag == 0) {
            textView.text = "Search Location"
            self.tableViewOt.isHidden = true
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
