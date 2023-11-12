//
//  HelpPageController.swift
//  NeuraCare
//
//  Created by yajurva shrotriya on 11/11/23.
//

import UIKit

class HelpPageController: UIViewController {


    @IBOutlet weak var caregiverImage: UIImageView!
    
    @IBOutlet weak var momImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "mom") as UIImage?
        
        caregiverImage.layer.cornerRadius = 5
        momImage.layer.cornerRadius = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
           
        momImage.isUserInteractionEnabled = true
            
        momImage.addGestureRecognizer(tapGestureRecognizer)
        
        caregiverImage.isUserInteractionEnabled = true
        caregiverImage.addGestureRecognizer(tapGestureRecognizer2)
        
        
       
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        call()
        // Your action
    }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        call()
        // Your action
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    func call() {

        let app = UIApplication.shared

        guard let number = URL(string: "tel://" + "6696094392"), app.canOpenURL(number) else {
            return
        }
        
        app.openURL(number)
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
