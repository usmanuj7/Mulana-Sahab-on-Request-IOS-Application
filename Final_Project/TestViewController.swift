//
//  TestViewController.swift
//  Final_Project
//
//  Created by Muhammad Usman on 28/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var TV: UITableView!
    var dataary = [userDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataary.count
        
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestTableViewCell
        
        cell.userId.text = String( dataary[indexPath.row].id)
         cell.title.text = dataary[indexPath.row].title
         cell.body.text = dataary[indexPath.row].body
        tableView.rowHeight = 90
        return cell
        
    }
    
    
    @IBAction func btnGetData(_ sender: Any) {
        getdata()
        print("\n\n\(dataary)" )
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                            if dic_d.value(forKey: "userId") == nil{
                          obj.userId = 9999
                            }
                            obj.id = dic_d.value(forKey: "id") as! Int
                            obj.title = dic_d.value(forKey: "title") as! String
                            obj.body = dic_d.value(forKey: "body") as! String
                            self.dataary.append(obj)
                            
                            self.TV.reloadData()
                            
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
                              //  print(self.dataary)
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

class userDetails{
    var userId = 0
    var id = 0
    var title = ""
    var body = ""
    init(){
        userId = 0
        id = 0
        title = ""
        body = ""
        
    }
}
