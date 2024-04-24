//
//  LoginViewController.swift
//  Order
//
//  Created by Linda Guo on 2020/5/10.
//  Copyright © 2020 Guo Yuezhu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginPressed(_ sender: UIButton) {
        let mainBoard:UIStoryboard! = UIStoryboard(name:"Main", bundle: nil)
        let VC = mainBoard!.instantiateViewController(withIdentifier:"mainVC")
        UIApplication.shared.windows[0].rootViewController = VC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        RsInit.initDB()
        MenuInit.initDB()

        // Do any additional setup after loading the view.
    }
    
    /* let userloginVC = UserLoginViewControllor()
     
      //UIApplication.shared.windows[0].rootViewController = userloginVC
      present(userloginVC,animated: true,completion: nil)*/
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
