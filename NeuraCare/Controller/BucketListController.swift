//
//  BucketListController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import UIKit

class BucketListController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var datasource: [TodoItem] = []
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        
        
        let timeString = "\(formatTimeString(String(datasource[indexPath.row].time)))"
        
        let titletext = datasource[indexPath.row].title
        let datetext = "Date: \(datasource[indexPath.row].date)"
        let timetext = "Time: \(timeString)"
        
        cell.dateLabel.text = datetext
        cell.timeLabel.text = timetext
        cell.titleLabel.text = titletext
        
        //cell.setupCell(title: titletext , date: datetext, time: timetext)
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableview.dataSource = self
        tableview.delegate = self
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        
        let nib = UINib(nibName: "TodoTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "TodoTableViewCell")
        
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
        request.httpBody = HTTP.createTodo(id: "rmadith@gmail.com", query: "todo")
        
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
                    
                    let decodedData = try decoder.decode([TodoItem].self, from: data)
                    self.datasource = decodedData
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
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
        tableview.reloadData()
    }


func formatTimeString(_ timeString: String) -> String {
    switch timeString.count {
    case 4:
        // Insert colon after 2 digits for 4-digit strings
        let index = timeString.index(timeString.startIndex, offsetBy: 2)
        return timeString.prefix(upTo: index) + ":" + timeString.suffix(from: index)
    case 3:
        // Insert colon after 1 digit for 3-digit strings
        let index = timeString.index(timeString.startIndex, offsetBy: 1)
        return timeString.prefix(upTo: index) + ":" + timeString.suffix(from: index)
    default:
        // Return original string or handle as invalid format
        return "Invalid time format"
    }
}
}
