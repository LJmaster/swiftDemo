
//
//  ScrollViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/7.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit


class ScrollViewController: UIViewController,UIScrollViewDelegate {
    
    
    var scrollView : UIScrollView!
    var pageController : UIPageControl!
    var imageArray = ["countdownbg1","countdownbg2","countdownbg3","countdownbg4","countdownbg7","countdownbg8",]
    var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        //        scrollView = UIScrollView(frame:CGRect(x:100, y:0, width:WIDTH, height:160))
        //        scrollView.delegate = self
        //        scrollView.isPagingEnabled = true
        //        scrollView.scrollsToTop = false
        //        scrollView.showsHorizontalScrollIndicator = false
        //        scrollView.backgroundColor = UIColor.clear
        //        scrollView.bounces = false
        //        scrollView.clipsToBounds = false
        //        lView.addSubview(scrollView)
        //
        //        for i in 0...count {
        //            let imageView = UIImageView(frame:CGRect(x:CGFloat(Float(i)) * WIDTH + CGFloat(Float(spacre)), y:scrollView.frame.size.height/2 - 10, width:WIDTH - 2 * CGFloat(Float(spacre)), height:140))
        //            imageView.backgroundColor = UIColor.yellow
        //            scrollView.addSubview(imageView)
        //        }
        //       scrollView.contentSize = CGSize(width:WIDTH * CGFloat(Float(count)), height:160)
        //       scrollView.setContentOffset(CGPoint(x:WIDTH,y:0), animated: false)
        
        //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        let offset_x:CGFloat = scrollView.contentOffset.x
        //
        //
        //        if (fmod(offset_x, WIDTH) != 0) {
        //
        //            if (offset_x / WIDTH > 0 && offset_x / WIDTH < 1 && offset_x < WIDTH / 2) {
        //
        //                scrollView.contentOffset = CGPoint(x:(CGFloat(Float(count - 2))) * WIDTH + offset_x,y:0);
        //            }else if (offset_x / WIDTH < CGFloat(Float(count - 1)) && offset_x / WIDTH > CGFloat(Float(count - 2)) && offset_x - WIDTH * CGFloat(Float(count - 2)) > WIDTH / 2){
        //
        //                scrollView.contentOffset = CGPoint(x:offset_x - (WIDTH * CGFloat(Float(count - 2))), y:0);
        //            }
        //        }
        //    }
        //
        //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //   
        //        let offset_x:CGFloat = scrollView.contentOffset.x
        //        
        //        let hhh = offset_x / WIDTH
        //        
        //        print("这是变化的第几个 + \(hhh)")
        //        
        //    }
        
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "图片",style: UIBarButtonItemStyle.plain, target: self, action:#selector(selectImage))
        
        scrollView = UIScrollView(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height - 49))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        view.addSubview(scrollView)
        for i in 0...imageArray.count - 1 {
            let w = self.view.frame.size.width
            print(CGFloat(Float(i)) * w)
            let imageView = UIImageView(frame:CGRect(x:CGFloat(Float(i)) * w, y:0, width:w, height:scrollView.frame.size.height))
            imageView.image = UIImage(named:imageArray[i])
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width:CGFloat(self.view.bounds.width) * CGFloat(imageArray.count), height:self.view.bounds.height - 49)
        //设置页控件属性
        pageController = UIPageControl(frame:CGRect(x:self.view.frame.size.width / 2 - 50, y:self.view.frame.size.height - 60 - 49, width:100, height:40))
        pageController.backgroundColor = UIColor.clear
        pageController.currentPage = 0;
        pageController.numberOfPages = imageArray.count
        pageController.currentPageIndicatorTintColor = UIColor.red
        //设置页控件点击事件
        pageController.addTarget(self, action: #selector(pageChanged(sender:)),
                                 for: UIControlEvents.valueChanged)
        view.addSubview(pageController)
        
        let  timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.timerManager), userInfo: nil, repeats: true)
        //这句话实现多线程，如果你的ScrollView是作为TableView的headerView的话，在拖动tableView的时候让轮播图仍然能轮播就需要用到这句话
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        // Do any additional setup after loading the view.
    }
    
    func selectImage(){
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //设置pageController的当前页
        pageController.currentPage = Int(page)
        //设置
        cnt = Int(page)
    }
    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        scrollView.scrollRectToVisible(frame, animated:true)
        
      
    }
    //创建定时器管理者
    func timerManager() {
        //设置偏移量
        scrollView.contentOffset = CGPoint(x:scrollView.contentOffset.x + CGFloat(self.view.bounds.width), y:0)
        //当偏移量达到最后一张的时候，让偏移量置零
        if scrollView.contentOffset.x == CGFloat(self.view.bounds.width) * CGFloat(imageArray.count) {
            scrollView.contentOffset = CGPoint(x:0, y:0)
        }
        cnt += 1
        pageController.currentPage = cnt % imageArray.count
    }
    
    //自动播放时，调用该方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        cnt += 1
        pageController.currentPage = cnt % imageArray.count
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
