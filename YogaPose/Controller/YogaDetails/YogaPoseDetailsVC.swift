//
//  YogaPoseDetailsVC.swift
//  YogaPose
//
//  Created by Harsh on 30/09/22.
//

import UIKit
import PassioPlatformSDK

protocol ClosePopUpDelegate: AnyObject {
    
    func onCloseTapped()
}

final class YogaPoseDetailsVC: SuperVC {
    
    //MARK: - Outlets -
    @IBOutlet weak var viewYogaDescription: UIView!
    @IBOutlet weak var lblAsanaName: UILabel!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var btnKnowMore: CustomButton!
    @IBOutlet weak var btnMoreYoga: CustomButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var imgYogaPose: UIImageView!
    
    weak var delegate: ClosePopUpDelegate?
    var passioId = ""
    
    //MARK: - View life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
        showDescriptionView()
        configNavigationView()
    }
    deinit {
        print("deinit")
    }
    //MARK: - Config functions -
    private func configUI(){
        
        self.view.backgroundColor = .viewBgColor
        self.navigationController?.navigationBar.isHidden = true
        
        imgYogaPose.layer.cornerRadius = imgYogaPose.frame.size.height / 2
        
        lblOverView.text = overViewTitle
        lblOverView.font = UIFont.custom(name: .DMSansBold, size: 18)
        
        viewYogaDescription.layer.cornerRadius = 30.0
        viewYogaDescription.frame = CGRect(x: self.view.center.x, y: self.view.frame.height + 400, width: 400, height: 400)
        
        btnClose.isHidden = true
        
        lblAsanaName.text = AppDelegate.allYogas.first{$0.passioID == passioId}?.name
        lblAsanaName.font = UIFont.custom(name: FontName.DMSansBold, size: 26)
        imgYogaPose.image = UIImage(named: passioId)
        btnKnowMore.setTitle(knowMoreTitle, for: .normal)
        btnMoreYoga.setTitle(moreYogaTitle, for: .normal)
        
        txtViewDescription.alpha = 0.8
        txtViewDescription.font = UIFont.custom(name: .DMSansRegular, size: 18)
        txtViewDescription.text = AppDelegate.allYogas.first{$0.passioID == passioId}?.description
    }
    private func configNavigationView(){
        
        self.navigationController?.navigationBar.tintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    private func showDescriptionView(){
        
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            self.viewYogaDescription.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 400, height: 400)
        } completion: { _ in
            self.btnClose.isHidden = false
        }
    }
}
//MARK: - Button actions -
extension YogaPoseDetailsVC{
    
    @IBAction func btnKnowMoreClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "YogaBenefitsVC") as! YogaBenefitsVC
        vc.passioId = passioId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnMoreYogaClicked(_ sender: UIButton){
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "YogaListVC") as? YogaListVC
        let navController = UINavigationController(rootViewController: vc ?? UIViewController())
        navController.modalPresentationStyle = .fullScreen
        pvc?.present(navController, animated: true, completion: nil)
    }
    @IBAction func btnCloseClicked(_ sender: UIButton){
        self.dismiss(animated: true)
        delegate?.onCloseTapped()
    }
}
