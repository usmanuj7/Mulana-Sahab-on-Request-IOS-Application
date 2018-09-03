//
//  REqTVViewController.swift
//  Final_Project
//
//  Created by mb on 07/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire
var Mulana_Request = [Mulana_Request_Details]()
let Map_Data = Mulana_Request_Details()

class REqTVViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tv: UITableView!
    var Ref_Table_Id = ""
    var M_Responce_Status = ""
    var avi = ""
    var des = ""
    @IBOutlet weak var Switch_Availibility: UISwitch!
    
    var name = ["Usman","Abdullah", "Zeeshan"]
    var kmm = ["June 7, 3pm - 5pm","June 7, 6pm - 7pm", "June 9, 9am - 10pm"]
    var strt = ["Dua-e-Khair","quran khani","Namaz-e-Janazah"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Mulana_Request.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReqTableViewCell
        cell.Name.text = Mulana_Request[indexPath.row].R_Name
        cell.Time.text = Mulana_Request[indexPath.row].R_Time_From + "  " + Mulana_Request[indexPath.row].R_Time_To
        cell.servies.text = Mulana_Request[indexPath.row].R_Service
        cell.servies.tag = indexPath.row
        cell.Btn_Direction.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        tableView.rowHeight = 70
       return cell
    }
    
   @objc func buttonAction(sender: UIButton!) {
       Map_Data.R_Lat = Mulana_Request[sender.tag].R_Lat
     Map_Data.R_Long = Mulana_Request[sender.tag].R_Long
     Map_Data.R_Adress = Mulana_Request[sender.tag].R_Adress
    
    self.performSegue(withIdentifier: "Map", sender: tv)
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // create the alert
       // let alert = UIAlertController(title: "Responce for the request", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
       // alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: nil))
        // add an action (button)
       // alert.addAction(UIAlertAction(title: "Reject", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
       // self.present(alert, animated: true, completion: nil)
        
        var uiAlert = UIAlertController(title: "Responce for the request", message: "", preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { action in
            print("Click of default button")
            self.Ref_Table_Id = Mulana_Request[indexPath.row].Table_Id;
            self.M_Responce_Status = "1"
            self.M_Responce()
            self.tv.reloadData()
            
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Reject", style: .cancel, handler: { action in
            print("Click of cancel button")
            
            self.Ref_Table_Id = Mulana_Request[indexPath.row].Table_Id;
            self.M_Responce_Status = "2"
            self.M_Responce()
            self.tv.reloadData()
        }))

    }
    
    
    @IBAction func AC_Switch(_ sender: UISwitch) {
        
        if Switch_Availibility.isOn
        {
            avi = "yes"
            des = "Online"
            Change_Status()
        }
        
        else{
            avi = "no"
            des = "Offline"
            Change_Status() 
        }
        
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        
        avi = "no"
        Change_Status() 
    }
    
    
    
    func getdata()  {
        let urlstring = "\(AppDelegate.url)Mulana_History"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            
            "id": Mulana.M_Id,
            "status": "0"
        
        ]
        print(parameters)
        print("Mulana Id", Mulana.M_Id)
        
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
                        Mulana_Request.removeAll()
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "Mulana_HistoryResult") as! NSArray
                        for item in res{
                            let obj = Mulana_Request_Details()
                            let dic_d = item as! NSDictionary
                            obj.R_Id = dic_d.value(forKey: "Id") as! String
                            obj.R_Adress = dic_d.value(forKey: "Adress") as! String
                            obj.R_Status = dic_d.value(forKey: "Status") as! String
                            obj.R_Lat = dic_d.value(forKey: "Lat") as! Double
                            obj.R_Long = dic_d.value(forKey: "Long") as! Double
                            obj.R_Service = dic_d.value(forKey: "Service") as! String
                            obj.R_Name = dic_d.value(forKey: "Name") as! String
                            obj.Table_Id = dic_d.value(forKey: "Table_Id") as! String
                            obj.R_Time_To = dic_d.value(forKey: "Time_To") as! String
                            obj.R_Time_From = dic_d.value(forKey: "Time_From") as! String
                            
                           
                            
                            Mulana_Request.append(obj)
                             print(obj.R_Id)
                            
                            
                        }
                        // let User = User_Class()
                        //User.U_Id = res.value(forKey: "Id") as! String
                        
                        
                        
                        print(res)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                                print("Sucessfully loaded")
                            }
                            self.tv.reloadData()
                            
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
                
                
        }
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
                                let alert = UIAlertController(title: "Status changed to \(self.des)", message: "", preferredStyle: UIAlertControllerStyle.alert)
                                
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


    
    func M_Responce()  {
        let urlstring = "\(AppDelegate.url)Mulana_Responce"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            
            "Id": Ref_Table_Id,
            "Status": M_Responce_Status
      
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
                        Mulana_Request.removeAll()
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "Mulana_ResponceResult") as! Bool
                  
                        
                        print(res)
                        DispatchQueue.main.async {
                            if res == true{
                                print("Sucessfully Updated")
                            }
                            self.tv.reloadData()
                            
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

class Mulana_Request_Details{
    var R_Id = ""
    var R_Name = ""
    var R_Lat = 0.0
    var R_Long = 0.0
    var R_Adress = ""
    var R_Status = ""
    var Table_Id = ""
    var R_Time_From = ""
    var R_Time_To = ""
    var R_Service = ""
    init() {
        R_Id = ""
        R_Name = ""
        R_Adress = ""
        Table_Id = ""
        R_Lat = 0.0
        R_Long = 0.0
        R_Status = ""
         R_Time_From = ""
        R_Time_To = ""
        R_Service = ""
        
    }
}

