//
//  TableViewController.swift
//  GestureLockDemo
//
//  Created by WhatsXie on 2017/10/27.
//  Copyright © 2017年 R.S. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func goPage(tag:Int) {
        let lockVC = LockViewController(nibName:"LockViewController", bundle:nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "whClean"), object: nil)
        switch tag {
        case 100:
            lockVC.tag = 100
            break
        case 101:
            lockVC.tag = 101
            break
        case 102:
            lockVC.tag = 102
            break
            
        default:
            break
        }
        self.present(lockVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goPage(tag:indexPath.row + 100)
    }

}
