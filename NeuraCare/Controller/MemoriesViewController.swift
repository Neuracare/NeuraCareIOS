//
//  MemoriesViewController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import UIKit

class MemoriesViewController: UIViewController {

    
    @IBOutlet weak var journalLabel: UILabel!
    
    var journal = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getData() {
        var request = URLRequest(url: URL(string: "https://backend.neuracare.tech/patient/info")!)
        
        // Configure POST Request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = HTTP.createTodo(id: "rmadith@gmail.com", query: "summary")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // Show error page
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.description)
                
            }
            
            let decoder = JSONDecoder()
            
                do {
                    
                    let decodedData = try decoder.decode([String].self, from: data)
                    for element in decodedData{
                        self.journal += " - \(element) \n "
                    }
                    
                    DispatchQueue.main.async {
                        self.journalLabel.text = self.journal
                    }
                    
                } catch{
                    print(error)
                }

            print(data)
            
            
            // check if status code == 201
            // stop loading screen and continue with app stuff
                
        }
        // Start task
        task.resume()
    }
}
