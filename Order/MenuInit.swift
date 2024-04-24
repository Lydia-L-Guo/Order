//
//  MenuInit.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import Foundation
import UIKit

class MenuInit
{
    static func initDB()
    { //初始化数据库       
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}  //open不成功
        let createSql = "CREATE TABLE IF NOT EXISTS dishes('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restaurant' TEXT, 'name' TEXT, 'price' INTEGER, 'num' INTEGER, 'detail' TEXT, 'pic' BLOB);" //表不存在则创建
        if !sqlite.execNoneQuerySQL(sql: createSql){sqlite.closeDB();return} //增
        //杏花眷村
        let dish0 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('0','杏花眷村','青梅小排','68','0', '上好小排搭配自制青梅酱，酸甜可口，清爽不油腻');"
        let dish1 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('1','杏花眷村','北京烤鸭','148','0', '油而不腻，香气宜人，表皮酥脆');"
        let dish2 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('2','杏花眷村','素什锦','35','0', '选用多种云南空运菌菇，自然鲜香');"
        let dish3 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('3','杏花眷村','蛋炒饭','15','0', '家常味道');"
        let dish4 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('4','杏花眷村','翡翠福饺','26','0', '造型如同翡翠白菜般精美');"
        //翡冷翠的风
        let dish5 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('5','翡冷翠的风','一口一个海洋梦','97', 0, '选用多种珍稀深海食材，分别调味，每一口都是惊喜');"
        let dish6 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('6','翡冷翠的风','冬天火炉边','225', 0, 'A5级别牛肉，三分熟度，入口即化；多种香料，回味无穷');"
        let dish7 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('7','翡冷翠的风','清脆秋天','64', 0, '内含黑松露脆片、松茸脆片、红薯片等，咔嚓咬下，宛若秋日漫步在落叶小径');"
        let dish8 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('8','翡冷翠的风','玻璃青苹果','58', 0, '晶莹糖壳包裹着柔滑轻盈的青苹果味慕斯');"
        let dish9 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('9','翡冷翠的风','卷卷芒果','54', 0, '新鲜芒果蛋糕卷，搭配高分子芒果空气慕斯');"
        //Vivre Sa Vie
        let dish10 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('10','Vivre Sa Vie','花舞曲','75','0','鲜美鸡高汤烩饭，搭配优质西班牙帕尔马火腿，摆盘精致优美');"
        let dish11 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('11','Vivre Sa Vie','深海花园','96','0','选用鲜甜深海蟹钳肉、脆嫩鱼子酱，配以蔬菜泥和温泉蛋');"
        let dish12 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('12','Vivre Sa Vie','童年三分熟','217','0','三分熟小牛排，甜椒调味');"
        let dish13 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('13','Vivre Sa Vie','仲夏夜彩虹冻','120','0','梦幻精美、色泽艳丽的法式肉冻');"
        let dish14 = "INSERT OR REPLACE INTO dishes(id, restaurant, name, price, num, detail) VALUES('14','Vivre Sa Vie','蝴蝶女王','56','0','玫瑰荔枝口味慕斯、云朵般口感烤蛋白、酥脆饼干底');"
       
        if !sqlite.execNoneQuerySQL(sql: dish0){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish1){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish2){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish3){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish4){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish5){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish6){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish7){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish8){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish9){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish10){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish11){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish12){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish13){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish14){sqlite.closeDB();return}
        
        self.SaveImage(id: 0, img: UIImage(named: "青梅小排"))
        self.SaveImage(id: 1, img: UIImage(named: "北京烤鸭"))
        self.SaveImage(id: 2, img: UIImage(named: "素什锦"))
        self.SaveImage(id: 3, img: UIImage(named: "蛋炒饭"))
        self.SaveImage(id: 4, img: UIImage(named: "翡翠福饺"))
        
        self.SaveImage(id: 5, img: UIImage(named: "一口一个海洋梦"))
        self.SaveImage(id: 6, img: UIImage(named: "冬天火炉边"))
        self.SaveImage(id: 7, img: UIImage(named: "清脆秋天"))
        self.SaveImage(id: 8, img: UIImage(named: "玻璃青苹果"))
        self.SaveImage(id: 9, img: UIImage(named: "卷卷芒果"))
        
        self.SaveImage(id: 10, img: UIImage(named: "花舞曲"))
        self.SaveImage(id: 11, img: UIImage(named: "深海花园"))
        self.SaveImage(id: 12, img: UIImage(named: "童年三分熟"))
        self.SaveImage(id: 13, img: UIImage(named: "仲夏夜彩虹冻"))
        self.SaveImage(id: 14, img: UIImage(named: "蝴蝶女王"))
     
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes")
       // print(queryResult!)
        sqlite.closeDB()
    }
  

    
    static func SaveImage(id:Int, img:UIImage?){
           if img == nil{return}
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){return}
           let sql = "UPDATE dishes SET pic = ? WHERE id = \(id)"
           let data = img!.jpegData(compressionQuality:1.0) as NSData?
           sqlite.execSaveBlob(sql:sql, blob:data!)
           sqlite.closeDB()
           return
       }

    static func LoadImage(name:String) -> UIImage{
           let sqlite = SQLiteManager.sharedInstance
           if !sqlite.openDB(){return UIImage(named:"nopic")!}
           
           let sql = "SELECT pic FROM dishes WHERE name = '\(name)'"
           let data = sqlite.execLoadBlob(sql:sql)
           sqlite.closeDB()
           
           if data != nil{
               return UIImage(data:data!)!
           }
           else{
               return UIImage(named:"nopic")!
           }
       }
    
    static func GetDish(name:String) -> [[String : AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return[]}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE name = '\(name)'")
      
        print("queryResult")
        print(queryResult!)

        sqlite.closeDB();
        return (queryResult!)
    }
    
    static func GetDishFRst(restaurant:String) -> [[String : AnyObject]]{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return[]}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE restaurant = '\(restaurant)'")
      
        print("queryResult")
        print(queryResult!)

        sqlite.closeDB();
        return (queryResult!)
    }
    
    static func GetDishInfoStr(name:String, colume:String) -> String{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return "f"}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE name = '\(name)'")![0]

        let result = (queryResult["\(colume)"] as! String?)!
        //(detail["name"] as! String?)
        sqlite.closeDB();
        return (result)
    }
    
    static func GetDishInfoInt(name:String, colume:String) -> Int{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return 1}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE name = '\(name)'")![0]

        let result = queryResult["\(colume)"] as? Int
        //(detail["name"] as! String?)
        sqlite.closeDB();
        return (result!)
    }
    
    static func GetPriceSum() -> Int{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return 1}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE num != '0'")!
        var sum:Int = 0
        for index in 0 ..< (queryResult.count){
            let price = queryResult[index]["price"] as! Int
            let num = queryResult[index]["num"] as! Int
            sum = price * num + sum
        }
        sqlite.closeDB();
        return (sum)
    }
}
