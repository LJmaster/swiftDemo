//
//  SecondViewController.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/5.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class SecondViewController: UIViewController,HttpProtocol {
    
    //计时器
    var timer:Timer?
    var playbackSlider : UISlider?
    var button: UIButton!
    //播放器相关
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    var playTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建并添加手机号输入框
        let phoneField = PhoneText(frame: CGRect(x:20, y:80, width:200, height:30))
        self.view.addSubview(phoneField)
        
        
        //创建一个ContactAdd类型的按钮
        let button:UIButton = UIButton(type:.custom)
        //设置按钮位置和大小
        button.frame = CGRect(x:0, y:0, width:80, height:44)
        //设置按钮文字
        button.setTitle("按钮", for:.normal)
        button.backgroundColor = UIColor.red
        self.navigationItem.titleView = button
        button.addTarget(self, action: #selector(buttonChange(button:)), for: UIControlEvents.touchUpInside)
        self.button = button
   
        //加载进度条
        view.backgroundColor = UIColor.white
        view.isMultipleTouchEnabled = true
        playbackSlider = UISlider()
        playbackSlider?.frame = CGRect(x: 20, y: 120, width: self.view.frame.size.width - 120, height: 30)
        view.addSubview(playbackSlider!)
        playbackSlider?.addTarget(self, action: #selector(changeSlider(snder:)), for: UIControlEvents.valueChanged)
        
        //时间
        playTime = UILabel()
        playTime.frame  = CGRect(x:self.view.frame.size.width - 90, y:120, width:80, height:30)
        view.addSubview(playTime)
        //初始化播放器
        let path = Bundle.main.path(forResource: "boy", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem!)
        //设置播放进度
        let duration : CMTime = (playerItem?.asset.duration)!
        let seconds:Float64  = CMTimeGetSeconds(duration)
        
        playbackSlider!.minimumValue = 0
        playbackSlider!.maximumValue = Float(seconds)
        playbackSlider!.isContinuous = false
        
        //播放过程中动态改变进度条值和时间标签
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1),
                                        queue: DispatchQueue.main) { (CMTime) -> Void in
                                            if self.player!.currentItem?.status == .readyToPlay && self.player?.rate != 0 {
                                                //更新进度条进度值
                                                let currentTime = CMTimeGetSeconds(self.player!.currentTime())
                                                self.playbackSlider!.value = Float(currentTime)
                                                
                                                //一个小算法，来实现00：00这种格式的播放时间
                                                let all:Int=Int(currentTime)
                                                let m:Int=all % 60
                                                let f:Int=Int(all/60)
                                                var time:String=""
                                                if f<10{
                                                    time="0\(f):"
                                                }else {
                                                    time="\(f)"
                                                }
                                                if m<10{
                                                    time+="0\(m)"
                                                }else {
                                                    time+="\(m)"
                                                }
                                                //更新播放时间
                                                self.playTime!.text=time
                                                //设置后台播放显示信息
                                                self.setInfoCenterCredentials(playbackState: 1)
                                            }
        }
        
        
        let imageView:UIImageView = UIImageView()
        imageView.frame = CGRect(x: 30, y: 180, width: self.view.frame.size.width - 60, height: self.view.frame.size.height - 240)
        imageView.image = UIImage(named:"liangbo")
        view.addSubview(imageView)
        
        
        // Do any additional setup after loading the view.
    }
    
    func didRecieveResults(results: Dictionary<String, AnyObject>) {
        print(results)
    }
    
    func creatVideoView() {
        
        
        
    }
    
    func queryAllMusic() {
        let everything: MPMediaQuery = MPMediaQuery()
        
        
        let itemFromGenericQuery:NSArray = everything.items! as NSArray
        
        print(itemFromGenericQuery)
        
        for i in 0...itemFromGenericQuery.count {
            
//           let song:MPMediaItem = itemFromGenericQuery[i] as! MPMediaItem
//           let songtitle = song.value(forProperty: MPMediaItemPropertyTitle)
//           let songArtist = song.value(forProperty: MPMediaItemPropertyArtist)
            
//            print("songtitle = \",songtitle ?? )
//            print("songArtist = /",songArtist ?? )

            
        }
        
        
        
    }
    
    func changeSlider(snder:UISlider) -> Void {
        let seconds: Int64 = Int64((playbackSlider?.value)!)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        //播放器定位到对应的位置
        player!.seek(to: targetTime)
        //如果当前时暂停状态，则自动播放
        if player!.rate == 0
        {
            player?.play()
            button.setTitle("暂停", for: .normal)
        }
        
    }
    func buttonChange(button:UIButton) {
        //根据rate属性判断当天是否在播放
        if player?.rate == 0 {
            player!.play()
            button.setTitle("暂停", for: .normal)
        } else {
            player!.pause()
            button.setTitle("播放", for: .normal)
            //后台播放显示信息进度停止
            setInfoCenterCredentials(playbackState: 0)
        }
    }
    //页面显示时添加歌曲播放结束通知监听
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        //告诉系统接受远程响应事件，并注册成为第一响应者
        UIApplication.shared.beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
    }
    
    //页面消失时取消歌曲播放结束通知监听
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
        //停止接受远程响应事件
        UIApplication.shared.endReceivingRemoteControlEvents()
        self.resignFirstResponder()
    }
    
    //歌曲播放完毕
    func finishedPlaying(myNotification:NSNotification) {
        print("播放完毕!")
        let stopedPlayerItem: AVPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero)
    }
    //是否能成为第一响应对象
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func setInfoCenterCredentials(playbackState: Int) {
        let mpic = MPNowPlayingInfoCenter.default()
        //封面
        let mysize = CGSize(width:400,height:400)
        let albumart = MPMediaItemArtwork(boundsSize:mysize) { sz in
            return UIImage(named:"liangbo")!
        }
        
        //获取进度
        let postion = Double(self.playbackSlider!.value)
        let duration = Double(self.playbackSlider!.maximumValue)
        
        mpic.nowPlayingInfo = [MPMediaItemPropertyTitle: "我是歌曲标题",
                               MPMediaItemPropertyArtist: "男孩",
                               MPMediaItemPropertyArtwork: albumart,
                               MPNowPlayingInfoPropertyElapsedPlaybackTime: postion,
                               MPMediaItemPropertyPlaybackDuration: duration,
                               MPNowPlayingInfoPropertyPlaybackRate: playbackState]
        
    }
    
    //后台操作
    override func remoteControlReceived(with event: UIEvent?) {
        guard let event = event else {
            print("no event\n")
            return
        }
        
        if event.type == UIEventType.remoteControl {
            switch event.subtype {
            case .remoteControlTogglePlayPause:
                print("暂停/播放")
            case .remoteControlPreviousTrack:
                print("上一首")
            case .remoteControlNextTrack:
                print("下一首")
            case .remoteControlPlay:
                print("播放")
                player!.play()
            case .remoteControlPause:
                print("暂停")
                player!.pause()
                //后台播放显示信息进度停止
                setInfoCenterCredentials(playbackState: 0)
            default:
                break
            }
        }
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
