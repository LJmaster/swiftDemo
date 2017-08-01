//
//  MotionViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/7/11.
//  Copyright © 2017年 刘杰. All rights reserved.
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//

import UIKit
import CoreMotion

class MotionViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var textView: UITextView!
    let timeInterval:TimeInterval = 0.2
    ///
    var ball:UIImageView!
    var speedX:UIAccelerationValue = 0
    var speedY:UIAccelerationValue = 0
    
    var textView2: UITextView!
     let pedometer = CMPedometer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        textView = UITextView()
        textView.frame = CGRect(x: 0, y: 80, width: self.view.frame.size.width/2 - 10, height: 100)
        view.addSubview(textView)
        
        textView2 = UITextView()
        textView2.frame = CGRect(x: self.view.frame.size.width/2 + 10, y: 80, width: self.view.frame.size.width/2 - 10, height: 100)
        view.addSubview(textView2)
        
        //uibu
        let button:UIButton = UIButton(frame:CGRect(x: 0, y: 200, width: 60, height: 30))
        button.setTitle("调用qq", for: .normal)
        button.backgroundColor = UIColor.red
        view.addSubview(button)
        button.addTarget(self, action: #selector(openQQ), for: .touchUpInside)
        
        //
        ball = UIImageView(image:UIImage(named:"liangbo"))
        ball.frame = CGRect(x:0, y:0, width:50, height:50)
        ball.center = self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current
            motionManager.startAccelerometerUpdates(to: queue!, withHandler: {
                (accelerometerData, error) in
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY +=  accelerometerData!.acceleration.y
                var posX=self.ball.center.x + CGFloat(self.speedX)
                var posY=self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX<0 {
                    posX=0;
                    //碰到左边的边框后以0.4倍的速度反弹
                    self.speedX *= 0
                    
                }else if posX > self.view.bounds.size.width {
                    posX=self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    self.speedX *= 0
                }
                if posY<0 {
                    posY=0
                    //碰到上面的边框不反弹
                    self.speedY *= 0
                } else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    //碰到下面的边框以1.5倍的速度反弹
                    self.speedY *= 0
                }
                self.ball.center = CGPoint(x:posX, y:posY)
            })
        }
    
    
    
    
    
        startGyoUpdates()
        startPedometerUpdates()
    
        // Do any additional setup after loading the view.
    }
//获取陀螺仪的各种数据
    func startGyoUpdates() {
        guard motionManager.isGyroAvailable else {
            self.textView.text = "\n 当前设备不支持陀螺仪"
            return
        }
        //设置刷新时间
        self.motionManager.gyroUpdateInterval = self.timeInterval
        //开始获取数据
        let queue = OperationQueue.current
        
        self.motionManager.startGyroUpdates(to: queue!, withHandler: { (gyroData, error) in
            guard error == nil else {
                print(error!)
                return
            }
    
            if self.motionManager.isGyroActive{
            
                if let rotationRate = gyroData?.rotationRate {
                    var text = "---当前陀螺仪数据---\n"
                    text += "x: \(rotationRate.x)\n"
                    text += "y: \(rotationRate.y)\n"
                    text += "z: \(rotationRate.z)\n"
                    self.textView.text = text
                }
            
            }
        })
    }
    // 开始获取步数计数据
    func startPedometerUpdates() {
        //判断设备支持情况
        guard CMPedometer.isStepCountingAvailable() else {
            self.textView2.text = "\n当前设备不支持获取步数\n"
            return
        }
        
        //获取今天凌晨时间
        let cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let midnightOfToday = cal.date(from: comps)!
        
        //初始化并开始实时获取数据
        self.pedometer.startUpdates (from: midnightOfToday, withHandler: { pedometerData, error in
            //错误处理
            guard error == nil else {
                print(error!)
                return
            }
            
            //获取各个数据
            var text = "---今日运动数据---\n"
            if let numberOfSteps = pedometerData?.numberOfSteps {
                text += "步数: \(numberOfSteps)\n"
            }
            if let distance = pedometerData?.distance {
                text += "距离: \(distance)\n"
            }
            if let floorsAscended = pedometerData?.floorsAscended {
                text += "上楼: \(floorsAscended)\n"
            }
            if let floorsDescended = pedometerData?.floorsDescended {
                text += "下楼: \(floorsDescended)\n"
            }
            if let currentPace = pedometerData?.currentPace {
                text += "速度: \(currentPace)m/s\n"
            }
            if let currentCadence = pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n"
            }
            
            //在线程中更新文本框数据
            DispatchQueue.main.async{
                self.textView2.text = text
            }
        })
    }
    
    func openQQ() {
                UIApplication.shared.open(URL.init(string: "mqq://im/chat?chat_type=wpa&uin=1114781237&version=1&src_type=web")!)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
        self.textView2.resignFirstResponder()
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
