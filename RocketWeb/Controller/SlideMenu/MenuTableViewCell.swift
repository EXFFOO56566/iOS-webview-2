//
//  MenuTableViewCell.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 11/2/20.
//  Copyright © 2020 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

class MenuTableViewCell: UITableViewCell {
    private var menuItem: MenuItem!

    @IBOutlet var txtName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    
    func setData(menuItem: MenuItem){
        //let colorPrimary =  UIColor(named: (UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))
        
        self.menuItem = menuItem
        self.txtName.text = menuItem.name
        
        switch menuItem.url {
            case "HOME":
                self.imgItem.image = UIImage(named: "ic_home_menu")
            
            case "ABOUT":
                self.imgItem.image = UIImage(named: "ic_info_menu")
            
            case "RATE":
                self.imgItem.image = UIImage(named: "ic_rate_menu")
            
            case "SHARE":
                self.imgItem.image = UIImage(named: "ic_share_menu")
            
            case "EXIT":
                self.imgItem.image = UIImage(named: "ic_exit_menu")
            
            default:
                self.imgItem.image = UIImage(named: "ic_label_menu")
        }
    }
    
}
