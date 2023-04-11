//
//  AboutViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 21/4/20.
//  Copyright © 2020 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

class AboutViewController: UIViewController {

    @IBOutlet weak var txtAppName: UITextField!
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var txtDetails: UILabel!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnWebsite: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    private func initView(){
        let colorPrimary =  UIColor(named: (
                          UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))
        self.btnPhone.tintColor = colorPrimary
        self.btnEmail.tintColor = colorPrimary
        self.btnWebsite.tintColor = colorPrimary
        
        self.txtAppName.text = Bundle.appName()
        self.txtUrl.text = AppDataInstance.getInstance.configureData.about_website
        self.txtDetails.text = AppDataInstance.getInstance.configureData.about_text
        
    }

    @IBAction func btnDoneClick(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnPhoneClick(_ sender: Any) {
        if let num = AppDataInstance.getInstance.configureData.about_mobile{
            dialNumber(viewcontroller: self, number: num)
        }
        
    }
    
    @IBAction func btnEmailClick(_ sender: Any) {
        if let email = AppDataInstance.getInstance.configureData.about_email{
            sendEmail(viewcontroller: self, email: email)
        }
    }
    
    @IBAction func btnWebsiteClick(_ sender: Any) {
        if let url = URL(string: AppDataInstance.getInstance.configureData.about_website ?? ""){
            browseUrlExternal(viewcontroller: self, url: url)
        }
    }
}
