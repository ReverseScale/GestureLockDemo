//
//  LockViewController.swift
//  GestureLockDemo
//
//  Created by WhatsXie on 2017/10/27.
//  Copyright © 2017年 R.S. All rights reserved.
//

import UIKit

let userName = "user"

class LockViewController: UIViewController,drawViewDelegate {

    var tag = 0
    
    //标题
    @IBOutlet weak var titleLable: UILabel!
    ///每次触摸后的反馈
    @IBOutlet weak var resultLable: UILabel!
    ///忘记密码
    @IBAction func forgotSecret(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch tag {
        case 100://设置密码
            titleLable.text = "设置密码"
            resultLable.text = "请滑动设置新密码"
            break
        case 101://验证密码
            titleLable.text = "验证密码"
            resultLable.text = "请滑动输入密码"
            break
        case 102://忘记密码
            titleLable.text = "忘记密码"
            resultLable.text = "请输入旧密码"
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    var updataTag = 0//修改时用到
    //实现协议
    func lockViewDidFinish(drawView: DrawView, path: NSString) {
     
        if path.length < 4 {
            resultLable.text = "请至少连接4个点!"
            resultLable.textColor = UIColor.red
        }else{
            if UserDefaults.standard.object(forKey: userName) == nil{
                resultLable.text = "请输入刚才的密码"
                resultLable.textColor = UIColor.orange
                //存入
                UserDefaults.standard.set(path, forKey: userName)
            }else if (UserDefaults.standard.object(forKey: userName) as AnyObject).isEqual(path) != true{
                resultLable.textColor = UIColor.red
                
                if tag == 100 {
                    resultLable.text = "密码不一至，请输新输入"
                }else if tag == 101{
                    resultLable.text = "验证失败"
                }else{
                    if updataTag == 0 {
                        resultLable.text = "旧密码输入错误"
                    }else{
                        resultLable.text = "密码不一至，请新新输入"
                    }
                }
            }else{//两次密码不一至
                resultLable.textColor = UIColor.orange
                if tag == 100 {
                    resultLable.text = "密码设置成功"
                    //自动返回
                    autoBack()
                }else if tag == 101{
                    resultLable.text = "密码验证成功"
                    autoBack()
                }else{
                    if updataTag == 0{
                        resultLable.text = "旧密码输入正确，请滑动设置新密码"
                        updataTag = 1
                        
                        //清空文件密码
                        UserDefaults.standard.set(nil, forKey: userName)
                    }else{
                        resultLable.text = "设置新密码成功"
                        autoBack()
                    }
                }
            }
        }
    }
    
    func autoBack() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LockViewController.forgotSecret), userInfo: nil
            , repeats: false)
    }

}
