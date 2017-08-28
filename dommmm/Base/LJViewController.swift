//
//  LJViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/8/25.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit

class LJViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         取消自动缩进,当导航栏遇到`scrollView`的时候,一般都要设置这个属性
         默认是`true`,会使`scrollView`向下移动`20`个点
         */
        automaticallyAdjustsScrollViewInsets = false
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
