//
//  Mulana_Sahab_Signup_2_ViewController.swift
//  Final_Project
//
//  Created by mb on 24/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire

var Qualifications = ""
var Services = ""

class Mulana_Sahab_Signup_2_ViewController: UIViewController {

    
    @IBOutlet weak var RadioBtnQuranTution: UIButton!
    
    @IBOutlet weak var RadioBtnNikkah: UIButton!
    
    @IBOutlet weak var RadioBtnDuaeKhair: UIButton!
    
    @IBOutlet weak var RadioBtnNamazeJanaza: UIButton!
    
    @IBOutlet weak var RadioBtnKhatam: UIButton!
    
    @IBOutlet weak var Fikkah: UIButton!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtnQuranTution(_ sender: Any) {
        Quran_Tution = Quran_Tution + 1
       
        
        if Quran_Tution % 2 == 1
        {
            RadioBtnQuranTution.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Quran_Tution % 2 == 0
        {
            RadioBtnQuranTution.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func BtnNikkah(_ sender: Any) {
        
        Nikkah = Nikkah+1
        
        if Nikkah % 2 == 1
        {
            RadioBtnNikkah.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Nikkah % 2 == 0
        {
            RadioBtnNikkah.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func BtnDuaeKhair(_ sender: Any) {
        
        Dua_e_Khair = Dua_e_Khair+1
        if Dua_e_Khair % 2 == 1
        {
            RadioBtnDuaeKhair.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Dua_e_Khair % 2 == 0
        {
            RadioBtnDuaeKhair.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func BtnNamazeJanaza(_ sender: Any) {
        Namaz_e_Janaza = Namaz_e_Janaza+1
        if Namaz_e_Janaza % 2 == 1
        {
            RadioBtnNamazeJanaza.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Namaz_e_Janaza % 2 == 0
        {
            RadioBtnNamazeJanaza.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    
    @IBAction func BtnKhatam(_ sender: Any) {
        
        Khatam = Khatam+1
        if Khatam % 2 == 1
        {
            RadioBtnKhatam.setImage(UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        if Khatam % 2 == 0
        {
            RadioBtnKhatam.setImage(UIImage(named: "unchk")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    
    @IBAction func BtnFikkah(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Sunni(Barelvi)", style: .default)
        { _ in
            print("Save")
            Fikkah1 = "Sunni(Barelvi)"
            self.Fikkah.setTitle(Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Sunni(Deobandi)", style: .default)
        { _ in
            print("Delete")
            Fikkah1 = "Sunni(Deobandi)"
              self.Fikkah.setTitle(Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        
        let deweleteActionButton = UIAlertAction(title: "Sunni(Ahl-e-Hadees)", style: .default)
        { _ in
            print("Delete")
            Fikkah1 = "Sunni(Ahl-e-Hadees)"
             self.Fikkah.setTitle(Fikkah1, for: .normal)
            
        }
        actionSheetControllerIOS8.addAction(deweleteActionButton)
        
        
        let NoActionButton = UIAlertAction(title: "Shia", style: .default)
        { _ in
            print("Delete")
            Fikkah1 = "Shia"
             self.Fikkah.setTitle(Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(NoActionButton)
        
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
    @IBAction func MulanaSignup(_ sender: Any) {
        
      
        Qualifications_Services()
        Insertdata()
        
    }
    
    
   
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func Qualifications_Services()
    {
   
        
        if Quran_Tution % 2 == 1
        {
            Services = Services + "Quran Tution_"
        }
        
        if Nikkah % 2 == 1
        {
            Services = Services + "Nikkah_"
        }
        
        if Dua_e_Khair % 2 == 1
        {
            Services = Services + "Dua e Khair_"
        }
        
        if Namaz_e_Janaza % 2 == 1
        {
            Services = Services + "Namaz e Janaza_"
        }
        
        if Khatam % 2 == 1
        {
            Services = Services + "Khatam"
        }

    }
    
    
    func Insertdata()  {
        let urlstring = "\(AppDelegate.url)Mulana_Signup"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            "Name":Name,
            "Phone_Number":Ph_Number,
            "Password":Password,
            "Fikkah":Fikkah1,
            "Qualification":Qualifications,
            "Services":Services,
            "Lat":String(Mulana_lat),
            "Long":String(Mulana_long),
            "Adress":Mulana_Addres
            
        ]
        print(parameters)
        //        let header = ["Content-Type":"application/json"]
        print("\(urlstring)")
        
        Alamofire.request (urlstring ,method : .post, parameters: parameters, encoding
            : JSONEncoding.default,headers: nil).responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.data as Any)     // server data
                print(response.result)   // result of response serialization
                switch response.result {
                case .success:
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        // self.dataary.removeAll()
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "Mulana_SignupResult") as! NSDictionary
                        //for item in res{
                        // let obj = dataclass()
                        //  let dic_d = item as! NSDictionary
                        //obj.U_Id = dic_d.value(forKey: "id") as! String
                        //                            dataobj.id = res.value(forKey: "Adress") as! String
                        //                        dataobj.status = res.value(forKey: "Status") as! Bool
                        //                        dataobj.lat = res.value(forKey: "Lat") as! Double
                        //                        dataobj.long = res.value(forKey: "Long") as! Double
                        // self.dataary.append(obj)
                        //  }
                        // let User = User_Class()
                        //   Mulana.M_Id = res.value(forKey: "Id") as! String
                        
                        Mulana.M_Name = res.value(forKey: "Name") as! String
                        Mulana.M_Ph_Number = res.value(forKey: "Ph_Number") as! String
                        Mulana.M_Status = res.value(forKey: "Status") as! Bool
                        Mulana.M_Lat = res.value(forKey: "Lat") as! Double
                        Mulana.M_Long = res.value(forKey: "Long") as! Double
                        Mulana.M_Adress = res.value(forKey: "Adress") as! String
                        
                        print(Mulana.M_Name)
                        print(Mulana.M_Id)
                        print(Mulana.M_Lat)
                        print(Mulana.M_Long)
                        print(Mulana.M_Adress)
                        print(Mulana.M_Ph_Number)
                        
                        print(res)
                        DispatchQueue.main.async {
                            if Mulana.M_Status == true{
                                self.performSegue(withIdentifier: "Mulana_Signup_Details", sender: nil)
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
        
                
        }
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
