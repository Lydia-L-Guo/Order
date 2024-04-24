//
//  SQLiteManager.swift
//  P0902
//
//  Created by Linda Guo on 2020/4/15.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import Foundation

class SQLiteManager:NSObject
{
    private var dbPath:String!
    private var database:OpaquePointer? = nil //指针，指向结构体
    
    static var sharedInstance:SQLiteManager{ //单例变量
        return SQLiteManager() //只读
    }
    
    override init(){
        super.init()
        
        let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        dbPath = dirpath.appendingPathComponent("app.sqlite").path
        print(dbPath!)
    }
    //open database
    func openDB() -> Bool{
        let result = sqlite3_open(dbPath, &database) //文件不存在，自动创建
        if result != SQLITE_OK{
            print("fail to open database")
            return false
        }
        return true
    }
    //close database
    func closeDB(){
        sqlite3_close(database)
    }
    //execute the statement:creat, insert, update, delete
    func execNoneQuerySQL(sql:String) -> Bool{
        var errMsg:UnsafeMutablePointer<Int8>? = nil //可修改
        let cSql = sql.cString(using: String.Encoding.utf8)!
        /*
         参数
         1.db：OpaquePointer! 一打开数据库句柄 数据库指针
         2.sql:执行的aql
         3.callback:回首函数
         4.自定义指针，会传递到回调函数内
         5.errmsg:错误信息
         */
        if sqlite3_exec(database, cSql, nil, nil, &errMsg) == SQLITE_OK{ //成功
            return true
        }
        let msg = String.init(cString: errMsg!) //不成功
        print(msg)
        return false
    }
    //execute the statement:select
    func execQuerySQL(sql:String) -> [[String:AnyObject]]?{
        let cSql = sql.cString(using: String.Encoding.utf8)! //sql语句转换成tuf8
        var statement:OpaquePointer? = nil
        /*
         参数
         1.db:已打开数据库句柄
           &statement结构指针
         2.zSql:要执行的SQL语句
         3.nByte:以字节为单位的sql语句长度，-1自动计算
         4.ppStmt:语句句柄，据此获取查询结果 u需要调用sqlite3_finalize 释放
         5，_pzTail:未使用的指针地址，通常传入nil
         */
        if sqlite3_prepare_v2(database, cSql, -1, &statement, nil) != SQLITE_OK{ //失败
            sqlite3_finalize(statement) //释放内存
            print("执行\(sql)错误\n")
            let errmsg = sqlite3_errmsg(database)
            if errmsg != nil{
                print(errmsg!)
            }
            
            return nil
        }
        var rows = [[String:AnyObject]]()  //成功
        while sqlite3_step(statement) == SQLITE_ROW{ //取一行
            rows.append(record(stmt:statement!)) //转一行:record
        }
        sqlite3_finalize(statement) //释放内存
        return rows
    }
    private func record(stmt:OpaquePointer) -> [String:AnyObject]{
        var row = [String:AnyObject]()
        //遍历所有列，获取每一列的消息
        for col in 0 ..< sqlite3_column_count(stmt){ //取多少个列
            let cName = sqlite3_column_name(stmt, col)
            let name = String(cString: cName!, encoding: String.Encoding.utf8)
            var value:AnyObject?
            
            switch (sqlite3_column_type(stmt,col)) {
            case SQLITE_FLOAT:
                value = sqlite3_column_double(stmt, col) as AnyObject //浮点
            case SQLITE_INTEGER:
                value = Int(sqlite3_column_int(stmt, col)) as AnyObject //整形
            case SQLITE3_TEXT:
                let cText = sqlite3_column_text(stmt, col) //字符串
                value = String.init(cString: cText!) as AnyObject
            case SQLITE_NULL:
                value = NSNull()
            default:
                print("不支持的数据类型")
            }
            row[name!] = value ?? NSNull()
            
        }
        return row
    }


func execSaveBlob(sql:String, blob:NSData){
    let csql = sql.cString(using: .utf8)
    var statement:OpaquePointer? = nil
    if sqlite3_prepare_v2(database,csql,-1,&statement,nil) != SQLITE_OK{
        sqlite3_finalize(statement)
        print("Prepare error:\(sql)")
        return
    }
    let paramsCnt = sqlite3_bind_parameter_count(statement)
    if paramsCnt != 1{
        print("need only 1 parameter:\(sql)")
        sqlite3_finalize(statement)
        return
    }


    
    if sqlite3_bind_blob(statement,1, blob.bytes,Int32(blob.length),nil) != SQLITE_OK{
    sqlite3_finalize(statement)
    print("bind blob error:\(sql)")
    return
}

    let rslt = sqlite3_step(statement)
    if rslt != SQLITE_OK && rslt != SQLITE_DONE{
    print("excute blob error:\(sql)")
    sqlite3_finalize(statement)
    return
    }
    sqlite3_finalize(statement)
    return
    }
    
    func execLoadBlob(sql:String) -> Data?{
        let csql = sql.cString(using: String.Encoding.utf8)!
        var statement:OpaquePointer? = nil
        if sqlite3_prepare(database, csql, -1, &statement, nil) != SQLITE_OK{
            print("执行\(sql)错误\n")
            sqlite3_finalize(statement)
            if let errmsg = sqlite3_errmsg(database){
                print(errmsg)
            }
            return nil
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            if let dataBlob = sqlite3_column_blob(statement, 0){
                let dataBlobLength = sqlite3_column_bytes(statement, 0)
                let data = Data(bytes: dataBlob, count: Int(dataBlobLength))
                return data
            }
        }
        sqlite3_finalize(statement)
        return nil
    }
}

