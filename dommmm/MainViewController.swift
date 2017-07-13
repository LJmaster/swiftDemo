//
//  MainViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/6.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewMain = ViewController()
        viewMain.title = "Home"
        let viewSetting = SecondViewController()
        viewSetting.title = "User"
        let scrollview = ScrollViewController()
        scrollview.title = "就是在旋转跳越"
        let motionVC = MotionViewController()
        motionVC.title = "设备各种数据"
        
        
        //分别声明两个视图控制器
        let main = UINavigationController(rootViewController:viewMain)
        main.tabBarItem.image = UIImage(named:"home-2")
        main.tabBarItem.selectedImage = UIImage(named:"home")
        //定义tab按钮添加个badge小红点值
        main.tabBarItem.badgeValue = "99"
        
        let setting = UINavigationController(rootViewController:viewSetting)
        setting.tabBarItem.image = UIImage(named:"user-2")
        setting.tabBarItem.selectedImage = UIImage(named:"user")
        
//        let scroll = UINavigationController(rootViewController:scrollview)
        

 
        
        
        self.viewControllers = [main,setting,scrollview,motionVC]
        
        //默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
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
