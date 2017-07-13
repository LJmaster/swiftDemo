//
//  ViewController.swift
//  dommmm
//
//  Created by 22 on 2017/6/1.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class Account{
    var amount : Double = 0.0
    var owner : String = ""
    
    class var staticPop: Double {
        return 0.668
    }
    class func interestBy(amount : Double) -> Double {
        return 0.8886*amount
    }
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpProtocol {
    var a : UIView!
    var b : UIView!
    var c : UIView!
    var bt : UIButton!
    var namestr:NSString = ""
    
    var baby = ["baba","annan","jaja"]
    var str:String = ""
    var tableview = UITableView()
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    //数据的get  ,set
    class Calcutor{
        
        var a:Int = 1;
        var b:Int = 1;
        var sum:Int{
            get{
                return a+b
                
            }
            set(val){
                b = val - a
            }
        }
    }
    
    //获取网络数据的类
    var eHttp = HttpController()
    //接收频道列表的数组
    var channelData:[AnyObject] = Array()
    class addCalcutor: Calcutor {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //取消
        let sttere  = "  sjsjsjjsj   "
        let sttere1 = sttere.trimmingCharacters(in: .whitespaces)
        
        
        
        
        print("清除空格以后的：\(sttere1)")
        //修改标题
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = UIColor(red:98/255,green:104/255,blue: 24/255,alpha:1)
        self.navigationController?.title = "这是一个试图根据地，😆"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        a = UIView()
        a.frame = CGRect(x: 0, y: 50, width: 50, height: 50)
        view.addSubview(a)
        a.backgroundColor = .red
        b = UIView()
        b.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        view.addSubview(b)
        b.backgroundColor = .yellow
        c = UIView()
        c.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        b.addSubview(c)
        c.backgroundColor = .blue
        let gesture = UITapGestureRecognizer(target: self, action: #selector(action(_:)))
        b.addGestureRecognizer(gesture)
        bt = UIButton()
        bt.frame = CGRect(x: 100, y: 150, width: 50, height: 50)
        bt.setTitle("oo", for: UIControlState.normal)
        bt.backgroundColor = .yellow
        view.addSubview(bt)
        bt.addTarget(self, action: #selector(actionbutton(_:)), for: UIControlEvents.touchUpInside)
        
                //创建tableview
        tableview = UITableView()
        tableview.frame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64)
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        //修改文字颜色
        header.stateLabel.textColor = UIColor.red
        header.lastUpdatedTimeLabel.textColor = UIColor.blue
        header.setRefreshingTarget(self, refreshingAction: #selector(ViewController.headerRefresh))
        tableview.mj_header = header
        
        
        UserDefaults.standard.setValue("hahah", forKey: "object")
        let setringValue = UserDefaults.standard.object(forKey: "object")
        print(setringValue as! NSString)
        
        if str.isEmpty {
            print("空")
        }
        
        let user = User()
        print("222----\(user.name) \(user.age) \(user.six)")
        let dict = ["name":"haha","age":"22","sex":"man"]
        user.setValuesForKeys(dict)
    
        //归档与反归档
//        //对象数据的本地存储
//        let userdata = NSKeyedArchiver.archivedData(withRootObject: user)
//        UserDefaults.standard.set(userdata, forKey: "user")
//        
//        
//        let userdata2 = UserDefaults.standard.object(forKey: "user")
//        
//        let user2 = NSKeyedUnarchiver.unarchiveObject(with: userdata2! as! Data)
////        print(user2.name)
//        
        
        let f = 123.45688865
        let s:String = "\(f)"
        print("转为字符串 ---\(s)")

        let s1 = String(format: "%.2f",f)
        print("转为字符串 保留两位小数 ---\(s1)")
        let cal = Calcutor()
        print(cal.sum)
        
        //文件
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let path = urlForDocument[0] as URL
        print(path)
        
//        判断文件或文件夹是否存在
        let filepATH:String = NSHomeDirectory() + "/Documents/hangge.txt"
        let exist = manager.fileExists(atPath: filepATH)
        print(exist)
        
        //创建文件
        //withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
        let myFile:String = NSHomeDirectory() + "/Documents/myFolder/Files"
        try! manager.createDirectory(atPath: myFile, withIntermediateDirectories: true, attributes: nil)
        
        //写入文件
        let filePath:String = NSHomeDirectory() + "/Documents/hangge.txt"
        let info = "欢迎你成为第一个书写的人"
        try! info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        
          //保存图片
        let imageFile:String = NSHomeDirectory() + "/Documents/image.png"
        let image = UIImage(named: "1.png")
        //图片转为二进制
        let data:Data = UIImagePNGRepresentation(image!)!
        try? data.write(to:URL(fileURLWithPath: imageFile))
        
        
        
        
        
        //方法1
        let manager2 = FileManager.default
        let urlsForDocDirectory = manager2.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent("hangge.txt")
        
        
        let readHandler = try! FileHandle(forReadingFrom:file)
        let data2 = readHandler.readDataToEndOfFile()
        let readString = String(data: data2, encoding: String.Encoding.utf8)
        print("文件内容: \(String(describing: readString))")
        
        
        
        
        //为HttpController实例设置代理
        eHttp.delegate=self
        //获取频道数据
        eHttp.onSearch(urlll: "https://www.douban.com/j/app/radio/channels")
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //顶部下拉刷新
    func headerRefresh(){
        print("下拉刷新.")
        sleep(2)
        //重现生成数据
//        refreshItemData()
        //重现加载表格数据
        tableview.reloadData()
        //结束刷新
        tableview.mj_header.endRefreshing()
    }
    
    //image 画圆
    func toCircle(image:UIImage) -> UIImage {
        let shotest = min(image.size.width, image.size.height)
        
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        
        //开始图片处理上下文（）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        image.draw(in: CGRect(x: (shotest-image.size.width)/2,
                             y: (shotest-image.size.height)/2,
                             width: image.size.width,
                             height: image.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    //如图片下载
    func downloadImahe() -> Void {
        let imageUrl = "https://hangge.com/blog/images/logo.png"
        //图片地址转为data  类型
        let data = try! Data(contentsOf: URL(string: imageUrl)!)
        //图片加载
         let image:UIImage =  UIImage(data: data)!
        print(image)
    }
    //实现HttpProtocol协议的方法
    func didRecieveResults(results:Dictionary<String, AnyObject>){
        if (results["channels"] != nil){
            //如果channels关键字的value不为nil，获取的就是频道数据
            self.channelData = results["channels"] as! Array
            print(self.channelData[0]["name"] as! String) //私人兆赫
        }
    }
    func action(_ sender:UIButton!){
        c.backgroundColor = (c.backgroundColor == .green) ?  .blue :  .green
    }
    func actionbutton(_ sender:UIButton!){
        a.backgroundColor = .black
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initidentifier = "cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: initidentifier)
//        let cell = tableview.dequeueReusableCell(withIdentifier: "Swiftcell", for: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        if indexPath.row == 0 {
            let label = UILabel(frame:CGRect(x:0, y:0, width:cell.frame.size.width, height:cell.frame.size.height))
            label.text = "hangge.com"
            cell.addSubview(label);
        }
        if indexPath.row == 1 {
            //创建一个ContactAdd类型的按钮
            let button:UIButton = UIButton(type:.contactAdd)
            //设置按钮位置和大小
            button.frame = CGRect(x:20, y:0, width:80, height:44)
            //设置按钮文字
            button.setTitle("按钮", for:.normal)
            button.backgroundColor = UIColor.red
            cell.addSubview(button)
            button.addTarget(self, action: #selector(touchVC(button:)), for: UIControlEvents.touchUpInside)
        }
        if indexPath.row == 2 {
            let textField = UITextField(frame:CGRect(x:20, y:0, width:cell.frame.size.width, height:cell.frame.size.height))
            //设置边框样式为圆角矩形
            textField.borderStyle = UITextBorderStyle.roundedRect
            textField.placeholder = "我猜你就是想输入一些东西"
            cell.addSubview(textField)
        }
        if indexPath.row == 3 {
            let swith = UISwitch(frame:CGRect(x:100, y:0, width:90, height:cell.frame.size.height))
            cell.addSubview(swith)
        }
        if indexPath.row == 4 {
            //选项除了文字还可以是图片
            let items = ["选项一", "选项二"]
            let segmented = UISegmentedControl(items:items)
            segmented.frame = CGRect(x:100, y:0, width:160, height:cell.frame.size.height)
            segmented.selectedSegmentIndex = 1 //默认选中第二项
            segmented.addTarget(self, action: #selector(ViewController.segmentDidchange(_:)),
                                for: .valueChanged)  //添加值改变监听
            cell.addSubview(segmented)
        }
        if indexPath.row == 5 {
            let imageView = UIImageView()
            imageView.frame = CGRect(x:80, y:00, width:80, height:80)
//            DispatchQueue.global(qos: .default).async {
//                let imageUrl = "https://hangge.com/blog/images/logo.png"
//                let url = URL(string: imageUrl)!
//                let data = Data.init(contentsOf: url, options: nil)
//                let image = UIImage(data:data)!
//                DispatchQueue.main.async {
//                    imageView.image = image
//                }
//            }
            
            cell.addSubview(imageView)
        }
        if indexPath.row == 6 {
            let progress = UIProgressView(progressViewStyle: .default)
            progress.center = cell.center
            progress.setProgress(0.8, animated: true)
            progress.progressTintColor = UIColor.green
            progress.trackTintColor = UIColor.red
            cell.addSubview(progress)
        }
        if indexPath.row == 7 {
            let slider = UISlider(frame:CGRect(x: 0,y: 0,width: 300,height: 44))
            slider.center = cell.center
            slider.minimumValue = 0
            slider.maximumValue = 5
            slider.setValue(2, animated: true)
            slider.addTarget(self, action: #selector(sliderDrdchange(slider:)), for: UIControlEvents.valueChanged)
            cell.addSubview(slider)
            
            
        }
    return cell
    
    }
    func touchVC(button:UIButton){
        self.present(SecondViewController(), animated: true, completion: nil)
    }
    func sliderDrdchange(slider:UISlider){
         print(slider.value)
    }
    func segmentDidchange(_ segmented:UISegmentedControl)  {
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        if indexPath.row == 0 {
//            let firstVC = FirstViewController()
//            self.present(firstVC, animated: true, completion: nil)
//        }else{
//        
//        let alertController = UIAlertController(title: "提示!",
//                                                message: "你选中了【\(indexPath.row)】",preferredStyle: .alert)
//       let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

