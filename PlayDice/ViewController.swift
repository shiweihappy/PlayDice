//
//  ViewController.swift
//  PlayDice
//
//  Created by lsw on 14-12-8.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import UIKit

enum selectType {
    case Big
    case Small
    case Same
}

class ViewController: UIViewController {

    @IBOutlet var img1:UIImageView?
    
    @IBOutlet var img2:UIImageView?
    
    @IBOutlet var img3:UIImageView?
    
    @IBOutlet var playerLabel:UILabel?
    
    @IBOutlet var bossLabel:UILabel?
    
    
    var timer:NSTimer?
    var imageIndex = 0
    var type = selectType.Big
    let price = 30
    var playerMoney = 1000
    var bossMoney = 1000
    
    func judgeImage(dic1:Int, dic2:Int, dic3:Int) {
        
        switch (type) {
        case selectType.Same:
            if dic1 == dic2 && dic1 == dic3 {
                playerMoney += price
                bossMoney -= price
            } else {
                playerMoney -= price
                bossMoney += price
            }
        case selectType.Big:
            if (dic1 + dic2 + dic3) > 11 {
                playerMoney += price
                bossMoney -= price
            } else {
                playerMoney -= price
                bossMoney += price
            }
        case selectType.Small:
            if (dic1 + dic2 + dic3) > 11 {
                playerMoney -= price
                bossMoney += price
            } else {
                playerMoney += price
                bossMoney -= price
            }
        default:
            break
        }
        
        if playerMoney <= 0 {
            playerLabel?.text = "You lose!"
        } else {
            playerLabel?.text = String(playerMoney)
        }
        
        if bossMoney <= 0 {
            bossLabel?.text = "You win!"
        } else {
            bossLabel?.text = String(bossMoney)
        }
        
    }
    
    func changeImage() {
        var i1 = arc4random() % 6 + 1
        var name = "icon_\(i1).png"
        var image = UIImage(named: name)
        img1?.image = image
        
        
        var i2 = arc4random() % 6 + 1
        name = "icon_\(i2).png"
        image = UIImage(named: name)
        img2?.image = image
        
        
        var i3 = arc4random() % 6 + 1
        name = "icon_\(i3).png"
        image = UIImage(named: name)
        img3?.image = image
        
        ++imageIndex
        if imageIndex > 30 {
            timer?.invalidate()
            imageIndex = 0
            
            judgeImage(Int(i1), dic2: Int(i2), dic3: Int(i3))
        }
    }
    
    @IBAction func buyBig(sender:AnyObject) {
        if playerMoney <= 0  || bossMoney <= 0{
            return
        }
        
        type = selectType.Big
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    @IBAction func buySame(sender:AnyObject) {
        if playerMoney <= 0  || bossMoney <= 0{
            return
        }
        type = selectType.Same
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    @IBAction func buySmall(sender:AnyObject) {
        if playerMoney <= 0  || bossMoney <= 0{
            return
        }
        type = selectType.Small
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

