//
//  DetailTableViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit


class DetailTableViewController: UIViewController{
  

    var selDish:String = ""
    
    @IBOutlet weak var dishImg: UIImageView!
    
    @IBOutlet weak var dishName: UILabel!
    
    @IBOutlet weak var dishPrice: UILabel!
    
    @IBOutlet weak var dishText: UILabel!
    
    
    @IBAction func orderBtnPressed(_ sender: Any) {
        let num = MenuInit.GetDishInfoInt(name : dishName.text!, colume : "num")
        let nNum = num + 1
        print(num)
        print(nNum)
        let sqlite = SQLiteManager.sharedInstance
        sqlite.openDB()
        let update = "UPDATE dishes SET 'num' = '\(nNum)' WHERE name ='\(dishName.text!)'"
        sqlite.execQuerySQL(sql: update)
        
        let alert = UIAlertController(title: "加入订单成功", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detail = MenuInit.GetDish(name: selDish)[0]
        let IPrice = detail["price"] as! NSNumber
        let price = "\(IPrice)"
        dishName.text = (detail["name"] as! String?)
        dishPrice.text = price
        dishText.text = detail["detail"] as! String?
        dishText.numberOfLines = 0
        dishImg.image = UIImage(named:"\(dishName.text!)")
        
    }

    

}
