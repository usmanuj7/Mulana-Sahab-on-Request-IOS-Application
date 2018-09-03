//
//  User_AcceptedViewController.swift
//  Final_Project
//
//  Created by mb on 01/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
var User_Accept_request = [User_Request_Details]()
var U_Id = ""
var M_Id = ""

class User_AcceptedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TV: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(User_Accept_request.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! User_AcceptedTableViewCell
        
        cell.Lblname.text = User_Accept_request[indexPath.row].R_Name
        cell.Lblservice.text = User_Accept_request[indexPath.row].R_Service
        cell.Lbltime.text = User_Accept_request[indexPath.row].R_Time_From + " " + User_Accept_request[indexPath.row].R_Time_To
        tableView.rowHeight = 70
        
        return(cell)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        U_Id = User.U_Id
        M_Id = User_Accept_request[indexPath.row].R_Id
        
        performSegue(withIdentifier: "Feedback", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getdata()  {
        let urlstring = "\(AppDelegate.url)User_History"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            
            "id": User.U_Id,
            "status": "1"
            
        ]
        print(parameters)
        print("Mulana Id", User.U_Id)
        
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
                        User_Accept_request.removeAll()
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "User_HistoryResult") as! NSArray
                        for item in res{
                            let obj = User_Request_Details()
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
                            
                            
                            
                            User_Accept_request.append(obj)
                            print(obj.R_Id)
                            
                            
                        }
                        // let User = User_Class()
                        //User.U_Id = res.value(forKey: "Id") as! String
                        
                        
                        
                        print(res)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                                print("Sucessfully loaded")
                            }
                            self.TV.reloadData()
                            
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


class User_Request_Details{
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


