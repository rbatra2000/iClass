//
//  ResourcesViewController.swift
//  iClass
//
//  Created by Ritik Batra on 5/5/19.
//  Copyright © 2019 Ritik Batra. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class ResourcesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.radial, withFrame:view.frame, andColors:[UIColor.flatPowderBlue() as Any, UIColor.flatMint() as Any])
        
    }
    @IBAction func gradescope(_ sender: Any) {
        guard let url = URL(string: "https://www.gradescope.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func calcentral(_ sender: Any) {
        guard let url = URL(string: "https://calcentral.berkeley.edu/dashboard") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func back(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "logout", sender: self)
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
