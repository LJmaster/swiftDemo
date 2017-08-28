//
//  MainViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/6.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    /// 定时器
    fileprivate var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTimer()
        
        let viewMain = ViewController()
        viewMain.title = "Home"
        let viewSetting = SecondViewController()
        viewSetting.title = "一个播放器"
        let scrollview = ScrollViewController()
        scrollview.title = "轮播图"
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
}
/*
extension 类似于 OC 中的分类,在 Swift 中还可以用来切分代码块
可以把功能相近的函数,放在一个extension中
 扩展是给已经存在的类（class），结构体（structure），枚举类型（enumeration）和协议（protocol）增加新的功能。类似Objective-C中的Category，不同的是，Extension没有名字。扩展可以做以下事情：
 
 增加计算实例属性和计算类型属性
 定义实例方法和类型方法
 提供新的初始化器
 定义下标
 定义和使用新的内置类型
 让一个存在的类型服从一个协议
 注：扩展可以增加新的功能，但是不能覆盖已有的功能

*/
// MARK: - 后台检测的方法
extension MainViewController {
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    /// 定时器触发方法
    @objc fileprivate func updateTimer() {
        
        print("检查到了有些东西在变化")
        }
    
}
extension MainViewController {
    /// 计算型属性,不占用存储空间
    fileprivate var isNewVersion: Bool {
        
        // 获取当前版本号
        let currentVersion1 = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        let currentVersion:Int = Int(currentVersion1)!
        
        let savedVersion = UserDefaults.standard.integer(forKey: "savedVersion")
        
        UserDefaults.standard.set(currentVersion1, forKey: "savedVersion")
        
        // 比较两个版本是否相同
        //        return currentVersion != savedVersion
        return currentVersion == savedVersion
    }
}
