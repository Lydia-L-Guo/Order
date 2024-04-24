//
//  OrderTableViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {


    @IBOutlet weak var priceSumLabel: UILabel!
    
    @IBAction func submitPressed(_ sender: Any) {
        var action: UIAlertAction? = nil
        let alert = UIAlertController(title: "提交订单", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { action in let mainBoard:UIStoryboard! = UIStoryboard(name:"Main", bundle: nil)
            let confirmVC = mainBoard!.instantiateViewController(withIdentifier:"confirmVC")
        UIApplication.shared.windows[0].rootViewController = confirmVC }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")
        navigationController?.tabBarItem.badgeValue = "\(queryResult!.count)"
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){}
           let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")
           let n = queryResult?.count
        
           return n!
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath)
       
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")
        let Inum = queryResult?[indexPath.row]["num"] as! NSNumber
        let num = "\(Inum)"
        cell.textLabel?.text = queryResult?[indexPath.row]["name"] as! String?
        cell.detailTextLabel?.text = "数量：" + num
        cell.imageView?.image = UIImage(named:"\(cell.textLabel!.text!)")
        let sumPrice = MenuInit.GetPriceSum()
        priceSumLabel.text = "     订单总价：￥"+"\(sumPrice)"
        return cell
       }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let sqlite = SQLiteManager.sharedInstance
            if !sqlite.openDB(){}
            let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")
            let name = queryResult?[indexPath.row]["name"] as? String
            print(queryResult!)
            sqlite.openDB()
            let update = "UPDATE dishes SET 'num' = '0' WHERE name ='\(name!)'"
            sqlite.execQuerySQL(sql: update)

            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidLoad()
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { //刷新
           tableView.reloadData()
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")
        guard let detailViewController =  segue.destination as? DetailTableViewController else {return}
        let indexPaths = self.tableView?.indexPathsForSelectedRows
        let indexPath = indexPaths![0]
        let dish = queryResult?[indexPath.row]["name"] as! String?
        detailViewController.selDish =  dish!
    }
}
