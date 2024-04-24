//
//  ConfirmViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    
    @IBAction func returnMainBtnPressed(_ sender: Any) {
        let mainBoard:UIStoryboard! = UIStoryboard(name:"Main", bundle: nil)
        let VC = mainBoard!.instantiateViewController(withIdentifier:"mainVC")
        UIApplication.shared.windows[0].rootViewController = VC
    }
    
    
    

    @IBAction func returnOrderBtnPressed(_ sender: Any) {
       let mainBoard:UIStoryboard! = UIStoryboard(name:"Main", bundle: nil)
        let orderVC = mainBoard!.instantiateViewController(withIdentifier:"navOrder")
        UIApplication.shared.windows[0].rootViewController = orderVC
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
