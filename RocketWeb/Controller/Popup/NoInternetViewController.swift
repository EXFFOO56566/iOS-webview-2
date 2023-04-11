//
//  AboutViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 21/4/20.
//  Copyright © 2020 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

protocol NoInternetViewControllerDelegate {
    func tryAgainClick(isInternetConnection: Bool)
}

class NoInternetViewController: UIViewController {

    @IBOutlet weak var imgNoInternet: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDetails: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    
    var delegate: NoInternetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    private func initView(){
        let colorPrimary =  UIColor(named: (
                          UserDefaults.standard.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))
        self.imgNoInternet.tintColor = colorPrimary
        self.btnTryAgain.backgroundColor = colorPrimary
        self.txtTitle.text = AppDataInstance.getInstance.configureData.no_internet_title
        self.txtDetails.text = AppDataInstance.getInstance.configureData.no_internet_details
        self.btnTryAgain.setTitle(AppDataInstance.getInstance.configureData.try_again_button, for: .normal)
    }
    
    
    @IBAction func btnTryAgainClick(_ sender: Any) {
        if (InternetConnectionManager.isConnectedToNetwork()){
            dismiss(animated: true)
            self.delegate?.tryAgainClick(isInternetConnection: true)
        }else{
            showToast(viewContoler: self, message: "No Internet!")
            self.delegate?.tryAgainClick(isInternetConnection: false)
        }
    }
    
}
