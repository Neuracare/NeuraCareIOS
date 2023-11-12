//
//  MainViewController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import UIKit
import HealthKit

class MainViewController: UIViewController {

    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var journalButton: UIButton!
    
    @IBOutlet weak var todoButton: UIButton!
    
    var locationData : [String : Double] = [:]
    
    
    var healthkitdata = HealthKitData()
    
    override func viewDidLoad() {
        
        
        
        
        super.viewDidLoad()
        
        reminderButton.layer.cornerRadius = 20
        helpButton.layer.cornerRadius = 20
        journalButton.layer.cornerRadius = 20
        todoButton.layer.cornerRadius = 20
        senddata()
        
        
        if HKHealthStore.isHealthDataAvailable() {
            // Request authorization to access health data
            healthkitdata.requestHealthKitAuthorization()
            
        } else {
            print("HealthKit is not available on this device.")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func helpController(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "HelpPageController") as! HelpPageController
        present(vc, animated: true)
    }
    
    @IBAction func memoryController(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "MemoriesViewController") as! MemoriesViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func bucketListController(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "BucketListController") as! BucketListController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func senddata(){
        
       
        LocationManager.shared.getLoc { location in
            self.locationData["long"] = location.coordinate.longitude
            self.locationData["lat"] = location.coordinate.latitude
            
            var request = URLRequest(url: URL(string: "https://backend.neuracare.tech/ios/update")!)
            
            // Configure POST Request
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = HTTP.createPatientData(id: "rmadith@gmail.com", respiratoryRate: self.healthkitdata.respiratoryRateData , location: self.locationData, heartRate: self.healthkitdata.heartRateData, bloodOxygen: self.healthkitdata.bloodOxygenData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // Show error page
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    //print(httpResponse.description)
                    
                }
                
                
                // check if status code == 201
                // stop loading screen and continue with app stuff
                    
            }
            // Start task
            task.resume()
            
        }
        
     
        
        
    }
    
}
