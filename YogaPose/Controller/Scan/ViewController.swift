//
//  ViewController.swift
//  YogaPose
//
//  Created by Harsh on 30/09/22.
//

import UIKit

final class ViewController: SuperVC {

    //MARK: - Outlets -
    @IBOutlet weak var viewYogaPoseIntro: UIView!
    @IBOutlet weak var txtViewIntro: UITextView!
    @IBOutlet weak var btnScan: UIButton!
    
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
        txtViewIntro.layer.cornerRadius = 30.0
        txtViewIntro.font = UIFont.custom(name: .DMSansRegular, size: 18)
        txtViewIntro.text = "The word 'Yoga' is derived from the Sanskrit root 'Yuj', meaning 'to join' or 'to yoke' or 'to unite'. As per Yogic scriptures the practice of Yoga leads to the union of individual consciousness with that of the Universal Consciousness, indicating a perfect harmony between the mind and body, Man & Nature."
        txtViewIntro.textColor = .textColor
        
        btnScan.setTitle(scanTitle, for: .normal)
        btnScan.titleLabel?.font = UIFont.custom(name: FontName.DMSansMedium, size: 24)
        btnScan.backgroundColor = .btnColor
        btnScan.layer.cornerRadius = 16.0
    }
    
    //MARK: - Button actions -
    @IBAction func btnScanClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "YogaPoseDetailsVC") as? YogaPoseDetailsVC
        NavigateToAnotherView(vc ?? UIViewController())
    }
}

