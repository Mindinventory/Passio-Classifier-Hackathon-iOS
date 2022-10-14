//
//  SuperVC.swift
//  YogaPose
//
//  Created by Harsh on 30/09/22.
//

import UIKit

class SuperVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.backgroundColor = .viewBgColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont.custom(name: FontName.DMSansBold, size: 28)]
    }
}
extension SuperVC {
    
    func NavigateToAnotherView(_ Viewcontroller:UIViewController){
        self.navigationController?.pushViewController(Viewcontroller, animated: true)
    }
    
}
