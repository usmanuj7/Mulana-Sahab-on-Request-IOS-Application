//
//  Mulana_Rejected_Table_ViewController.swift
//  Final_Project
//
//  Created by mb on 01/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
var Mulana_Reject_Request = [Mulana_Request_Details]()

class Mulana_Rejected_Table_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TV: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(Mulana_Reject_Request.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Mulana_Rejected_TableViewCell
        
        cell.Lbl_Name.text = Mulana_Reject_Request[indexPath.row].R_Name
        cell.Lbl_Service.text = Mulana_Reject_Request[indexPath.row].R_Service
        cell.Lbl_Time.text = Mulana_Reject_Request[indexPath.row].R_Time_From + " " + Mulana_Reject_Request[indexPath.row].R_Time_To
        tableView.rowHeight = 70
        return(cell)
        
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
        let urlstring = "\(AppDelegate.url)Mulana_History"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            
            "id": Mulana.M_Id,
            "status": "2"
            
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
                        Mulana_Reject_Request.removeAll()
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
                            
                            
                            
                            Mulana_Reject_Request.append(obj)
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
