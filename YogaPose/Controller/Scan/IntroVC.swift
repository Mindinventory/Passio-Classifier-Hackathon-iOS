//
//  ViewController.swift
//  YogaPose
//
//  Created by Harsh on 30/09/22.
//

import UIKit

final class IntroVC: SuperVC {

    //MARK: - Outlets -
    @IBOutlet weak var viewYogaPoseIntro: UIView!
    @IBOutlet weak var txtViewIntro: UITextView!
    @IBOutlet weak var btnScan: CustomButton!
    
    //MARK: - View life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configIntroView()
    }
    
    //MARK: - Config functions -
    private func configIntroView(){
        
        self.navigationItem.title = yogaIntroTitle
        self.view.backgroundColor = .viewBgColor
        
        viewYogaPoseIntro.layer.cornerRadius = 30.0
        viewYogaPoseIntro.backgroundColor = .white
        
        txtViewIntro.alpha = 0.8
        txtViewIntro.font = UIFont.custom(name: .DMSansRegular, size: 18)
        txtViewIntro.text = introTitle
        txtViewIntro.textColor = .textColor
        
        btnScan.setTitle(scanTitle, for: .normal)
    }
    
    //MARK: - Button actions -
    @IBAction func btnScanClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScanVC") as? ScanVC
        NavigateToAnotherView(vc ?? UIViewController())
    }
}

