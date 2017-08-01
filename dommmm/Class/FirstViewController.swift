//
//  FirstViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/2.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIWebViewDelegate, UITextFieldDelegate {

    var btngo:UIButton!
    var webview:UIWebView!
    var txturl:UITextField!
    
    var loadindicator:UIActivityIndicatorView!
    //进度条控件
    var progBar:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        //返回按钮
        let bt = UIButton()
        bt.frame = CGRect(x: 10, y: 20, width: 50, height: 40)
        bt.setTitle("oo", for: UIControlState.normal)
        bt.backgroundColor = .red
        view.addSubview(bt)
        bt.addTarget(self, action: #selector(actionbuttn), for: UIControlEvents.touchUpInside)
        
        //网站输入框
        txturl = UITextField()
        txturl.frame = CGRect(x: 70, y: 20.0, width: self.view.frame.size.width - 60 - 20 - 60, height: 32.0)
        txturl.placeholder = "输入网址"
        self.view.addSubview(txturl);
        txturl.delegate = self
        
        //加载的button
        btngo = UIButton()
        btngo.frame = CGRect(x: self.view.frame.size.width - 60 , y: 20, width: 50 , height: 40)
        btngo.setTitle("go", for: UIControlState.normal)
        btngo.backgroundColor = .red
        view.addSubview(btngo)
        btngo.addTarget(self, action: #selector(loadUrl), for: UIControlEvents.touchUpInside)

        //网页
        webview = UIWebView()
        webview.frame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64 - 49)
        webview.delegate = self
        let urlobj = URL(string:"https://www.baidu.com")
        let request = URLRequest(url:urlobj!)
        webview.loadRequest(request);
        view.addSubview(webview)
        
        //创建进度工具条
        progBar = UIProgressView(progressViewStyle:UIProgressViewStyle.bar)
        // 设置UIProgressView的大小
        progBar.frame = CGRect(x: 0 , y: 64 , width: self.view.frame.size.width, height: 20)
        progBar.backgroundColor = UIColor.red
        // 设置该进度条的初始进度为0
        progBar.progress = 0
        view.addSubview(progBar)
        view.bringSubview(toFront: progBar)
        //底部导航栏
        setupBrowserToolbar()
        // Do any additional setup after loading the view.
    }
    //底部菜单栏
    func setupBrowserToolbar(){
        //创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar =  UIView(frame:CGRect(x: 0, y: self.view.frame.size.height - 49, width: self.view.frame.size.width, height: 49))
        browserToolbar.backgroundColor = UIColor.lightGray
        // 将工具条添加到当前应用的界面中
        self.view.addSubview(browserToolbar)
        for i in 0...4 {
            
            let w:CGFloat = self.view.frame.size.width / 4
            let h:CGFloat = 49
            
            let button:UIButton = UIButton(type:.custom)
            //设置按钮位置和大小
            button.frame = CGRect(x: w  * CGFloat(Float(i)), y:0, width:w, height:h)
            //设置按钮文字
            if i == 0 {
               button.setTitle("前进", for:.normal)
            }
            if i == 1 {
                button.setTitle("后退", for:.normal)
            }
            if i == 2 {
                button.setTitle("刷新", for:.normal)
            }
            if i == 3 {
                button.setTitle("关闭", for:.normal)
            }
            button.tag = i
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(toolButtonClick(button:)), for: UIControlEvents.touchUpInside)
            browserToolbar.addSubview(button)
        }
    }
    //点击返回的按钮
    func actionbuttn() {
        self.dismiss(animated: true, completion: nil)
    }
    //加载 go 按钮
    func loadUrl(){
        let urlobj = URL(string:"https://juejin.im/timeline")
         progBar.setProgress(0, animated: false)
        let request = URLRequest(url:urlobj!)
        webview.loadRequest(request);
    }
    //底部循环按钮点击方法
    func toolButtonClick(button:UIButton) {
        print(button.tag)
        switch button.tag {
        case 0:
            webview.goForward()
            break
        case 1:
            webview.goBack()
            break
        case 2:
            webview.reload()
            break
        case 3:
            webview.stopLoading()
            break
     
        default:
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        progBar.isHidden = false
       
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progBar.setProgress(1, animated: true)
//        progBar.isHidden = true
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progBar.isHidden = true
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
