//
//  FindMyPosition.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit
import CoreLocation

class FindMyPosition: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let locationLabel = UILabel()
    let locationStrLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage.init(named: "phoneBg")
        self.view.addSubview(backgroundImageView)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds;
        self.view.addSubview(blurView)
        
        locationManager.delegate = self
        locationLabel.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 100)
        locationLabel.textColor = .white
        locationLabel.textAlignment = .center
        self.view.addSubview(locationLabel)
        
        locationStrLabel.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 50)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.white
        self.view.addSubview(locationStrLabel)
        
        let findMyLocationButton = UIButton(type: .custom)
        findMyLocationButton.frame = CGRect(x: 50, y: self.view.bounds.height - 82, width: self.view.bounds.width - 100, height: 50)
        findMyLocationButton.setTitle("Find My Position", for: .normal)
        findMyLocationButton.setTitleColor(.white, for: .normal)
        findMyLocationButton.addTarget(self, action: #selector(findMyLocationAction), for: .touchUpInside)
        self.view.addSubview(findMyLocationButton)
    }
    
    @objc func findMyLocationAction() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations: NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude)lng:\(currentLocation.coordinate.longitude)"
        locationLabel.text = locationStr
        reverseGeocode(location: currentLocation)
        locationManager.stopUpdatingLocation()
    }
    
    /// 将经纬度转换为城市名
    func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { placeMark, error in
            if error == nil {
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                let country = mark.country!
                let city = mark.locality!
                let street = mark.thoroughfare!
                
                let finalAddress = "\(country),\(city),\(street)"
                self.locationStrLabel.text = finalAddress
            }
        }
    }
}
