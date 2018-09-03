//
//  MulanaTimeViewController.swift
//  Final_Project
//
//  Created by mb on 23/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
var TTo = ""
var TFrom = ""

class MulanaTimeViewController: UIViewController {
    
    @IBOutlet weak var TimeFrom: UIDatePicker!
    
    @IBOutlet weak var TimeTo: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
   
    
    @IBAction func ToChange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm tt"
        var res = formatter.string(from: sender.date)
        TTo = res
        print(TTo)
        
        
        
    }
    @IBAction func Fromchange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm tt"
        var res = formatter.string(from: sender.date)
        TFrom = res
        print(TFrom)
        
      
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
