//
//  ThemeViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 25/2/20.
//  Copyright © 2020 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

class ThemeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    final var TAG: String = "---ShopController"

    @IBOutlet var btnBack: UIImageView!
    @IBOutlet var viewCollectionColor: UICollectionView!
    @IBOutlet var viewToolbar: UIView!
    
    private var colorItems: Array<String> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        initView()
    }
    
    private func initView(){
        self.viewCollectionColor.isPrefetchingEnabled = true
        self.viewCollectionColor.delegate = self
        self.viewCollectionColor.dataSource = self
        self.viewCollectionColor.register(UINib.init(nibName: "ThemeColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThemeColorCollectionViewCell")

    
        self.btnBack.isUserInteractionEnabled = true
        self.btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnBackClick)))
        
        self.colorItems.removeAll()
        self.colorItems.append("THEME_PRIMARY")
        for i in( 1...17){
            self.colorItems.append("GRADIENT_\(i)")
        }
        for i in( 1...42){
            self.colorItems.append("SOLID_\(i)")
        }
    }
    
    @objc private func btnBackClick(_ recognizer: UITapGestureRecognizer) {
        exit(0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = (self.view.frame.size.width - 12 * 3) / 2 //some width
        let height = width * 2 //ratio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorItems.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeColorCollectionViewCell", for: indexPath) as! ThemeColorCollectionViewCell
        
        cell.imgDone.visibility = .gone
        let colorName = colorItems[indexPath.row] as String
        switch colorName {
         case Constants.THEME_PRIMARY:
            cell.viewColor.backgroundColor =  UIColor(named: "colorPrimary")
         case Constants.THEME_GRADIENT_1:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient1_primary")
         case Constants.THEME_GRADIENT_2:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient2_primary")
         case Constants.THEME_GRADIENT_3:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient3_primary")
         case Constants.THEME_GRADIENT_4:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient4_primary")
         case Constants.THEME_GRADIENT_5:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient5_primary")
         case Constants.THEME_GRADIENT_6:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient6_primary")
         case Constants.THEME_GRADIENT_7:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient7_primary")
         case Constants.THEME_GRADIENT_8:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient8_primary")
         case Constants.THEME_GRADIENT_9:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient9_primary")
         case Constants.THEME_GRADIENT_10:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient10_primary")
         case Constants.THEME_GRADIENT_11:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient11_primary")
         case Constants.THEME_GRADIENT_12:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient12_primary")
         case Constants.THEME_GRADIENT_13:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient13_primary")
         case Constants.THEME_GRADIENT_14:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient14_primary")
         case Constants.THEME_GRADIENT_15:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient15_primary")
         case Constants.THEME_GRADIENT_16:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient16_primary")
         case Constants.THEME_GRADIENT_17:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_gradient17_primary")
             
             
         case Constants.THEME_SOLID_1:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid1_primary")
         case Constants.THEME_SOLID_2:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid2_primary")
         case Constants.THEME_SOLID_3:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid3_primary")
         case Constants.THEME_SOLID_4:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid4_primary")
         case Constants.THEME_SOLID_5:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid5_primary")
         case Constants.THEME_SOLID_6:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid6_primary")
         case Constants.THEME_SOLID_7:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid7_primary")
         case Constants.THEME_SOLID_8:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid8_primary")
         case Constants.THEME_SOLID_9:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid9_primary")
         case Constants.THEME_SOLID_10:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid10_primary")
         case Constants.THEME_SOLID_11:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid11_primary")
         case Constants.THEME_SOLID_12:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid12_primary")
         case Constants.THEME_SOLID_13:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid13_primary")
         case Constants.THEME_SOLID_14:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid14_primary")
         case Constants.THEME_SOLID_15:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid15_primary")
         case Constants.THEME_SOLID_16:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid16_primary")
         case Constants.THEME_SOLID_17:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid17_primary")
         case Constants.THEME_SOLID_18:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid18_primary")
         case Constants.THEME_SOLID_19:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid10_primary")
         case Constants.THEME_SOLID_20:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid20_primary")
         case Constants.THEME_SOLID_21:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid21_primary")
         case Constants.THEME_SOLID_22:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid22_primary")
         case Constants.THEME_SOLID_23:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid23_primary")
         case Constants.THEME_SOLID_24:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid24_primary")
         case Constants.THEME_SOLID_25:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid25_primary")
         case Constants.THEME_SOLID_26:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid26_primary")
         case Constants.THEME_SOLID_27:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid27_primary")
         case Constants.THEME_SOLID_28:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid28_primary")
         case Constants.THEME_SOLID_29:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid29_primary")
         case Constants.THEME_SOLID_30:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid30_primary")
         case Constants.THEME_SOLID_31:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid31_primary")
         case Constants.THEME_SOLID_32:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid32_primary")
         case Constants.THEME_SOLID_33:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid33_primary")
         case Constants.THEME_SOLID_34:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid34_primary")
         case Constants.THEME_SOLID_35:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid35_primary")
         case Constants.THEME_SOLID_36:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid36_primary")
         case Constants.THEME_SOLID_37:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid37_primary")
         case Constants.THEME_SOLID_38:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid38_primary")
         case Constants.THEME_SOLID_39:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid39_primary")
         case Constants.THEME_SOLID_40:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid40_primary")
         case Constants.THEME_SOLID_41:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid41_primary")
         case Constants.THEME_SOLID_42:
            cell.viewColor.backgroundColor =  UIColor(named: "infix_solid42_primary")
        
         default:
            cell.viewColor.backgroundColor =  UIColor(named: "colorPrimary")
         }
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewThemeClick(sender:))))

        return cell
    }
    
    @objc private func viewThemeClick(sender: UITapGestureRecognizer) {
        
       let cell = sender.view as! ThemeColorCollectionViewCell
       let indexPath = self.viewCollectionColor?.indexPath(for: cell)
        
       let preference = UserDefaults.standard
       let selectTheme = colorItems[indexPath?.row ?? 0]
       
       switch selectTheme {
       case Constants.THEME_PRIMARY:
           preference.set("colorPrimary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("colorPrimaryDark" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_1:
           preference.set("infix_gradient1_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient1_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_2:
           preference.set("infix_gradient2_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient2_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_3:
           preference.set("infix_gradient3_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient3_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_4:
           preference.set("infix_gradient4_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient4_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_5:
           preference.set("infix_gradient5_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient5_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_6:
           preference.set("infix_gradient6_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient6_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_7:
           preference.set("infix_gradient7_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient7_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_8:
           preference.set("infix_gradient8_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient8_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_9:
           preference.set("infix_gradient9_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient9_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_10:
           preference.set("infix_gradient10_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient10_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_11:
           preference.set("infix_gradient11_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient11_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_12:
           preference.set("infix_gradient12_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient12_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_13:
           preference.set("infix_gradient13_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient13_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_14:
           preference.set("infix_gradient14_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient14_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_15:
           preference.set("infix_gradient15_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient15_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_16:
           preference.set("infix_gradient16_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient16_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_GRADIENT_17:
           preference.set("infix_gradient17_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_gradient17_secondary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
           
           
       case Constants.THEME_SOLID_1:
           preference.set("infix_solid1_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid1_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_2:
           preference.set("infix_solid2_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid2_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_3:
           preference.set("infix_solid3_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid3_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_4:
           preference.set("infix_solid4_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid4_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_5:
           preference.set("infix_solid5_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid5_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_6:
           preference.set("infix_solid6_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid6_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_7:
           preference.set("infix_solid7_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid7_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_8:
           preference.set("infix_solid8_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid8_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_9:
           preference.set("infix_solid9_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid9_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_10:
           preference.set("infix_solid10_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid10_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_11:
           preference.set("infix_solid11_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid11_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_12:
           preference.set("infix_solid12_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid12_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_13:
           preference.set("infix_solid13_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid13_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_14:
           preference.set("infix_solid14_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid14_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_15:
           preference.set("infix_solid15_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid15_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_16:
           preference.set("infix_solid16_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid16_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_17:
           preference.set("infix_solid17_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid17_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_18:
           preference.set("infix_solid18_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid18_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_19:
           preference.set("infix_solid19_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid19_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_20:
           preference.set("infix_solid20_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid20_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_21:
           preference.set("infix_solid21_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid21_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_22:
           preference.set("infix_solid22_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid22_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_23:
           preference.set("infix_solid23_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid23_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_24:
           preference.set("infix_solid24_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid24_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_25:
           preference.set("infix_solid25_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid25_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_26:
           preference.set("infix_solid26_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid26_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_27:
           preference.set("infix_solid27_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid27_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_28:
           preference.set("infix_solid28_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid28_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_29:
           preference.set("infix_solid29_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid29_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_30:
           preference.set("infix_solid30_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid30_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_31:
           preference.set("infix_solid31_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid31_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_32:
           preference.set("infix_solid32_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid32_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_33:
           preference.set("infix_solid33_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid33_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_34:
           preference.set("infix_solid34_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid34_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_35:
           preference.set("infix_solid35_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid35_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_36:
           preference.set("infix_solid36_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid36_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_37:
           preference.set("infix_solid37_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid37_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_38:
           preference.set("infix_solid38_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid38_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_39:
           preference.set("infix_solid39_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid39_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_40:
           preference.set("infix_solid40_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid40_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_41:
           preference.set("infix_solid41_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid41_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       case Constants.THEME_SOLID_42:
           preference.set("infix_solid42_primary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("infix_solid42_primary" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
      
       default:
           preference.set("colorPrimary", forKey: Constants.KEY_COLOR_PRIMARY)
           preference.set("colorPrimaryDark" , forKey: Constants.KEY_COLOR_PRIMARY_DARK)
       }
        
      print(preference.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window")
      let colorPrimary =  UIColor(named: (
                  preference.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))!.cgColor
      let colorPrimaryDark = UIColor(named: (
                  preference.string(forKey: Constants.KEY_COLOR_PRIMARY_DARK) ?? "bg_window"))!.cgColor
      
      let gradientLayer = CAGradientLayer()
      var bounds =  self.viewToolbar.bounds
      bounds.size.height += UIApplication.shared.statusBarFrame.size.height
      gradientLayer.frame = bounds
      gradientLayer.colors = [colorPrimary, colorPrimaryDark]
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
      
      //self.view_toolbar.layer.insertSublayer(gradientLayer, at: 0)
      self.viewToolbar.backgroundColor = UIColor(named: (
            preference.string(forKey: Constants.KEY_COLOR_PRIMARY) ?? "bg_window"))
    }
}
