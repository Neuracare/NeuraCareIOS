//
//  NotificationController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import Foundation
import UIKit

class NotificationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var datasource: [[String]] = [
        ["Morning Meds", "Take morning pills at 08:00", "2022-12-01"],
        ["Doctor Visit", "Appointment at 13:00", "2022-12-01"],
        ["Afternoon Meds", "Take afternoon pills at 14:00", "2022-12-01"],
        ["Hydration", "Drink water at 16:00", "2022-12-01"],
        ["Evening Walk", "Go for a walk at 18:00", "2022-12-01"],
        ["Evening Meds", "Take evening pills at 20:00", "2022-12-01"],
        ["Bedtime", "Prepare for bed at 22:00", "2022-12-01"]
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        cell.title.text = datasource[indexPath.row][0]
        cell.desc.text = datasource[indexPath.row][1]
        cell.date.text = datasource[indexPath.row][2]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.backgroundColor = .white
        
        let nib = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "NotificationTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

