//
//  PlacesViewController.swift
//  FoodDelivery
//
//  Created by Jon McLean on 8/1/19.
//  Copyright © 2019 Jon McLean Development. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var tableView: UITableView = UITableView()
    
    var data: Array<Place> = []
    
    let locationManager = CLLocationManager()
    
    var locationEnabled: Bool = true
    
    var lastLoadLocation: CLLocation?
    var shouldLoadForNewLocation: Bool = true
    
    let loc = LocationHelper()
    let network = NetworkManager()
    
    lazy var geocoder = CLGeocoder()
    
    var countryCode: String = ""
    var stateCode: String = ""
    
    override func viewDidLoad() {
        self.locationManager.delegate = self
        
        
        
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Places"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController!.navigationBar.bounds.height + self.tabBarController!.tabBar.bounds.height)))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutViews()
        self.navigationItem.title = "Places"
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        
    }
    
    func layoutViews() {
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.bounds.width)
            make.height.equalTo(tableView.bounds.height)
            make.center.equalTo(self.view)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Location Enabled: \(locationEnabled)")
        if(locationEnabled) {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            return 1
        }else {
            
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "Location Services must be enabled!"
            noDataLabel.textColor = Colors.Theme.redColor
            noDataLabel.font = UIFont(name: "Courier New", size: 14)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations[0].coordinate)
        
        if(lastLoadLocation == nil) {
            lastLoadLocation = locations[0]
            
            geocoder.reverseGeocodeLocation(locations[0]) { (placemarks, error) in
                self.processGeocode(placemarks: placemarks, error: error)
                self.network.getPlaces(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude, countryCode: self.countryCode, state: self.stateCode) { (response) in
                    print(response)
                }
            }
            
        }else {
            let oldLatitude: Double = lastLoadLocation!.coordinate.latitude
            let oldLongitude: Double = lastLoadLocation!.coordinate.longitude
            
            let currentCoord = locations[0]
            let newLatitude: Double = currentCoord.coordinate.latitude
            let newLongitude: Double = currentCoord.coordinate.longitude
            
            let distance = loc.distance(lat1: oldLatitude, long1: oldLongitude, lat2: newLatitude, long2: newLongitude)
            
            print(distance)
            
            if(distance > 0.5) { // greater than 500m difference
                
                geocoder.reverseGeocodeLocation(locations[0]) { (placemarks, error) in
                    self.processGeocode(placemarks: placemarks, error: error)
                    print("update")
                    self.lastLoadLocation = locations[0]
                    
                    self.network.getPlaces(latitude: newLatitude, longitude: newLongitude, countryCode: self.countryCode, state: self.stateCode) { (response) in
                        print(response)
                    }
                }
                
            }
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationEnabled = true
            manager.startUpdatingLocation()
            tableView.reloadData()
        }else if status == .authorizedWhenInUse {
            locationEnabled = true
            manager.startUpdatingLocation()
            tableView.reloadData()
        }else if status == .notDetermined {
            manager.requestAlwaysAuthorization()
            tableView.reloadData()
        }else {
            manager.requestAlwaysAuthorization()
            locationEnabled = false
            tableView.reloadData()
        }
    }
    
    func processGeocode(placemarks: [CLPlacemark]?, error: Error?){
        if placemarks?.count == 0 {
            return;
        }
        
        let placemark = placemarks![0]
        self.countryCode = placemark.isoCountryCode!
        self.stateCode = placemark.administrativeArea!
        
        print(countryCode)
        print(stateCode)
    }
    
    
}
