//
//  Search_ViewController.swift
//  Final_Project
//
//  Created by mb on 06/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire
//var dataary = [dataclass]()
var List_Mulana = [Search_Mulana]()
var S_Id = User.U_Id
var S_User_Lat = 0.0
var S_User_Long = 0.0
var S_User_Adress = ""
var S_Fikkah = ""
var S_Service = ""
var S_Time_To = ""
var S_Time_From = ""
var S_Details = ""

class UserMainSearchViewController: UIViewController {


    @IBOutlet weak var Date_Time_Picker_1: UIDatePicker!
    
    @IBOutlet weak var Date_Time_Picker_2: UIDatePicker!
    
    @IBOutlet weak var Fikkah: UIButton!
    
    @IBOutlet weak var Service: UIButton!
    
    @IBOutlet weak var TxtDetails: UITextView!
    
    var Fikkah1 = ""
    var Service1 = ""
    var TimeTo = ""
    var TimeFrom = ""
    var Details = ""
    
    
    override func viewDidLoad() {
        
        Date_Time_Picker_1.locale = NSLocale(localeIdentifier: "en_GB") as Locale
         Date_Time_Picker_2.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Btn_Fikkah(_ sender: Any) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Sunni(Barelvi)", style: .default)
        { _ in
            print("Save")
            self.Fikkah1 = "Sunni(Barelvi)"
            self.Fikkah.setTitle(self.Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Sunni(Deobandi)", style: .default)
        { _ in
            print("Delete")
            self.Fikkah1 = "Sunni(Deobandi)"
            self.Fikkah.setTitle(self.Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        
        let deweleteActionButton = UIAlertAction(title: "Sunni(Ahl-e-Hadees)", style: .default)
        { _ in
            print("Delete")
            self.Fikkah1 = "Sunni(Ahl-e-Hadees)"
            self.Fikkah.setTitle(self.Fikkah1, for: .normal)
            
        }
        actionSheetControllerIOS8.addAction(deweleteActionButton)
        
        
        let NoActionButton = UIAlertAction(title: "Shia", style: .default)
        { _ in
            print("Delete")
            self.Fikkah1 = "Shia"
            self.Fikkah.setTitle(self.Fikkah1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(NoActionButton)
        
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    @IBAction func ListOfServices(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton = UIAlertAction(title: "Quran Tution", style: .default)
        { _ in
            print("Save")
            self.Service1 = "Quran Tution"
            self.Service.setTitle(self.Service1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Nikkah", style: .default)
        { _ in
            print("Delete")
            self.Service1 = "Nikkah"
            self.Service.setTitle(self.Service1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        
        let deweleteActionButton = UIAlertAction(title: "Dua-e-Khair", style: .default)
        { _ in
            print("Delete")
            self.Service1 = "Dua e Khair"
            self.Service.setTitle(self.Service1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(deweleteActionButton)
        
        let dedfdweleteActionButton = UIAlertAction(title: "Namaz-e-Janaza", style: .default)
        { _ in
            print("Delete")
            self.Service1 = "Namaz e Janaza"
            self.Service.setTitle(self.Service1, for: .normal)
            
        }
        actionSheetControllerIOS8.addAction(dedfdweleteActionButton)
        
        let dedfdhyjActionButton = UIAlertAction(title: "Khatam", style: .default)
        { _ in
            print("Delete")
            self.Service1 = "Khatam"
            self.Service.setTitle(self.Service1, for: .normal)
        }
        actionSheetControllerIOS8.addAction(dedfdhyjActionButton)
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
    @IBAction func From(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm tt"
        var res = formatter.string(from: (sender as AnyObject).date)
        self.TimeFrom = res
        print(self.TimeFrom)
        
    }
    
    @IBAction func To(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm tt"
        var res = formatter.string(from: (sender as AnyObject).date)
        self.TimeTo = res
        print(self.TimeTo)
        
    }
    
    
    @IBAction func Btn_Search(_ sender: Any) {
        
        setvar()
        
        Insertdata()
        
        
    }
    
    func setvar()
    {
        S_Fikkah = self.Fikkah1
        S_Service = self.Service1
        S_Time_From = self.TimeFrom
        S_Time_To = self.TimeTo
        S_Details = self.Details
        
        
        
    }
    
    func Insertdata()  {
        let urlstring = "\(AppDelegate.url)Search_Mulana"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            "User_id":S_Id,
            "Fikkah":self.Fikkah1,
            "Service":self.Service1,
            "Details":self.Details,
            "TimeFrom":self.TimeFrom,
            "TimeTo":self.TimeTo,
            "Lat":String(S_User_Lat),
            "Long":String(S_User_Long),
            "Adress":S_User_Adress
            
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
                        List_Mulana.removeAll()
                        let dic = JSON as! NSDictionary
                        let res = dic.value(forKey: "Search_MulanaResult") as! NSArray
                        for item in res{
                         let obj = Search_Mulana()
                         let dic_d = item as! NSDictionary
                            obj.M_Distance = dic_d.value(forKey: "Distance") as! String
                            obj.M_Adress = dic_d.value(forKey: "Adress") as! String
                            obj.M_Status = dic_d.value(forKey: "Status") as! Bool
                            obj.M_Lat = dic_d.value(forKey: "M_Lat") as! Double
                            obj.M_Long = dic_d.value(forKey: "M_Long") as! Double
                            obj.M_Ranking = dic_d.value(forKey: "M_Ranking") as! String
                            obj.M_Comments = dic_d.value(forKey: "M_Comments") as! String
                            obj.M_Name = dic_d.value(forKey: "M_Name") as! String
                            obj.M_Id = dic_d.value(forKey: "M_Id") as! String
                            //obj.dd = Int (obj.M_Distance)!
                            List_Mulana.append(obj)
                        
                         }
                        // let User = User_Class()
                        //User.U_Id = res.value(forKey: "Id") as! String
                        
                    
                        
                        print(res)
                        DispatchQueue.main.async {
                            if User.U_Status == true{
                                self.performSegue(withIdentifier: "Search_Mulana_To_List", sender: nil)
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

class Search_Mulana{
    var M_Id = ""
    var M_Name = ""
    var M_Lat = 0.0
    var M_Long = 0.0
    var dd = 0
    var M_Adress = ""
    var M_Status = false
    var M_Comments = ""
    var M_Distance = ""
    var M_Ranking = ""
    init() {
        M_Id = ""
        M_Name = ""
        M_Comments = ""
        M_Adress = ""
        M_Lat = 0.0
        M_Long = 0.0
        dd = 0
        M_Status = false
        M_Distance = ""
        M_Ranking = ""
        
    }
}

