//
//  TBViewController.swift
//  Final_Project
//
//  Created by mb on 06/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire

class TBViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

  
    var name = ["Ali Hassan","Abdul Qudoos", "Nasir Khan"]
    var kmm = ["2 km","3 km", "5 Km"]
    var strt = [4,4,2]
    var Mm = ""
    var D = ""
    @IBOutlet weak var tbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return List_Mulana.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TemppTableViewCell
      //  cell.title.text = name[indexPath.row]
        //cell.km.text = kmm[indexPath.row]
        cell.title.text = List_Mulana[indexPath.row].M_Name
        cell.km.text = List_Mulana[indexPath.row].M_Distance + "KM"
       // switch strt[indexPath.row] {
          switch Int(List_Mulana[indexPath.row].M_Ranking) {
          case 1?:
            cell.s1.image = #imageLiteral(resourceName: "StartFil")
            cell.s2.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s3.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s4.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s5.image = #imageLiteral(resourceName: "StarEmpty")
          case 2?:
            cell.s1.image = #imageLiteral(resourceName: "StartFil")
            cell.s2.image = #imageLiteral(resourceName: "StartFil")
            cell.s3.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s4.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s5.image = #imageLiteral(resourceName: "StarEmpty")
          case 3?:
            cell.s1.image = #imageLiteral(resourceName: "StartFil")
            cell.s2.image = #imageLiteral(resourceName: "StartFil")
            cell.s3.image = #imageLiteral(resourceName: "StartFil")
            cell.s4.image = #imageLiteral(resourceName: "StarEmpty")
            cell.s5.image = #imageLiteral(resourceName: "StarEmpty")
          case 4?:
            cell.s1.image = #imageLiteral(resourceName: "StartFil")
            cell.s2.image = #imageLiteral(resourceName: "StartFil")
            cell.s3.image = #imageLiteral(resourceName: "StartFil")
            cell.s4.image = #imageLiteral(resourceName: "StartFil")
            cell.s5.image = #imageLiteral(resourceName: "StarEmpty")
          case 5?:
            cell.s1.image = #imageLiteral(resourceName: "StartFil")
            cell.s2.image = #imageLiteral(resourceName: "StartFil")
            cell.s3.image = #imageLiteral(resourceName: "StartFil")
            cell.s4.image = #imageLiteral(resourceName: "StartFil")
            cell.s5.image = #imageLiteral(resourceName: "StartFil")
        default:
            break;
        }
        tableView.rowHeight = 65
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
        
        
        
        let editAction = UITableViewRowAction(style: .normal, title: "View Comments") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
          
            // create the alert
            let alert = UIAlertController(title: List_Mulana[indexPath.row].M_Name, message: List_Mulana[indexPath.row].M_Comments, preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        editAction.backgroundColor = .red
        
        
        
        return [editAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        Mm = List_Mulana[indexPath.row].M_Id
        D = List_Mulana[indexPath.row].M_Distance
       
        Insertdata()
        
        
    }
    
    
    func Insertdata()  {
        let urlstring = "\(AppDelegate.url)Mulana_Request"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            
           "User_id": User.U_Id,
           "User_Lat": String(User.U_Lat),
           "User_Long": String(User.U_Long),
           "User_Adress": User.U_Adress,
           "Fikkah": S_Fikkah,
           "Service": S_Service,
           "Details": S_Details,
           "Date_From": S_Time_From,
           "Date_To": S_Time_To,
           "Mulana_id": Mm,
         "Distance": D
            
        ]
        print(parameters)
        //        let header = ["Content-Type ":"application/json"]
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
                        let res = dic.value(forKey: "Mulana_RequestResult") as! Bool

                        print(res)
                        DispatchQueue.main.async {
                            if res == true{
                                // create the alert
                                let alert = UIAlertController(title: "Rpppequest Sucessfully Sent", message: "", preferredStyle: UIAlertControllerStyle.alert)
                                
                                // add an action (button)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                
                                // show the alert
                                self.present(alert, animated: true, completion: nil)
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
