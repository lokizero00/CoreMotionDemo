//
//  FirstViewController.swift
//  CoreMotionDemo
//
//  Created by lokizero00 on 2017/11/30.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit
import CoreMotion

class FirstViewController: UIViewController {
    @IBOutlet weak var label_X:UILabel?
    @IBOutlet weak var label_Y:UILabel?
    @IBOutlet weak var label_Z:UILabel?
    
    @IBOutlet weak var label_X_max:UILabel?
    @IBOutlet weak var label_Y_max:UILabel?
    @IBOutlet weak var label_Z_max:UILabel?
    
    @IBOutlet weak var label_X_min:UILabel?
    @IBOutlet weak var label_Y_min:UILabel?
    @IBOutlet weak var label_Z_min:UILabel?
    
    var x_max:Double=0
    var y_max:Double=0
    var z_max:Double=0
    
    var x_min:Double=0
    var y_min:Double=0
    var z_min:Double=0
    
    //加速计管理者，所有的操作都会由这个motionManager接管
    var motionManager:CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title="加速计"
        self.view.backgroundColor=UIColor.white
        initMotionManager()
    }

    func initMotionManager(){
        //注意，CMMotionManager不是单例
        motionManager=CMMotionManager()
        //设置检测时间
        motionManager.accelerometerUpdateInterval=0.1
        
        //判断设备是否可以使用加速计
        if !motionManager.isAccelerometerAvailable {
            motionNotSupportAlert()
        }else{
            //获取主线程并发队列，在主线程里更新UI
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {
                (accelermoterData:CMAccelerometerData?,error:Error?)->Void in
                if error != nil{
                    //停止使用加速计
                    self.motionManager.stopAccelerometerUpdates()
                }else{
                    self.label_X?.text="\(accelermoterData!.acceleration.x)"
                    self.label_Y?.text="\(accelermoterData!.acceleration.y)"
                    self.label_Z?.text="\(accelermoterData!.acceleration.z)"
                    
                    if accelermoterData!.acceleration.x > self.x_max {
                        self.x_max=accelermoterData!.acceleration.x
                    }
                    if accelermoterData!.acceleration.y > self.y_max {
                        self.y_max=accelermoterData!.acceleration.y
                    }
                    if accelermoterData!.acceleration.z > self.z_max {
                        self.z_max=accelermoterData!.acceleration.z
                    }
                    
                    if self.x_min > accelermoterData!.acceleration.x{
                        self.x_min=accelermoterData!.acceleration.x
                    }
                    if self.y_min > accelermoterData!.acceleration.y{
                        self.y_min=accelermoterData!.acceleration.y
                    }
                    if self.z_min > accelermoterData!.acceleration.z{
                        self.z_min=accelermoterData!.acceleration.z
                    }
                    
                    self.label_X_max?.text="\(self.x_max)"
                    self.label_Y_max?.text="\(self.y_max)"
                    self.label_Z_max?.text="\(self.z_max)"
                    
                    self.label_X_min?.text="\(self.x_min)"
                    self.label_Y_min?.text="\(self.y_min)"
                    self.label_Z_min?.text="\(self.z_min)"
                }
            })
        }
    }
    
    func motionNotSupportAlert(){
        let alertVC=UIAlertController(title: "警告", message: "您的设备不支持加速计！", preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction)->Void in
            
        })
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
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
