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
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var placesArray: Array<Place> = []
    
    let locationManager = CLLocationManager()
    
    var locationEnabled: Bool = true
    var noData: Bool = false
    var serverError = false
    
    var lastLoadLocation: CLLocation?
    var shouldLoadForNewLocation: Bool = true
    
    let loc = LocationHelper()
    let network = NetworkManager()
    
    lazy var geocoder = CLGeocoder()
    
    var countryCode: String = ""
    var stateCode: String = ""
    
    let cellIdentifier = "RestaurantCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.view.backgroundColor = UIColor.white
        self.locationManager.distanceFilter = 20
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading places", attributes: nil)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController!.navigationBar.bounds.height + self.tabBarController!.tabBar.bounds.height)))
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        self.view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutViews()
        self.title = "Places"
        self.tabBarController?.title = "Places"
        
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.locationManager.stopUpdatingLocation()
    }
    
    func layoutViews() {
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.bounds.width)
            make.height.equalTo(tableView.bounds.height)
            make.center.equalTo(self.view)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(noData) {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No places found for your region"
            noDataLabel.textColor = Colors.Theme.redColor
            noDataLabel.font = UIFont(name: "Courier New", size: 14)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            return 0
        }
        
        if(serverError) {
            let serverError = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            serverError.text = "There was a problem with the server"
            serverError.textColor = Colors.Theme.redColor
            serverError.font = UIFont(name: "Courier New", size: 14)
            serverError.textAlignment = .center
            tableView.backgroundView = serverError
            tableView.separatorStyle = .none
            return 0
        }
        
        if(!locationEnabled) {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "Location Services must be enabled!"
            noDataLabel.textColor = Colors.Theme.redColor
            noDataLabel.font = UIFont(name: "Courier New", size: 14)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            
            return 0
        }
        
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = placesArray[indexPath.row].name
        return cell*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantCell
        cell.placeImageView.image = UIImage(named: "burger")!
        cell.nameLabel.text = placesArray[indexPath.row].name
        cell.deliveryTimeLabel.text = "Idk"
        
        let rating = placesArray[indexPath.row].averageRating
        let count = placesArray[indexPath.row].ratingCount
        
        if(rating == -1 || count == 0) {
            cell.ratingLabel.text = "No ratings"
        }else {
            cell.ratingLabel.text = "\(rating) ⭐️"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations[0].coordinate)
        
        if(lastLoadLocation == nil) {
            lastLoadLocation = locations[0]
            
            geocoder.reverseGeocodeLocation(locations[0]) { (placemarks, error) in
                self.refreshControl.beginRefreshing()
                self.processGeocode(placemarks: placemarks, error: error)
                self.network.getPlaces(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude, countryCode: self.countryCode, state: self.stateCode) { (response) in
                    print(response)
                    self.updateData(response: response as! String)
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
                    self.refreshControl.beginRefreshing()
                    self.processGeocode(placemarks: placemarks, error: error)
                    print("update")
                    self.lastLoadLocation = locations[0]
                    
                    self.network.getPlaces(latitude: newLatitude, longitude: newLongitude, countryCode: self.countryCode, state: self.stateCode) { (response) in
                        print(response)
                        self.updateData(response: response as! String)
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
    
    func updateData(response: String) {
        
        self.placesArray = []
        
        let json = JSON(parseJSON: response)
        
        if json == nil {
            self.serverError = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            return;
        }
        
        let dic = json.dictionaryObject
        let code = dic!["code"] as! Int
        
        if code == 421 {
            self.noData = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            return;
        }else if code != 200 {
            self.serverError = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            return
        }
        
        let data = dic!["data"] as! Array<Any>
        
        for i in data {
            let d = i as! Dictionary<String, Any>
            
            let name = d["name"] as! String
            let longitude = d["longitude"] as! Double
            let distance = d["distance"] as! Double
            let latitude = d["latitude"] as! Double
            let uuid = d["uuid"] as! String
            
            self.network.getAverageRatings(placeUUID: uuid) { (response) in
                let averageJson = JSON(parseJSON: response as! String)
                
                if averageJson == nil {
                    self.serverError = true
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    return;
                }
                
                let averageDic = averageJson.dictionaryObject
                let code = averageDic!["code"] as! Int
                
                print(averageDic)
                
                var rating: Double = 0
                var count = 0
                
                if code == 441 {
                    print("441")
                    self.refreshControl.endRefreshing()
                    return;
                }else if code == 442 {
                    count = 0
                    rating = -1
                }else if code != 200 {
                    self.serverError = true
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    return;
                }else {
                    count = averageDic!["count"] as! Int
                    rating = averageDic!["average"] as! Double
                }
                
                let place = Place(name: name, latitude: latitude, longitude: longitude, uniqueId: uuid, countryCode: self.countryCode, state: self.stateCode, averageRating: rating, ratingCount: count)
                self.placesArray.append(place)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
    }
    
    @objc func pullToRefresh() {
        print("Pull to refresh")
        
        if lastLoadLocation == nil {
            return;
        }
        
        network.getPlaces(latitude: lastLoadLocation!.coordinate.latitude, longitude: lastLoadLocation!.coordinate.longitude, countryCode: self.countryCode, state: self.stateCode) { (response) in
            self.updateData(response: response as! String)
        }
        
    }
    
    
}
