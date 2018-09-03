//
//  Mulana_Signup_ViewController.swift
//  Final_Project
//
//  Created by mb on 20/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
var Hafiz = 0
var Aalim = 0
var Qari = 0
var Nikkah_Khawan = 0
var Quran_Tution = 0
var Nikkah = 0
var Dua_e_Khair = 0
var Khatam = 0
var Namaz_e_Janaza = 0
var Name = ""
var Ph_Number = ""
var Password = ""
var Fikkah1 = ""
var Mulana_lat  = 0.0
var Mulana_long = 0.0
var Mulana_Addres = ""

class Mulana_Signup_ViewController: UIViewController {
    
    
    

    @IBOutlet weak var Txtname: UITextField!
    
    @IBOutlet weak var Txtphnumber: UITextField!
    
    @IBOutlet weak var Txtpassword: UITextField!
    
    @IBOutlet weak var Txtconfirmpassowrd: UITextField!
    
    @IBOutlet weak var RadioBtnHafiz: UIButton!
    
    @IBOutlet weak var RadioBtnQari: UIButton!
    
    
    @IBOutlet weak var RadioBtnAalim: UIButton!
    
    @IBOutlet weak var RadioBtnNikkahKhawan: UIButton!
    
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
  
    


    @IBAction func BtnHafiz(_ sender: Any) {
        Hafiz = Hafiz+1
        
        if Hafiz % 2 == 1       {
            RadioBtnHafiz.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Hafiz % 2 == 0
        {
            RadioBtnHafiz.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
    }
    }
    @IBAction func BtnQari(_ sender: Any) {
        Qari = Qari+1
        
        if Qari % 2 == 1
        {
            RadioBtnQari.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Qari % 2 == 0
        {
            RadioBtnQari.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    }
    @IBAction func BtnAalim(_ sender: Any) {
        Aalim = Aalim+1
        
        if Aalim % 2 == 1
        {
            RadioBtnAalim.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Aalim % 2 == 0
        {
            RadioBtnAalim.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    }
    
    @IBAction func BtnNikkahKhawan(_ sender: Any) {
        Nikkah_Khawan = Nikkah_Khawan + 1
        
        if Nikkah_Khawan % 2 == 1
        {
            RadioBtnNikkahKhawan.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Nikkah_Khawan % 2 == 0
        {
            RadioBtnNikkahKhawan.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
    }
    
  
    @IBAction func BtnNext(_ sender: Any) {
        
        Name = Txtname.text!
        Ph_Number = Txtphnumber.text!
        Password = Txtpassword.text!
        print(Name)
        print(Ph_Number)
        print(Password)
        
        if Hafiz % 2 == 1
        {
            Qualifications = Qualifications + "Hafiz_"
        }
        
        if Qari % 2 == 1
        {
            Qualifications = Qualifications + "Qari_"
        }
        
        if Aalim % 2 == 1
        {
            Qualifications = Qualifications + "Aalim_"
        }
        
        if Nikkah_Khawan % 2 == 1
        {
            Qualifications = Qualifications + "Nikkah Khawan"
        }
        
        
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
