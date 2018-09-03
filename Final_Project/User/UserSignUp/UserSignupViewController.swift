//
//  TempViewController.swift
//  Final_Project
//
//  Created by mb on 06/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire
var _lat  = 0.0
var _long = 0.0
var _Addres = ""
 let User = User_Class()
class UserSignupViewController: UIViewController {

    @IBOutlet weak var Txt_Name: UITextField!
    @IBOutlet weak var Txt_Ph_Number: UITextField!
   
    @IBOutlet weak var Txt_Password: UITextField!
    
    @IBOutlet weak var Txt_Confirm_Pasword: UITextField!
    
    @IBOutlet weak var Fikkah1: UIButton!
    
    var Fikkah: String = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Signup(_ sender: Any) {
        
        Insertdata()
    }
    @IBAction func Pop(_ sender: UIButton) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Sunni(Barelvi)", style: .default)
        { _ in
            print("Save")
            self.Fikkah = "Sunni(Barelvi)"
            self.Fikkah1.setTitle(self.Fikkah, for: .normal)
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Sunni(Deobandi)", style: .default)
        { _ in
            print("Delete")
            self.Fikkah = "Sunni(Deobandi)"
             self.Fikkah1.setTitle(self.Fikkah, for: .normal)
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        
        let deweleteActionButton = UIAlertAction(title: "Sunni(Ahl-e-Hadees)", style: .default)
        { _ in
            print("Delete")
              self.Fikkah = "Sunni(Ahl-e-Hadees)"
             self.Fikkah1.setTitle(self.Fikkah, for: .normal)
        
        }
        actionSheetControllerIOS8.addAction(deweleteActionButton)
        
        
        let NoActionButton = UIAlertAction(title: "Shia", style: .default)
        { _ in
            print("Delete")
            self.Fikkah = "Shia"
             self.Fikkah1.setTitle(self.Fikkah, for: .normal)
        }
        actionSheetControllerIOS8.addAction(NoActionButton)
        
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    func Insertdata()  {
        let urlstring = "\(AppDelegate.url)User_Signup"
//(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
                let parameters = [
                    "Name":"\(Txt_Name.text!)",
                    "Phone_Number":"\(Txt_Ph_Number.text!)",
                    "Password":"\(Txt_Password.text!)",
                    "Fikkah":"\(Fikkah)",
                    "Lat":"\(_lat)",
                    "Long":"\(_long)",
                    "Adress":_Addres
                    
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
                        let res = dic.value(forKey: "User_SignupResult") as! NSDictionary
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
                       
                        //User.U_Id = res.value(forKey: "Id") as! String
                        
                        User.U_Name = res.value(forKey: "Name") as! String
                        User.U_Ph_Number = res.value(forKey: "Ph_Number") as! String
                        User.U_Status = res.value(forKey: "Status") as! Bool
                        User.U_Lat = res.value(forKey: "Lat") as! Double
                        User.U_Long = res.value(forKey: "Long") as! Double
                        User.U_Adress = res.value(forKey: "Adress") as! String
                        
                        print(res)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                                self.performSegue(withIdentifier: "User_Signup_Search", sender: nil)
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
                
                
                
                
        }
    }

    
    func getdata()  {
        let urlstring = "\(AppDelegate.url)User_Login/\(Txt_Ph_Number.text!)/\(Txt_Password.text!)"
        //        let parameters = [
        //            "group_id":"\(info.g_id)"
        //        ]
        //        let header = ["Content-Type":"application/json"]
        print("\(urlstring)")
        
        Alamofire.request (urlstring ,method : .get, parameters: nil, encoding
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
                        let res = dic.value(forKey: "User_LoginResult") as! NSDictionary
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
                        let User = User_Class()
                        User.U_Id = res.value(forKey: "id") as! String
                        
                        User.U_Name = res.value(forKey: "Name") as! String
                        User.U_Ph_Number = res.value(forKey: "Ph_Number") as! String
                        User.U_Status = res.value(forKey: "Status") as! Bool
                        User.U_Lat = res.value(forKey: "Lat") as! Double
                        User.U_Long = res.value(forKey: "Long") as! Double
                        User.U_Adress = res.value(forKey: "Adress") as! String
                        
                        print(res)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                                self.performSegue(withIdentifier: "GoLogin", sender: nil)
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Invalid Credentials", message: "Kindly Enter Valid Credentials", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    self.Txt_Ph_Number.text = ""
                    self.Txt_Password.text = ""
                    
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


