//
//  YogaBenefitsVC.swift
//  YogaPose
//
//  Created by Harsh on 12/10/22.
//

import UIKit

final class YogaBenefitsVC: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var imgYogaPose: UIImageView!
    @IBOutlet weak var lblAsKnownAs: UILabel!
    @IBOutlet weak var lblYogaPoseSynonyms: UILabel!
    @IBOutlet weak var lblYogaTypeTitle: UILabel!
    @IBOutlet weak var lblYogaTypeName: UILabel!
    @IBOutlet weak var lblBenefits: UILabel!
    @IBOutlet weak var txtViewBenefits: UITextView!
    @IBOutlet weak var btnKnowMore: CustomButton!
    
    var passioId = ""
    
    //MARK: - view life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        addYogaInformation()
    }
    
    //MARK: - Config functions -
    private func configNavigation(){
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont.custom(name: FontName.DMSansBold, size: 20)]
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configUI(){
        
        lblAsKnownAs.text = asKnownTitle
        lblAsKnownAs.font = UIFont.custom(name: FontName.DMSansBold, size: 18.0)
        lblYogaPoseSynonyms.font = UIFont.custom(name: FontName.DMSansRegular, size: 18.0)
        lblYogaTypeTitle.text = yogaTypeTitle
        lblYogaTypeTitle.font = UIFont.custom(name: FontName.DMSansBold, size: 18.0)
        lblYogaTypeName.font = UIFont.custom(name: FontName.DMSansRegular, size: 18.0)
        lblBenefits.text = benefitsTitle
        lblBenefits.font = UIFont.custom(name: FontName.DMSansBold, size: 18.0)
        txtViewBenefits.font = UIFont.custom(name: FontName.DMSansRegular, size: 18.0)
        btnKnowMore.setTitle(knowMoreTitle, for: .normal)
        btnKnowMore.layer.cornerRadius = 0
    }
    
    private func addYogaInformation(){
        
        if let data = AppDelegate.allYogas.first(where: {$0.passioID == passioId}) {
            self.navigationItem.title = data.name ?? ""
            imgYogaPose.image = UIImage(named: data.passioID ?? "")
            lblYogaPoseSynonyms.text = "\(data.english ?? "") , \(data.sanskrit ?? "")"
            lblYogaTypeName.text = "\(data.type ?? "")"
            txtViewBenefits.text = data.benefits ?? ""
        }
    }
    
    @IBAction func btnKnowMoreTapped(_ sender: UIButton) {
        guard let urlString = AppDelegate.allYogas.first(where: {$0.passioID == passioId})?.url else{return}
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        
        self.dismiss(animated: true)
    }
}

