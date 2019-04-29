//
//  ResourcesViewController.swift
//  iClassAuth
//
//  Created by Nicholas Wang on 4/26/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework

class ResourcesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatSkyBlue() as Any, UIColor.flatGreen() as Any])
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gradescope(_ sender: Any) {
        guard let url = URL(string: "https://www.gradescope.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func calcentral(_ sender: Any) {
        guard let url = URL(string: "https://www.calcentral.berkeley.edu") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func emailprof(_ sender: Any) {
        guard let url = URL(string: "https://www.gmail.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func classLocation(_ sender: Any) {
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
