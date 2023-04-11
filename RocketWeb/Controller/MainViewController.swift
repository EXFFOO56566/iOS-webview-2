//
//  ViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 01/01/20.
//  E-mail: imrankst1221@gmail.com
//  Copyright © 2019 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
        initSetup()
    }
	
	func initSetup(){
		let config = ConfigureRocketWeb()
		config.readConfiguration(fileName: "rocket_web")
		
		DispatchQueue.main.async(){
		   if(AppDataInstance.getInstance.configureData.splash_screen == true){
			   self.performSegue(withIdentifier: "toSplashViewController", sender: self)
		   }else{
			   self.performSegue(withIdentifier: "toHomeViewController", sender: self)
		   }
	   }
    }
    
    func gotoNext(){
        DispatchQueue.main.async(){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            self.present(nextViewController, animated:true, completion:nil)
            self.navigationController?.pushViewController(SplashViewController(), animated: true)
            self.performSegue(withIdentifier: "MainToSplashIdentifier", sender: self)
        }
    }
}
