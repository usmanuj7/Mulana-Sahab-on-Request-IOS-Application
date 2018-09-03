//
//  Feedback_ViewController.swift
//  Final_Project
//
//  Created by mb on 01/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit
import Alamofire

var ranking = 0
var Comment = ""
var r = ""
class Feedback_ViewController: UIViewController {
    var b_one = 0
    var b_two = 0
    var b_three = 0
    var b_four = 0
    var b_five = 0

    @IBOutlet weak var Btn_One: UIButton!
    
    @IBOutlet weak var Btn_Two: UIButton!
    
    @IBOutlet weak var Btn_Three: UIButton!
    
    @IBOutlet weak var Btn_Four: UIButton!
    
    @IBOutlet weak var Btn_Five: UIButton!
    
    
    @IBOutlet weak var Txt_Comment: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func One(_ sender: Any) {
       b_one = b_one + 1
        if b_one % 2 == 1
        {
            Btn_One.setImage(UIImage(named: "Fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
            if b_one % 2 == 0
            {
                Btn_One.setImage(UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
    }
    
    @IBAction func Two(_ sender: Any) {
        b_two = b_two + 1
        if b_two % 2 == 1
        {
            Btn_Two.setImage(UIImage(named: "Fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if b_two % 2 == 0
        {
            Btn_Two.setImage(UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func Three(_ sender: Any) {
        
        b_three = b_three + 1
        if b_three % 2 == 1
        {
            Btn_Three.setImage(UIImage(named: "Fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if b_three % 2 == 0
        {
            Btn_Three.setImage(UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
  
    
    @IBAction func Four(_ sender: Any) {
        b_four = b_four + 1
        if b_four % 2 == 1
        {
            Btn_Four.setImage(UIImage(named: "Fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if b_four % 2 == 0
        {
            Btn_Four.setImage(UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
    }
    
    @IBAction func Five(_ sender: Any) {
        b_five = b_five + 1
        if b_five % 2 == 1
        {
            Btn_Five.setImage(UIImage(named: "Fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if b_five % 2 == 0
        {
            Btn_Five.setImage(UIImage(named: "StarEmpty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func Btn_Submit(_ sender: Any) {
        
        check()
       r = String(ranking)
        Comment = Txt_Comment.text!
     
        print(ranking)
        
        Insertdata()
       
       // ranking = 0
       // performSegue(withIdentifier: "Wapis", sender: self)
        
    }
    
    
  
    func check()
    {
        if b_one % 2 == 1 {
            ranking = ranking + 1
        }
        
        if b_two % 2 == 1 {
             ranking = ranking + 1
        }
        
        if b_three % 2 == 1 {
             ranking = ranking + 1
        }
        
        if b_four % 2 == 1 {
             ranking = ranking + 1
        }
        
        if b_five % 2 == 1 {
             ranking = ranking + 1
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func Insertdata()  {
        let urlstring = "\(AppDelegate.url)FEEDBACK"
        //(String Name, String Phone_Number, String Password, String Fikkah, String Lat, String Long, String Adress
        let parameters = [
            "M_Id": String(U_Id),
            "U_Id": String(M_Id),
            "Comment": Comment,
            "Ranking": String(ranking)
        
            ]
        print(parameters)
        print(U_Id)
        print(M_Id)
        print(Comment)
        print(ranking)



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
                        let res = dic.value(forKey: "FEEDBACKResult") as! String
                        
                        
                        print(res)
                        DispatchQueue.main.async {
                          //  if res == true{
                                self.performSegue(withIdentifier: "Wapis", sender: nil)
                           // }
                            
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
