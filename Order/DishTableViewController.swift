//
//  DishTableViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit

class DishTableViewController: UITableViewController {

    var selRst:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE restaurant = '\(selRst)'")
        return queryResult!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath)

        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE restaurant = '\(selRst)'")
        
        let IPrice = queryResult?[indexPath.row]["price"] as! NSNumber
        let price = "\(IPrice)"
        cell.textLabel?.text = queryResult?[indexPath.row]["name"] as! String?
        cell.detailTextLabel?.text = "价格：￥" + price
        cell.imageView?.image = UIImage(named:"\(cell.textLabel!.text!)")
           return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE restaurant = '\(selRst)'")

        guard let detailViewController =  segue.destination as? DetailTableViewController else {return}
        let indexPaths = self.tableView?.indexPathsForSelectedRows
        let indexPath = indexPaths![0]
        let dish = queryResult?[indexPath.row]["name"] as! String?
        detailViewController.selDish =  dish!        
    }

}
