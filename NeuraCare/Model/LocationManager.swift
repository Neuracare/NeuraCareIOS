//
//  LocationManager.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion : ((CLLocation) -> Void)?
    
    public func getLoc(completion: @escaping (CLLocation) -> Void){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        completion?(location)
    }
    
    func sendLoc(){
        
//        var request = URLRequest(url: URL(string: "https://backend.neuracare.tech/patient/update")!)
//        
//        // Configure POST Request
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = 
//        //print(request.httpBody?)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                // Show error page
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse {
//                print(httpResponse.statusCode)
//                
//            }
//            print(data)
//            
//            
//            // check if status code == 201
//            // stop loading screen and continue with app stuff
//                
//        }
//        // Start task
//        task.resume()
        
    }
    
}
