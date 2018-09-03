//
//  Mulana_Login_ViewController.swift
//  Final_Project
//
//  Created by mb on 27/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire

let Mulana = Mulana_Class()

class Mulana_Login_ViewController: UIViewController {

    @IBOutlet weak var Txt_Ph_Number: UITextField!
    
    @IBOutlet weak var Txt_Password: UITextField!
  
    var avi = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Btn_Login(_ sender: Any) {
        
        
        getdata()
        
    }
    
    func getdata()  {
        let urlstring = "\(AppDelegate.url)Mulana_Login/\(Txt_Ph_Number.text!)/\(Txt_Password.text!)"
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
                        let res = dic.value(forKey: "Mulana_LoginResult") as! NSDictionary
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
                        Mulana.M_Id = res.value(forKey: "id") as! String
                        
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
                                self.avi = "yes"
                               
                                self.Change_Status()
                                self.performSegue(withIdentifier: "Mulana_Login_Details", sender: nil)
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
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Change_Status()  {
        let urlstring = "\(AppDelegate.url)Mulana_Availability/\(Mulana.M_Id)/\(avi)"
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
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "Mulana_AvailabilityResult") as! Bool
                        
                        print(res)
                        DispatchQueue.main.async {
                            if res == true{
                                let alert = UIAlertController(title: "Status changed to ", message: "", preferredStyle: UIAlertControllerStyle.alert)
                                
                                // add an action (button)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                
                                // show the alert
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Status not changed", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                    
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


class Mulana_Class{
    var M_Id = ""
    var M_Name = ""
    var M_Ph_Number = ""
    var M_Lat = 0.0
    var M_Long = 0.0
    var M_Adress = ""
    var M_Status = false
    init() {
        M_Id = ""
        M_Name = ""
        M_Adress = ""
        M_Lat = 0.0
        M_Long = 0.0
        M_Ph_Number = ""
        M_Status = false
        
    }
}



