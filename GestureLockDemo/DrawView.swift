//
//  DrawView.swift
//  swift手势解锁
//
//  Created by m on 2017/2/26.
//  Copyright © 2017年 XLJ. All rights reserved.
//

import UIKit
//声明一个协议
@objc protocol drawViewDelegate{
    //把视图和路径传过去
    func lockViewDidFinish(drawView:DrawView, path:NSString)
}

class DrawView: UIView {

    //设置代理
    @IBOutlet weak var lockDelegate:(drawViewDelegate)!
    //保存选中的按钮
    var btnSelectArray:(NSMutableArray) = []
    
    //required必须实现的，storyBoard,XIB关联，必须实现此方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(DrawView.cleanBtns), name: NSNotification.Name(rawValue: "whClean"), object: nil)
        //加载
        createButton()
    }
    //清空按钮，并重绘
    func cleanBtns(){
        self.btnSelectArray.removeAllObjects()
        self.setNeedsDisplay()
    }

    //自定义方法:创建九宫格
    func createButton(){
        let secret = 0
        for row in 0...2{//行
            for col in 0...2{//列
                //按钮的位置和图片
                //间距
                let btnDistance = 100
                let firstBtnX:CGFloat = (self.frame.size.width - 100 * 3) / 4
                let firstBtnY:CGFloat = 15
                let tempX:(CGFloat) = firstBtnX + CGFloat(col * btnDistance) - 7.0
                let tempY:(CGFloat) = firstBtnY + CGFloat(row * btnDistance)
                //创建按钮
                let button = UIButton(type:.custom)
                
                button.isUserInteractionEnabled = false
                button.frame = CGRect(x: tempX, y: tempY, width:100, height:100)

                button.setImage(UIImage(named:"gesture_node_normal"), for: UIControlState.normal)
                
                button.setImage(UIImage(named:"gesture_node_highlighted"), for: UIControlState.selected)
                //用来当密码
                button.tag += secret
                self.addSubview(button)
                
            }
        }
    }
    func pointWithTouches(touches:NSSet) -> CGPoint{

        let touch = touches.anyObject() as? UITouch!
        
        //解包touch
        let pos:(CGPoint) = touch!.location(in: touch!.view)
    
        return pos
    }
    
    //获取触摸到的按钮
    func buttonWithPoint(point: CGPoint) -> UIButton?{
        for btn in self.subviews{
            if btn.frame.contains(point){
                return btn as? UIButton
            }
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //取出触摸点
        let pos:(CGPoint) = self.pointWithTouches(touches: touches as NSSet)
        
        let btn:(UIButton)? = self.buttonWithPoint(point: pos)
        if self.btnSelectArray.contains(btn!) == false {
            //表示触摸的按钮没有在集合中
            addBtn(btn)
        }
        //刷新显示
        self.setNeedsDisplay()
    }
    
    func addBtn(_ btn: UIButton!){
        //按钮选中
        btn!.isSelected = true
        
        //加载到可变数组中
        self.btnSelectArray.add(btn!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos:(CGPoint) = self.pointWithTouches(touches: touches as NSSet)
        let btn:(UIButton)?=self.buttonWithPoint(point: pos)
        //按钮未被选中，并且按钮不为空
        if ((btn != nil) && (btn?.isSelected == false)) {
            addBtn(btn)
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //判断有无代理
        if lockDelegate != nil {
            let str:(NSMutableString) = NSMutableString()
            if self.btnSelectArray.count > 0 {
                //遍历
                for index in 0...self.btnSelectArray.count - 1{
                    let btn:(UIButton) = self.btnSelectArray.object(at: index) as! UIButton
                    //把按钮的tag值拼接到可变字符中
                    str.appendFormat("%ld",btn.tag)
                }
                
                if str.length > 0{
                    //发送消息
                    lockDelegate.lockViewDidFinish(drawView: self, path: str)
                }
            }
        }
        
        //把选中的按钮设置为默认的状态
        if self.btnSelectArray.count > 0 {
            //遍历数组
            for index in 0...self.btnSelectArray.count - 1{
                let btn:(UIButton) = self.btnSelectArray.object(at: index) as! UIButton
                btn.isSelected = false
            }
        }
        //清空数组
        self.btnSelectArray.removeAllObjects()
        //重绘
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        //进行绘制
        if self.btnSelectArray.count == 0{
            //没有选中的按钮就不绘制
            return
        }
        //有按钮就进行绘制
        //创建路径
        let path:(UIBezierPath) = UIBezierPath()
        for index in 0...self.btnSelectArray.count - 1 {
            let btn:(UIButton) = self.btnSelectArray.object(at: index) as! UIButton
            //第一个按钮(每次绘制的起点)
            if index == 0 {
                path.move(to: btn.center)
            }else{
                path.addLine(to: btn.center)
            }
        }
        path.lineWidth = 5//线宽
        UIColor.blue.set()//颜色
        //绘制
        path.stroke()
    }
}
