//
//  MenuInit.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import Foundation
import UIKit

class OrdersInit
{
    static func initDB()
    { //初始化数据库
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}  //open不成功
        let createSql = "CREATE TABLE IF NOT EXISTS orders('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restaurant' TEXT, 'name' TEXT, 'price' INTEGER, 'num' INTEGER, 'pic' BLOB);" //表不存在则创建
        if !sqlite.execNoneQuerySQL(sql: createSql){sqlite.closeDB();return} //增
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM oders")
        //print(queryResult!)
        sqlite.closeDB()
    }
  

    
    static func SaveImage(id:Int, img:UIImage?){
           if img == nil{return}
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){return}
           let sql = "UPDATE restaurants SET pic = ? WHERE id = \(id)"
           let data = img!.jpegData(compressionQuality:1.0) as NSData?
           sqlite.execSaveBlob(sql:sql, blob:data!)
           sqlite.closeDB()
           return
       }

    static func LoadImage(restaurant:String) -> UIImage{
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){return UIImage(named:"nopic")!}
           let sql = "SELECT pic FROM restaurants WHERE restaurant = \(restaurant)"
           let data = sqlite.execLoadBlob(sql:sql)
           sqlite.closeDB()
           if data != nil{
               return UIImage(data:data!)!
           }
           else{
               return UIImage(named:"nopic")!
           }
       }
    
    static func GetOrder(restaurant:String) -> [[String : AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return[]}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants WHERE restaurant = '\(restaurant)'")
        sqlite.closeDB();
        return (queryResult!)
    }

}
