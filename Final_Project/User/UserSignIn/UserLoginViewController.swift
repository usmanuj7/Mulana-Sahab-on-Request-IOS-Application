//
//  ViewController.swift
//  Final_Project
//
//  Created by mb on 05/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
var abc = 0

import Alamofire
class UserLoginViewController: UIViewController {

    @IBOutlet weak var Txt_Password: UITextField!
    @IBOutlet weak var Txt_Ph_Number: UITextField!
var dataary = [userDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login_Button(_ sender: Any) {
        
        getdata()
    }
    
    func getdata()  {
  //      let urlstring = "\(AppDelegate.url)User_Login/\(Txt_Ph_Number.text!)/\(Txt_Password.text!)"
        let urlstring = "\(AppDelegate.url)posts"
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
                       let dic = JSON as! NSArray
                      //  let res = dic.value(forKey: "User_LoginResult") as! NSDictionary
                       // let dic = JSON as! NSDictionary
                       // let res = dic.value(forKey: "Mulana_HistoryResult") as! NSArray
                        for item in dic{
                            let obj = userDetails()
                            let dic_d = item as! NSDictionary
                            obj.userId = dic_d.value(forKey: "userId") as! Int
                            obj.id = dic_d.value(forKey: "id") as! Int
                            obj.title = dic_d.value(forKey: "title") as! String
                            obj.body = dic_d.value(forKey: "body") as! String
                            self.dataary.append(obj)
                            
                            
                        }
                        /*User.U_Id = res.value(forKey: "id") as! String
                        
                        User.U_Name = res.value(forKey: "Name") as! String
                        User.U_Ph_Number = res.value(forKey: "Ph_Number") as! String
                        User.U_Status = res.value(forKey: "Status") as! Bool
                        User.U_Lat = res.value(forKey: "Lat") as! Double
                        User.U_Long = res.value(forKey: "Long") as! Double
                        User.U_Adress = res.value(forKey: "Adress") as! String
*/
                        print(dic)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                               // self.performSegue(withIdentifier: "GoLogin", sender: nil)
                                print(self.dataary)
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
  

}




class User_Class{
    var U_Id = ""
    var U_Name = ""
    var U_Ph_Number = ""
    var U_Lat = 0.0
    var U_Long = 0.0
    var U_Adress = ""
    var U_Status = false
    init() {
        U_Id = ""
        U_Name = ""
        U_Adress = ""
        U_Lat = 0.0
        U_Long = 0.0
        U_Ph_Number = ""
        U_Status = false
        
    }
}


