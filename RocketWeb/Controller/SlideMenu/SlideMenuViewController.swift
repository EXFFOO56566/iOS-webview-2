//
//  SliderViewController.swift
//  RocketWeb
//
//  Created by Md Imran Choudhury on 27/3/20.
//  Copyright © 2020 Md Imran Choudhury. All rights reserved.
//

import UIKit
import RocketWebLib

protocol SlideMenuViewControllerDelegate{
    func didMenuClick(menu: MenuItem)
}

class SlideMenuViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtDetails: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    
    var delegate: SlideMenuViewControllerDelegate?
    private var menuList = AppDataInstance.getInstance.configureData.menus
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insetsLayoutMarginsFromSafeArea = false
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.viewHeader.layer.insertSublayer(getThemeColor(bounds: self.viewHeader.bounds, isVertical: true), at:0)
        self.txtTitle.text = AppDataInstance.getInstance.configureData.menu_header_title
        self.txtDetails.text = AppDataInstance.getInstance.configureData.menu_header_details
    }
}

extension SlideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell else {return UITableViewCell.init()}

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setData(menuItem: (menuList?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didMenuClick(menu: (menuList?[indexPath.row])!)
        dismiss(animated: true, completion: nil)
        
    }
}
