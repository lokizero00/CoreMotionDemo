//
//  SecondViewController.swift
//  CoreMotionDemo
//
//  Created by lokizero00 on 2017/11/30.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var orientationLabel:UILabel!
    @IBOutlet weak var startButton:UIButton!
    @IBOutlet weak var stopButton:UIButton!
    
    @IBOutlet weak var motionBeganCountLabel:UILabel!
    @IBOutlet weak var motionEndedCountLabel:UILabel!
    @IBOutlet weak var motionCancelledCountLabel:UILabel!
    
    var motionBeganCount=0;
    var motionEndedCount=0;
    var motionCancelledCount=0;

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title="判断设备方向与摇晃"
        self.view.backgroundColor=UIColor.white
        initNotificationListener()
        startButton.addTarget(self, action: #selector(self.startListen), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(self.stopListen), for: .touchUpInside)
    }
    
    @objc func startListen(){
        //感知设备方向--开启监听设备方向
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    
    @objc func stopListen(){
        //关闭设备监听，关闭后，界面将无法随方向改变
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    func initNotificationListener(){
        //添加通知，监听设备方向改变
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedRotation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func receivedRotation(){
        let device=UIDevice.current
        
        switch device.orientation {
        case .unknown:
            orientationLabel.text="Unknown"
        case .portrait:
            orientationLabel.text="Portrait"
        case .portraitUpsideDown:
            orientationLabel.text="PortraitUpsideDown"
        case .landscapeLeft:
            orientationLabel.text="LandscapeLeft"
        case .landscapeRight:
            orientationLabel.text="LandscapeRight"
        case .faceUp:
            orientationLabel.text="FaceUp"
        case .faceDown:
            orientationLabel.text="FaceDown"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //摇晃开始
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        motionBeganCount+=1
        motionBeganCountLabel.text="\(motionBeganCount)"
    }
    
    //摇晃结束
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        motionEndedCount+=1
        motionEndedCountLabel.text="\(motionEndedCount)"
    }
    
    //摇晃被意外终止
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        motionCancelledCount+=1
        motionCancelledCountLabel.text="\(motionCancelledCount)"
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
