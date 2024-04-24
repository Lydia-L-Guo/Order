//
//  RestaurantTableViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants")
        return queryResult!.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:UITableViewCell =
           tableView.dequeueReusableCell(withIdentifier: "rstCell", for: indexPath)

              RsInit.initDB()
              let sqlite = SQLiteManager.sharedInstance
              if !sqlite.openDB(){}
              let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants")
      
              cell.textLabel?.text = queryResult?[indexPath.row]["restaurant"] as! String?
              cell.detailTextLabel?.text = queryResult?[indexPath.row]["type"] as! String?
              cell.imageView?.image = UIImage(named:"\(cell.textLabel!.text!)")
           
              return cell
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           RsInit.initDB()
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){}
           let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants")

           guard let dishViewController =  segue.destination as? DishTableViewController else {return}
    
               let indexPaths = self.tableView?.indexPathsForSelectedRows
               let indexPath = indexPaths![0]
               let restaur = queryResult?[indexPath.row]["restaurant"] as! String?
               
               dishViewController.selRst =  restaur!
       }
}
