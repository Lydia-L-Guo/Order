//
//  MenuInit.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import Foundation
import UIKit

class RsInit
{
    static func initDB()
    { //初始化数据库
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}  //open不成功
        let createSql = "CREATE TABLE IF NOT EXISTS restaurants('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restaurant' TEXT, 'type' TEXT, 'pic' BLOB);" //表不存在则创建
        if !sqlite.execNoneQuerySQL(sql: createSql){sqlite.closeDB();return} //增
        
        let rs0 = "INSERT OR REPLACE INTO restaurants(id, restaurant, type) VALUES('0','杏花眷村','🇨🇳中国菜');"
        let rs1 = "INSERT OR REPLACE INTO restaurants(id, restaurant, type) VALUES('1','翡冷翠的风','🇮🇹意大利菜');"
        let rs2 = "INSERT OR REPLACE INTO restaurants(id, restaurant, type) VALUES('2','Vivre Sa Vie','🇫🇷法国菜');"
       
        if !sqlite.execNoneQuerySQL(sql: rs0){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: rs1){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: rs2){sqlite.closeDB();return}
        
        self.SaveImage(id: 0, img: UIImage(named: "杏花眷村"))
        self.SaveImage(id: 1, img: UIImage(named: "翡冷翠的风"))
        self.SaveImage(id: 2, img: UIImage(named: "Vivre Sa Vie"))
     
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants")
               
        print(queryResult!)
        
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
    
    static func GetRs(restaurant:String) -> [[String : AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return[]}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants WHERE restaurant = '\(restaurant)'")
        sqlite.closeDB();
        return (queryResult!)
    }
    
    

}
